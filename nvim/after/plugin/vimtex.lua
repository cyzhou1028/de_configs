vim.cmd([[
    syntax enable
    let g:vimtex_view_method = 'zathura'
    set conceallevel=1
    let g:tex_conceal='abdmg'   
    let g:vimtex_compiler_latexmk = { 'aux_dir' : 'aux' , 'outdir' : 'out' , 'file_line_error' : 1}
    nmap <localleader>v <plug>(vimtex-view)
]])
