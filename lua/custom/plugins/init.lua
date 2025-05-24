-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local last_selected_project = nil
return {
  {
    'github/copilot.vim',
  },
  {
    'nvim-telescope/telescope-project.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telescope').load_extension 'project'
    end,
    vim.keymap.set('n', '<leader>pf', function()
      require('telescope').extensions.project.project {}
    end, { desc = '[P]roject [F]ind' }),
    -- Browse files in the current project root
    vim.keymap.set('n', '<leader>pb', function()
      require('telescope.builtin').find_files { cwd = require('telescope.utils').buffer_dir() }
    end, { desc = '[P]roject [B]rowse files in root' }),

    -- Live grep within the current project root
    vim.keymap.set('n', '<leader>pg', function()
      require('telescope.builtin').live_grep { cwd = require('telescope.utils').buffer_dir() }
    end, { desc = '[P]roject [G]rep' }),

    -- Recent files in current project
    -- Define a module-level cache

    vim.keymap.set('n', '<leader>p.', function()
      local function open_oldfiles(project_path)
        require('telescope.builtin').oldfiles {
          cwd = project_path,
          prompt_title = 'Recent Files in Project',
        }
      end

      if last_selected_project then
        open_oldfiles(last_selected_project)
        return
      end

      -- Fallback to prompting the user
      local project_extension = require('telescope').extensions.project

      project_extension.project {
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            local action_state = require 'telescope.actions.state'
            local actions = require 'telescope.actions'
            local entry = action_state.get_selected_entry()
            actions.close(prompt_bufnr)

            last_selected_project = entry.value
            open_oldfiles(last_selected_project)
          end)
          return true
        end,
      }
    end, { desc = '[P]roject Recent [.] Files' }),

    -- List buffers (all open files)
    vim.keymap.set('n', '<leader>po', function()
      require('telescope.builtin').buffers()
    end, { desc = '[P]roject [O]pen buffers' }),

    vim.keymap.set('n', '<leader>p/', function()
      last_selected_project = nil
      vim.notify('Project selection cleared', vim.log.levels.INFO)
    end, { desc = '[P]roject Reset Selection' }),
  },
}
