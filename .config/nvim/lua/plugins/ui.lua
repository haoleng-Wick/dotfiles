return {
    --- 首页 Alpha
    {
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
                                             
      ████ ██████           █████      ██
     ███████████             █████ 
     █████████ ███████████████████ ███   ███████████
    █████████  ███    █████████████ █████ ██████████████
   █████████ ██████████ █████████ █████ █████ ████ █████
 ███████████ ███    ███ █████████ █████ █████ ████ █████
██████  █████████████████████ ████ █████ █████ ████ ██████
            
            ]]

            local function getGreeting(name)
                local tableTime = os.date("*t")
                local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
                local hour = tableTime.hour
                local greetingsTable = {
                    [1] = "  Sleep well",
                    [2] = "  Good morning",
                    [3] = "  Good afternoon",
                    [4] = "  Good evening",
                    [5] = "󰖔  Good night",
                }
                local greetingIndex = 0
                if hour == 23 or hour < 7 then
                    greetingIndex = 1
                elseif hour < 12 then
                    greetingIndex = 2
                elseif hour >= 12 and hour < 18 then
                    greetingIndex = 3
                elseif hour >= 18 and hour < 21 then
                    greetingIndex = 4
                elseif hour >= 21 then
                    greetingIndex = 5
                end
                return "\t\t" .. "\t\t" .. "\t\t" .. greetingsTable[greetingIndex] .. ", " .. name
            end

            local userName = "Johnson"
            local greeting = getGreeting(userName)
            dashboard.section.header.val = vim.split(logo .. "\n" .. greeting, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.opts.layout[1].val = 6
			return dashboard
		end,

		config = function(_, dashboard)
			require("alpha").setup(dashboard.opts)
			vim.api.nvim_create_autocmd("User", {
				callback = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime * 100) / 100
					dashboard.section.footer.val = "󱐌 Lazy-loaded " .. stats.loaded .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},

    -- 顶部栏
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
        config = function ()
            require("bufferline").setup{
                -- config ...
            }
        end
    },

    -- 状态栏
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
        config = function ()
            require('lualine').setup()
        end
    },

    -- auto-pairs 配置
    {
        "jiangmiao/auto-pairs",
    },

    { 
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
        scope = { enabled = false },
        exclude = {
            filetypes = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
          },
        }
    },

    -- Telescope 文本搜索
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    -- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Floaterm
    {
        "voldikss/vim-floaterm",
        event = "VeryLazy",
    },
}
