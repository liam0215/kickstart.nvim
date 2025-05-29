return {
  {
    'lervag/vimtex',
    lazy = false,
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
      --global vimtex settings
      vim.g.vimtex_imaps_enabled = 0 --i.e., disable them
      --vimtex_view_settings
      vim.g.vimtex_view_method = 'skim' -- change this, depending on what you want to use..sumatraPDF, or skim, or zathura, or...
      vim.g.vimtex_view_skim_sync = 1 -- enable forward search
      vim.g.vimtex_view_skim_activate = 1
      vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
      --quickfix settings
      vim.g.vimtex_quickfix_open_on_warning = 0 --  don't open quickfix if there are only warnings
      vim.g.vimtex_quickfix_ignore_filters =
        { 'Underfull', 'Overfull', 'LaTeX Warning: .\\+ float specifier changed to', 'Package hyperref Warning: Token not allowed in a PDF string' }

      ----------------------------------------------------------------------
      -- Focus Ghostty after inverse search from Skim ---------------------
      ----------------------------------------------------------------------
      local function tex_focus_vim()
        -- Detach so Neovim never blocks on `open`
        vim.fn.jobstart({ 'open', '-a', 'Ghostty' }, { detach = true })
        vim.cmd.redraw() -- refresh the TUI once focus returns
      end

      local group = vim.api.nvim_create_augroup('vimtex_focus', { clear = true })
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'VimtexEventViewReverse', -- fired when Skim ⇢ Neovim
        callback = tex_focus_vim,
      })
    end,
  },
}
