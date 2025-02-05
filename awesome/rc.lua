-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local os = os
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
local dpi   = require("beautiful.xresources").apply_dpi

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

-- Notification setup

local nconf = naughty.config
nconf.defaults.border_width = 5
nconf.padding = 14
nconf.spacing = 8
nconf.presets.critical.bg = "#FF0000"
nconf.presets.critical.fg = "#000000"

nconf.presets.normal.bg = "#FFE900"
nconf.presets.normal.fg = "#000000"

nconf.presets.low.bg = "#00FF00"
nconf.presets.low.fg = "#000000"

-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local themes = {
    "blackburn",       -- 1
    "copland",         -- 2
    "dremora",         -- 3
    "holo",            -- 4
    "multicolor",      -- 5
    "powerarrow",      -- 6
    "powerarrow-dark", -- 7
    "rainbow",         -- 8
    "steamburn",       -- 9
    "vertex"           -- 10
}

local chosen_theme = themes[5]

-- custom
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")
-- beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
beautiful.useless_gap = 1

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.fair,
    awful.layout.suit.tile,
    -- awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- ===========================================
-- Wibar
-- ===========================================

local theme = {}
theme.customdir                                       = os.getenv("HOME") .. "/.config/awesome/custom"
theme.widget_battery                            = theme.customdir .. "/icons/battery.png"
theme.widget_mem                                = theme.customdir .. "/icons/mem.png"
theme.widget_cpu                                = theme.customdir .. "/icons/cpu.png"
theme.widget_clock                              = theme.customdir .. "/icons/clock.png"
theme.widget_net                                = theme.customdir .. "/icons/wifi.png"
theme.widget_vol                                = theme.customdir .. "/icons/volume.png"

local markup = lain.util.markup
local label_fg = "#03fcb6"


-- MEM

local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup(label_fg, " mem: ").. math.floor((mem_now.used / mem_now.total) * 100) .. "% ")
    end
})

-- CPU

local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup( markup(label_fg, " cpu: ") .. cpu_now.usage .. "% ")
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        widget:set_markup(markup(label_fg, " bat: ") .. bat_now.perc .. "% ")
    end
})


-- Pulse volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
local volume = lain.widget.pulse({
    settings = function()
    end
})

-- Pulsebar
local pulseicon = wibox.widget.imagebox(theme.widget_vol)
local pulsebar = lain.widget.pulsebar({
    settings = function()
        widget:set_markup(markup(label_fg, " vol: ") .. volume_now.left .. "% ")
    end
})

-- Network
local net_widgets = require("net_widgets")
local net_wireless = net_widgets.wireless({interface="wlan0"})

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local mytextclock = wibox.widget.textclock(markup(label_fg, " clk: ")..markup("#f6f6f6", " %B %d ") .. markup("#aa9ffb", ">") .. markup("#51a3f2", " %I:%M %p "), 1)
mytextclock.font = theme.font

-- Separator
local sep = wibox.widget {
    widget = wibox.widget.separator {
        orientation = "vertical",
        color = "#ffffff",
        forced_width = 5,
        thickness = 2,
        opacity = 0.3
    }
}







awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style = {
            fg_focus = "#000000",
            bg_focus = label_fg,
            fg_occupied = "#ffffff",
            fg_empty = "#353535",
            spacing = 6
        }
    }

    

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    -- awful.screen.set_auto_dpi_enabled( true )
    s.mywibox = awful.wibar({ 
        position = "top", 
        screen = s,
        --height = 55
    })




    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "outside",

        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            sep
        },
--        -- s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
--                        arrow(theme.bg_normal, "#343434"),
--            wibox.container.background(wibox.container.margin(wibox.widget { mailicon, theme.mail and theme.mail.widget, layout = wibox.layout.align.horizontal }, dpi(4), dpi(7)), "#343434"),
--            arrow("#343434", theme.bg_normal),
--            arrow(theme.bg_normal, "#343434"),
--            arrow("#343434", "#777E76"),
            sep,
            wibox.container.background(wibox.container.margin(wibox.widget { mem.widget, layout = wibox.layout.align.horizontal }, dpi(2), dpi(3)), beautiful.bg_normal),
            sep,
            wibox.container.background(wibox.container.margin(wibox.widget { cpu.widget, layout = wibox.layout.align.horizontal }, dpi(3), dpi(4)), beautiful.bg_normal),
            sep,
            wibox.container.background(wibox.container.margin(wibox.widget { bat.widget, layout = wibox.layout.align.horizontal }, dpi(3), dpi(4)), beautiful.bg_normal),
            sep,
            wibox.container.background(wibox.container.margin(wibox.widget { volume.widget, layout = wibox.layout.align.horizontal }, dpi(3), dpi(4)), beautiful.bg_normal),
            sep,
            wibox.container.background(wibox.container.margin(wibox.widget { net_wireless, layout = wibox.layout.align.horizontal }, dpi(3), dpi(4)), beautiful.bg_normal),
            sep,
            wibox.container.background(wibox.container.margin(wibox.widget { mytextclock, layout = wibox.layout.align.horizontal }, dpi(3), dpi(4)), beautiful.bg_normal),
            sep,

