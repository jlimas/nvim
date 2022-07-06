local whichkey_ok, wk = pcall(require, "which-key")
if not whichkey_ok then
    return
end

wk.register({
    p = {
        name = '+Plugins',
        s = { '<cmd>PackerSync<cr>', 'Sync' },
        c = { '<cmd>PackerClean<cr>', 'Clean' },
        u = { '<cmd>PackerUpdate<cr>', 'Update' }
    },
    v = {
        name = '+Vim Config Files',
        g = { '<cmd>e ~/.config/nvim/init.lua<cr>', 'Lua Global' },
        p = { '<cmd>e ~/.config/nvim/lua/packer_setup.lua<cr>', 'Packer' },
        s = { '<cmd>e ~/.config/nvim/lua/core/options.lua<cr>', 'Settings' },
        m = { '<cmd>e ~/.config/nvim/lua/core/keymappings.lua<cr>', 'Mappings' },
        w = { '<cmd>e ~/.config/nvim/lua/plugins/whichkeys.lua<cr>', 'Which Keys' },
        l = { '<cmd>e ~/.config/nvim/lua/lsp-config/init.lua<cr>', 'LSP' },
    },
    s = { '<cmd>so %<cr>', 'Source File' },
    g = {
        name = '+Git Operations',
        d = {
            name = 'Git Diff',
            o = { '<cmd>DiffviewOpen<cr>', 'Open' },
            c = { '<cmd>DiffviewClose<cr>', 'Close' },
        },
        o = { ':G<cr>', 'Open' },
        p = { ':G push<cr>', 'Push' },
    },
    r = {
        name = '+Run/Execute',
        l = { ':FloatermNew --title=Lua lua %<cr>', 'Lua Code' },
        j = { ':FloatermNew --title=JavaScript node %<cr>', 'Javascript Code' },
        t = { ':FloatermNew --title=TypeScript ts-node %<cr>', 'TypeScript Code' },
        p = { ':FloatermNew --title=Python python3 %<cr>', 'Javascript Code' },
        g = { ':FloatermNew --title=GoLang go run %<cr>', 'GoLang Code' },
        n = { ':FloatermNew --title=NPM npm i<cr>', 'NPM Install' },
        c = { ':FloatermNew --title=HackingTerminal<cr>', 'Open Terminal' }
    },
    ['='] = {
        name = '+Toggle Settings',
        e = {
            name = '+Environment Variables',
            l = {
                name = '+Logger',
                u = { ":let $LOGGER_ENABLED='true'<cr>", 'Enable Logging' },
                d = { ":let $LOGGER_ENABLED='false'<cr>", 'Disable Logging' },
            }
        },
        c = {
            name = '+Copilot',
            u = { ':Copilot enable<cr>', 'Enable Copilot' },
            d = { ':Copilot disable<cr>', 'Disable Copilot' },
        }
    },
    t = {
        name = '+Tests',
        n = { ':TestNearest<cr>', 'Test Nearest' },
        f = { ':TestFile<cr>', 'Test File' },
        l = { ':TestLast<cr>', 'Last Test' }
    }
}, { prefix = '<leader>' })
