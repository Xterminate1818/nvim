local ran, telescope = pcall(require, 'telescope')
if not ran then
  return
end

telescope.setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor()
    },
  }
}

telescope.load_extension("ui-select")
