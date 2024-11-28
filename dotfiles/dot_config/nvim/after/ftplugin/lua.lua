-- After init file required because there are default plugins that are overriding settings

-- To remove auto-comments on pressing o for a new line. See `:h fo-table`.
-- for Mail/news	(format all, don't start comment with "o" command): `:set fo=tcrq`
-- WARNING: https://vi.stackexchange.com/questions/9366/set-formatoptions-in-vimrc-is-being-ignored
-- see :help ftplugin-overrule
vim.opt.formatoptions = 'tcrq'
