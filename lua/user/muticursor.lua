local M = {}

function M.config()
    vim.g.VM_theme = 'ocean'
    vim.g.VM_highlight_matches = 'underline'
    vim.g.VM_maps = {
        ['Find Under'] = '<C-n>',
        ['Find Subword Under'] = '<C-n>',
        ['Select All'] = '<C-d>',
        ['Select h'] = '<S-Left>',
        ['Select l'] = '<S-Right>',
        ['Add Cursor Up'] = '<NOP>',    
        ['Add Cursor Down'] = '<NOP>',
        ['Add Cursor At Pos'] = '<NOP>',
        ['Add Cursor At Word'] = '<NOP>',
        ['Move Left'] = '<C-S-Left>',
        ['Move Right'] = '<C-S-Right>',
        ['Remove Region'] = 'q',
        ['Increase'] = '+',
        ['Decrease'] = '_',
        ["Undo"] = 'u',
        ["Redo"] = '<C-r>',
    }
end

function M.setup()
    -- do nothing
end

return M

