return {
    {
        "ThePrimeagen/harpoon",
        config = function()
            local harpoon = require("harpoon")

            harpoon.setup()

            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
            vim.keymap.set("n", "<leader><C-h>", function() mark.set_index(1) end)
            vim.keymap.set("n", "<leader><C-t>", function() mark.set_index(2) end)
            vim.keymap.set("n", "<leader><C-n>", function() mark.set_index(3) end)
            vim.keymap.set("n", "<leader><C-s>", function() mark.set_index(4) end)
        end
    },
    {
        "ThePrimeagen/vim-with-me",
        config = function() end
    },
    {
        "szw/vim-maximizer",
        config = function()
            vim.keymap.set("n", "<space>m", ":MaximizerToggle<CR>")
        end
    },
    {
        "prettier/vim-prettier",
        run = "yarn install --frozen-lockfile --production",
        config = function()
            vim.g['prettier#exec_cmd_path'] = '/home/nikita/.nvm/versions/node/v22.2.0/bin/prettier'
            vim.keymap.set("n", "<leader>p", ":Prettier<CR>")
        end
    }
}


