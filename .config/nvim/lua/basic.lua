-- uft-8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = 'utf-8'

-- jk移动式光标上下保留2行
vim.o.scrolloff = 2
vim.o.sidescrolloff = 2

-- 相对行号
vim.wo.number = true
vim.wo.relativenumber = true

-- Undo文件
-- vim.opt.undofile = true
-- vim.opt.undodir = vim.fn.expand('$HOME/.local/share/nvim/undo')

-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"

-- 缩进
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true

-- 搜索不要高亮
vim.o.hlsearch = false

-- <leader>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- fcitx && fcitx5自动切换
local fcitx_cmd = ''
if vim.fn.executable('fcitx-remote') == 1 then
    fcitx_cmd = 'fcitx-remote'
elseif vim.fn.executable('fcitx5-remote') == 1 then
    fcitx_cmd = 'fcitx5-remote'
else
    return
end

if os.getenv('SSH_TTY') ~= nil then
    return
end

local os_name = vim.loop.os_uname().sysname
if (os_name == 'Linux' or os_name == 'Unix') and os.getenv('DISPLAY') == nil and os.getenv('WAYLAND_DISPLAY') == nil then
    return
end

function _Fcitx2en()
    local input_status = tonumber(vim.fn.system(fcitx_cmd))
    if input_status == 2 then
    -- input_toggle_flag means whether to restore the state of fcitx
    -- 设置flag表示fcitx的状态
        vim.b.input_toggle_flag = true
    -- 更改为English输入
        vim.fn.system(fcitx_cmd .. ' -c')
    end
end

function _Fcitx2NonLatin()
    if vim.b.input_toggle_flag == nil then
        vim.b.input_toggle_flag = false
    elseif vim.b.input_toggle_flag == true then
        -- switch to Non-Latin input
        vim.fn.system(fcitx_cmd .. ' -o')
        vim.b.input_toggle_flag = false
    end
end

vim.cmd[[
    augroup fcitx
        au InsertEnter * :lua _Fcitx2NonLatin()
        au InsertLeave * :lua _Fcitx2en()
        au CmdlineEnter [/\?] :lua _Fcitx2NonLatin()
        au CmdlineLeave [/\?] :lua _Fcitx2en()
    augroup END
]]

 -- Neovide
if vim.g.neovide then
    vim.o.guifont = "Hack Nerd Font:h12" -- text below applies for VimScript
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_transparency = 1.0
    vim.g.neovide_hide_mouse_when_typing = true
    -- vim.g.neovide_theme = 'auto'
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 5
end