--            arrow("#4B696D", "#4B3B51"),
--            arrow("#4B3B51", "#CB755B"),
--            arrow("#CB755B", "#8DAA9A"),
--            arrow("#8DAA9A", "#C0C0A2"),
--            arrow("#C0C0A2", "#777E76"),
--            arrow("#777E76", "alpha"),
--
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
	
	-- Volume control (cyz 11_21_23)
		awful.key(
		    { }, "XF86AudioLowerVolume",
		    function() 
			awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
		    end,
		    {description = "decrease volume", group = "system"}),
		awful.key(
		    { }, "XF86AudioRaiseVolume",
		    function()
			awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
		    end,
		    {description = "increase volume", group = "system"}),
		awful.key(
		    { }, "XF86AudioMute",
		    function() 
			--awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ 0%")
            awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
		    end,
		    {description = "mute volume", group = "system"}),

    -- Brightness control (cyz 11_26_23)
    
    awful.key({ }, "XF86MonBrightnessDown", function ()
        awful.util.spawn("brightnessctl set 5%-") end,
        {description = "decrease brightness", group = "system"}),
    awful.key({ }, "XF86MonBrightnessUp", function ()
        awful.util.spawn("brightnessctl set +5%") end,
        {description = "increase brightness", group = "system"}),
        




    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift", "Control"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),


    -- Prompt
    awful.key({ modkey },            "r",     function () 
	    awful.util.spawn("dmenu_run") end,
	    {description = "run dmenu", group = "menu"}),
    awful.key({ modkey },            "d",     function () 
	    awful.util.spawn("rofi -show drun -show-icons -theme custom_theme -dpi 1 -font \"Iosevka Fixed Extended 10\"") end,
	    {description = "launch rofi", group = "menu"}),
    awful.key({ modkey },            "q",     function () 
	    awful.util.spawn("env XSECURELOCK_PASSWORD_PROMPT='asterisks' xsecurelock") end,
	    {description = "lock screen", group = "screen"}),
    awful.key({ modkey },            "\\",     function () 
	    awful.util.spawn("firefox") end,
	    {description = "open firefox", group = "browser"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
    
    -- Windows Resizing for floating clients (cyz 12_2_23)
    
--    awful.key({modkey, "Control"}, "Up",
--	function(c)
--		if c.floating then
--			c:relative_move(0, 0, 0, -20)
--		else
--			awful.client.incwfact(0.025)
--		end
--	end, {description = "Floating Resize Vertical -", group = "client"}),
--    awful.key({modkey, "Control"}, "Down",
--        function(c)
--            if c.floating then
--                c:relative_move(0, 0, 0, 20)
--            else
--                awful.client.incwfact(-0.025)
--            end
--        end, {description = "Floating Resize Vertical +", group = "client"}),
--    awful.key({modkey, "Control"}, "Left",
--        function(c)
--            if c.floating then
--                c:relative_move(0, 0, -20, 0)
--            else
--                awful.tag.incmwfact(-0.025)
--            end
--        end, {description = "Floating Resize Horizontal -", group = "client"}),
--    awful.key({modkey, "Control"}, "Right",
--        function(c)
--            if c.floating then
--                c:relative_move(0, 0, 20, 0)
--            else
--                awful.tag.incmwfact(0.025)
--            end
--        end, {description = "Floating Resize Horizontal +", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = 5,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    {
        rule_any = { class = {"Polybar"}},
        properties = { focusable = false,
                       border_width = 0
        }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


-- cyz 11-20-2023

-- Autostart Applications

awful.util.spawn_with_shell("killall batsignal")
awful.util.spawn_with_shell("killall polybar")

awful.util.spawn_with_shell("picom")
awful.util.spawn_with_shell("batsignal")
-- awful.util.spawn_with_shell("$HOME/.config/polybar/launch.sh; polybar")
awful.util.spawn_with_shell("nitrogen --restore")
awful.util.spawn_with_shell("pgrep -u $USER -x nm-applet > /dev/null || (nm-applet &)")
awful.util.spawn_with_shell("setxkbmap -option compose:ralt")
awful.util.spawn_with_shell("setxkbmap -option caps:swapescape")
awful.util.spawn_with_shell("xset r rate 200 40")


