vim.cmd([[
    syntax enable
    let g:vimtex_view_method = 'zathura'
    set conceallevel=1
    let g:tex_conceal='abdmg'   
    let g:vimtex_compiler_latexmk = { 'aux_dir' : 'aux' , 'outdir' : 'out' , 'file_line_error' : 1}
        
    nmap <localleader>v <plug>(vimtex-view)
    inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
    nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
]])
