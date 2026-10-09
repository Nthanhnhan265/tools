-- -- <leader>ps: Lệnh này sẽ gọi PackerSync, đồng bộ hóa các plugin đã cài đặt và xóa các plugin không sử dụng nữa.
-- -- <leader>pc: Lệnh này sẽ biên dịch lại cấu hình Packer nếu có thay đổi.
-- -- <leader>pi: Lệnh này sẽ cài đặt các plugin mới được thêm vào cấu hình.
-- -- <leader>pu: Lệnh này sẽ cập nhật tất cả các plugin.
-- -- <leader>pC: Lệnh này sẽ dọn dẹp các plugin không còn được sử dụng.
-- -- <leader>pS: Lệnh này sẽ hiển thị trạng thái của Packer.
local wk = require("which-key")

wk.add({
  { "<leader>f", group = "file" }, -- group
   -- Group Focus
  { "<leader>z", group = "Focus" },
  { "<leader>zz", ":ZenMode<cr>", desc = "Toggle Zen Mode" },
  { "<leader>zt", ":Twilight<cr>", desc = "Toggle Twilight" },
  --Group Packer 
  {
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
    { "<leader>pi", "<cmd>PackerInstall<cr>", desc = "Packer Install" },
    { "<leader>pu", "<cmd>PackerUpdate<cr>", desc = "Packer Update" },
    { "<leader>pC", "<cmd>PackerClean<cr>", desc = "Packer Clean" },
    { "<leader>pi", "<cmd>PackerStatus<cr>", desc = "Packer Status" },
    { "<leader>ps", "<cmd>PackerSync<cr>", desc = "Packer Sync" },
  },

    -- Group LSP
    { "<leader>l", group = "LSP" },
    { "<leader>li", ":LspInfo<cr>", desc = "Connected Language Servers" },
    { "<leader>lk", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature Help" },
    { "<leader>lK", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover Commands" },
    { "<leader>lw", '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', desc = "Add Workspace Folder" },
    { "<leader>lW", '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', desc = "Remove Workspace Folder" },
    { "<leader>ll", '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', desc = "List Workspace Folders" },
    { "<leader>lt", '<cmd>lua vim.lsp.buf.type_definition()<cr>', desc = "Type Definition" },
    { "<leader>ld", '<cmd>lua vim.lsp.buf.definition()<cr>', desc = "Go To Definition" },
    { "<leader>lD", '<cmd>lua vim.lsp.buf.declaration()<cr>', desc = "Go To Declaration" },
    { "<leader>lr", '<cmd>lua vim.lsp.buf.references()<cr>', desc = "References" },
    { "<leader>lR", '<cmd>Lspsaga rename<cr>', desc = "Rename" },
    { "<leader>la", '<cmd>Lspsaga code_action<cr>', desc = "Code Action" },
    { "<leader>le", '<cmd>Lspsaga show_line_diagnostics<cr>', desc = "Show Line Diagnostics" },
    { "<leader>ln", '<cmd>Lspsaga diagnostic_jump_next<cr>', desc = "Go To Next Diagnostic" },
    { "<leader>lN", '<cmd>Lspsaga diagnostic_jump_prev<cr>', desc = "Go To Previous Diagnostic" },

  })
