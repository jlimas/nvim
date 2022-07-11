local orgmode_ok, orgmode = pcall(require, 'orgmode')
if not orgmode_ok then
  return
end

orgmode.setup_ts_grammar()
orgmode.setup({
  org_agenda_files = { '~/orgmode/*' },
  org_default_notes_file = '~/orgmode/default.org',
})
