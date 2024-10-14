--      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
--      ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
--         ██║   ███████║█████╗  ██╔████╔██║█████╗
--         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
--         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
--         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Imports
-- ===================================================================


local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gears = require("gears")
local dpi = xresources.apply_dpi
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local separators = lain.util.separators

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility


local theme = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"




-- ===================================================================
-- Theme Variables
-- ===================================================================


-- Font
theme.font          = "Iosevka Fixed Extended"
--theme.title_font    = "SF Pro Display Medium 11"

-- Background
theme.bg_normal     = "#252525"
theme.bg_dark       = "#000000"
theme.bg_focus      = "#111111"
theme.bg_urgent     = "#ed8274"
theme.bg_minimize   = "#444444"
theme.bg_systray    = "#272B31"

-- Foreground
theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#e4e4e4"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

-- Sizing
theme.useless_gap         = dpi(3) -- window gap distance
--theme.gap_single_client   = true             -- gaps if only one window is open

-- Window Borders
theme.border_width          = dpi(4)            -- window border width
theme.border_normal         = "#00000000"
theme.border_focus          = "#00ffff"
-- theme.border_focus          = "#ff0000"
-- theme.border_focus          = "#00ff00"
theme.border_marked         = theme.fg_urgent

-- Titlebars
--theme.titlebar_font = theme.title_font
--theme.titlebar_bg = theme.bg_normal
--theme.titlebar_bg_focus = theme.titlebar_bg -- make titlebars not change color when focused

-- Taglist
--theme.taglist_bg_empty = "#16182190"
--theme.taglist_bg_occupied = '#808080cc'
--theme.taglist_bg_urgent = '#e91e6399'
--theme.taglist_bg_focus = theme.bg_normal
--theme.taglist_shape = gears.shape.rounded_bar

-- Tasklist
theme.tasklist_font = theme.font

theme.tasklist_bg_normal = "#16182190"
theme.tasklist_bg_focus = theme.bg_normal
theme.tasklist_bg_urgent = theme.bg_urgent
theme.tasklist_bg_minimize = "#808080cc"
theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_shape = gears.shape.rounded_bar


-- Notification Settings

theme.notification_max_width = dpi(500)
theme.notification_width = dpi(500)
theme.notification_font = "Iosevka Fixed Extended"
theme.notification_opacity = 1.0


--panel sizing
--theme.top_panel_height = dpi(28)

--added border for active window
client.connect_signal("focus", function(c) c.border_color = theme.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = theme.border_normal end)

-- ===================================================================
-- Wibar
-- ===================================================================

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup("Iosevka", " " .. mem_now.used .. "MB ")
    end
})

-- Building the box and adding widgets

local arrow = separators.arrow_left

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(16), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            wibox.container.margin(scissors, dpi(4), dpi(8)),
            --[[ using shapes
            pl(wibox.widget { mpdicon, theme.mpd.widget, layout = wibox.layout.align.horizontal }, "#343434"),
            pl(task, "#343434"),
            --pl(wibox.widget { mailicon, mail and theme.mail.widget, layout = wibox.layout.align.horizontal }, "#343434"),
            pl(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, "#777E76"),
            pl(wibox.widget { cpuicon, cpu.widget, layout = wibox.layout.align.horizontal }, "#4B696D"),
            pl(wibox.widget { tempicon, temp.widget, layout = wibox.layout.align.horizontal }, "#4B3B51"),
            --pl(wibox.widget { fsicon, theme.fs and theme.fs.widget, layout = wibox.layout.align.horizontal }, "#CB755B"),
            pl(wibox.widget { baticon, bat.widget, layout = wibox.layout.align.horizontal }, "#8DAA9A"),
            pl(wibox.widget { neticon, net.widget, layout = wibox.layout.align.horizontal }, "#C0C0A2"),
            pl(binclock.widget, "#777E76"),
            --]]
            -- using separators
            arrow("#343434", "#777E76"),
            wibox.container.background(wibox.container.margin(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, dpi(2), dpi(3)), "#777E76"),
            arrow("#777E76", "#4B696D"),
            --]]
            s.mylayoutbox,
        },
    }
end



-- ===================================================================
-- Icons
-- ===================================================================


-- You can use your own layout icons like this:
--theme.layout_tile = "~/.config/awesome/icons/layouts/view-quilt.png"
--theme.layout_floating = "~/.config/awesome/icons/layouts/view-float.png"
--theme.layout_max = "~/.config/awesome/icons/layouts/arrow-expand-all.png"

--theme.icon_theme = "Tela-blue"

-- return theme
return theme
