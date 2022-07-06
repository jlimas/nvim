vim.cmd([[ 
    let g:coverage_json_report_path = 'coverage/coverage-final.json'
    let g:coverage_interval = 5000
    let g:coverage_enabled = 1
    let g:coverage_show_uncovered = 1
    let g:coverage_sign_uncovered = '🐞'
]])
