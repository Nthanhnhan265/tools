-----------------------------------------------------
--- CONFIGURATION  
-----------------------------------------------------
-- setup must be called before loading
vim.opt.number = true -- Hiển thị số dòng 
vim.opt.clipboard = "unnamedplus" -- Cho phép copy và dán vào nvim từ bên ngoài
vim.cmd('filetype plugin indent on')
vim.o.shortmess = vim.o.shortmess .. 'c' -- Giảm bớt thông báo hiện thị khi thực hiện các thao tác như ghi file, thông báo lỗi.
vim.o.hidden = true -- Bạn có thể chuyển đổi giữa các buffer (file) mà không cần lưu file hiện tại.
vim.o.whichwrap = 'b,s,<,>,[,],h,l' --Cho phép con trỏ di chuyển qua dòng khác khi sử dụng các phím điều hướng (<, >, h, l, …).
vim.o.pumheight = 12 --Giới hạn số dòng hiển thị trong menu gợi ý (popup menu).
vim.o.cmdheight = 2 --Tăng chiều cao command line lên 2 dòng, giúp bạn đọc thông báo dễ dàng hơn.
--splitbelow: Khi chia cửa sổ ngang (:split), cửa sổ mới mở ra phía dưới.
--splitright: Khi chia cửa sổ dọc (:vsplit), cửa sổ mới mở ra bên phải.
vim.o.splitbelow = true
vim.o.splitright = true
---
vim.opt.termguicolors = true --Bật hỗ trợ màu 24-bit trong terminal, giúp giao diện đẹp hơn.
vim.o.conceallevel = 0 --Hiển thị đầy đủ các ký tự ẩn (như markdown).
vim.o.showtabline = 2 --Luôn hiển thị tabline (danh sách các tab).
--Tắt tính năng tạo file backup khi ghi file.
vim.o.backup = false
vim.o.writebackup = false
---
--updatetime: Thời gian chờ để kích hoạt các sự kiện (như CursorHold).
--timeoutlen: Thời gian chờ cho các tổ hợp phím.
vim.o.updatetime = 300
vim.o.timeoutlen = 500
---
--hlsearch: Tắt tô sáng kết quả tìm kiếm.
--ignorecase: Không phân biệt chữ hoa/thường khi tìm kiếm.
vim.o.hlsearch = false
vim.o.ignorecase = true
---
--scrolloff: Luôn giữ con trỏ cách viền trên/dưới ít nhất 3 dòng.
--sidescrolloff: Tương tự cho cạnh trái/phải.
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
---
vim.o.mouse = "a" --Bật hỗ trợ chuột cho tất cả chế độ.
vim.wo.wrap = false --Không ngắt dòng khi dòng quá dài.
vim.o.cursorline = true --ô sáng dòng mà con trỏ đang đứng.
vim.wo.signcolumn = "yes" --Luôn hiển thị cột dấu hiệu (như breakpoint, git change).

---
-- tabstop: Số spaces khi hiển thị 1 tab.
-- softtabstop: Số spaces khi nhấn phím Tab.
-- shiftwidth: Số spaces cho mỗi lần thụt dòng (indent).
-- autoindent: Tự động thụt dòng khi xuống dòng.
-- expandtab: Chuyển phím Tab thành spaces.
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true
---


  -- tắt netrw 
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

-- vim.g.completeopt = "menu, menuone, noselect, noinsert"


-- Friendly snippets 
vim.g.vsnip_snippet_dir = vim.fn.stdpath("data") .. "/site/pack/packer/start/friendly-snippets/snippets"


-- fold 
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99 -- Mở tất cả fold mặc định



-- Enable folding
vim.o.foldenable = true

-- Auto open folds in these conditions
vim.o.foldopen = "block,insert,jump,mark,percent,quickfix,search,tag,undo"

-- Custom fold text
local function MyFoldText()
    local line = vim.fn.getline(vim.v.foldstart)
    local numberOfLines = 1 + vim.v.foldend - vim.v.foldstart
    local sub = string.gsub(line, '/%*|%*/|{{{%d?=?', '')
    return vim.v.folddashes .. sub .. " (" .. numberOfLines .. " Lines)"
end

-- Folding configuration
if vim.fn.has("nvim") == 1 then
    -- Treesitter folding
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    -- Uncomment this if you want treesitter foldtext
    -- vim.o.foldtext = "v:lua.vim.treesitter.foldtext()"
    vim.o.foldtext = MyFoldText()
else
    -- Syntax-based folding as fallback
    vim.o.foldmethod = "syntax"
    vim.o.foldtext = MyFoldText()
end

-- General folding options
vim.o.foldlevel = 99           -- Open all folds by default
vim.o.foldlevelstart = -1      -- Keep fold state as last session
vim.o.foldnestmax = 5          -- Limit nested folds
vim.o.foldminlines = 1         -- Minimum lines to enable fold

-- Fixing fillchars for fold characters with proper unicode escape sequences
vim.o.fillchars = "fold:\u{00B7},foldopen:\u{E000},foldclose:\u{E002}" 

-- Key mapping for toggling folds
vim.api.nvim_set_keymap("n", "zz", "za", { noremap = true, silent = true })


