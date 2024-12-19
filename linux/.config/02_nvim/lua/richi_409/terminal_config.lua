vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'disable line numbers when opening a terminal in vim',
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function ()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end
})

-- local job_id = 0
vim.keymap.set("n", "<space>st", function ()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 10)

    -- job_id = vim.bo.channel
end)

vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>")

--[[
vim.keymap.set("n", "<space>example", function ()
    vim.fn.chansend(job_id, {"echo 'hi'\r\n"})
end)
]]--
