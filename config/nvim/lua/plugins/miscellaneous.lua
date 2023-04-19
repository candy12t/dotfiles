return {
  {
    'phaazon/hop.nvim',
    version = 'v2.*',
    lazy = true,
    event = {
      'BufRead'
    },
    config = function()
      require('hop').setup({
      })

      local hint_char1 = function(direction, current_line_only, hint_offset)
        local hop = require('hop')
        local directions = require('hop.hint').HintDirection

        return function()
          hop.hint_char1({ direction = directions[direction], current_line_only = current_line_only, hint_offset = hint_offset })
        end
      end
      local keymap_opt = { remap = true }

      vim.keymap.set('n', 'f', hint_char1('AFTER_CURSOR', true, 0), keymap_opt)
      vim.keymap.set('n', 'F', hint_char1('BEFORE_CURSOR', true, 0), keymap_opt)
      vim.keymap.set('n', 't', hint_char1('AFTER_CURSOR', true, -1), keymap_opt)
      vim.keymap.set('n', 'T', hint_char1('BEFORE_CURSOR', true, -1), keymap_opt)
    end
  },
  {
    'numToStr/Comment.nvim',
    lazy = true,
    event = {
      'BufRead'
    },
    config = true
  }
}
