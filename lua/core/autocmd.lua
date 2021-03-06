vim.cmd([[
  augroup gitsetup
        autocmd!

        " Only set these commands up for git commits
        autocmd FileType gitcommit
                \  hi def link gitcommitOverflow Error
                \| autocmd CursorMoved,CursorMovedI *
                        \  let &l:textwidth = line('.') == 1 ? 50 : 80
  augroup end
]])

vim.cmd('autocmd FileType python setlocal colorcolumn=88')
vim.cmd('autocmd FileType javascript,typescript setlocal colorcolumn=120')
