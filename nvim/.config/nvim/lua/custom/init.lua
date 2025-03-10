vim.opt.number = false
vim.opt.whichwrap = "b,s"

vim.api.nvim_create_user_command("ExpandCopy", function(opts)
    local path = vim.fn.expand(opts.fargs[1])
    vim.fn.setreg("+", path)
    vim.notify("Copied: " .. path)
end, { nargs = 1 })

vim.api.nvim_create_user_command("CopyRelPath", function()
    local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
    vim.fn.setreg("+", path)
    vim.notify("Copied: " .. path)
end, {})
