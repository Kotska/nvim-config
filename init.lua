vim.o.shell = "/bin/sh"
vim.o.shellcmdflag = "-ic"
vim.o.shortmess = "filnxtToOFS"
vim.o.winborder = "rounded"
vim.o.showmode = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.signcolumn = "yes"
vim.o.expandtab = true
vim.o.undofile = true
vim.o.hls = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.ttimeoutlen = 10
vim.o.timeoutlen = 300
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.background = "dark"
vim.o.backupcopy = "yes"
vim.o.autoindent = true
vim.o.termguicolors = true
vim.o.laststatus = 3
vim.g.mason_node_path = "/usr/bin/node"
vim.g.emmet_html_php = 1
local initlua = vim.fn.stdpath('config') .. '/init.lua'

vim.keymap.set("n", "<leader>o", "_f:<right>ct;<space>")
vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, { desc = "LSP document symbols" })
vim.keymap.set('n', '<leader>so', ':update<cr> :so<cr>', { desc = "Source current config file" })
vim.keymap.set('n', '<leader>sv', ':luafile ' .. initlua .. '<cr>', { desc = "Source config file" })
vim.keymap.set('n', '<C-s>', ':write<cr>')
vim.keymap.set('n', '<C-_>', 'gcc', { remap = true })
vim.keymap.set('v', '<C-_>', 'gc', { remap = true })
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('v', '<leader>p', '"_dP', { noremap = true, silent = true })
local function buf_skip_visible(direction)
  local visible = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    visible[vim.api.nvim_win_get_buf(win)] = true
  end

  local listed = vim.fn.getbufinfo({ buflisted = 1 })
  for _ = 1, #listed do
    if direction == "next" then vim.cmd("bnext") else vim.cmd("bprev") end
    if not visible[vim.api.nvim_get_current_buf()] then return end
  end
end

vim.keymap.set('n', '<Tab>', function() buf_skip_visible("next") end)
vim.keymap.set('n', '<S-Tab>', function() buf_skip_visible("prev") end)
vim.keymap.set('n', '<CR>', 'o<Esc>')
local function buf_delete_skip_visible()
  local bufnr = vim.api.nvim_get_current_buf()

  local win_count = 0
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == bufnr then win_count = win_count + 1 end
  end

  if win_count == 1 then
    local visible = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      visible[vim.api.nvim_win_get_buf(win)] = true
    end
    visible[bufnr] = nil

    local listed = vim.fn.getbufinfo({ buflisted = 1 })
    for _ = 1, #listed do
      vim.cmd("bnext")
      local newbuf = vim.api.nvim_get_current_buf()
      if newbuf ~= bufnr and not visible[newbuf] then
        break
      end
    end
  end

  if vim.api.nvim_buf_is_valid(bufnr) then
    vim.cmd("bdelete " .. bufnr)
  end
end

vim.keymap.set('n', '<leader>bd', buf_delete_skip_visible)
vim.keymap.set("n", "<leader>t", function()
  local file = vim.api.nvim_buf_get_name(0)
  local dir

  if file ~= "" then
    dir = vim.fn.fnamemodify(file, ":p:h")
  else
    dir = vim.fn.getcwd()
  end

  vim.fn.jobstart({ "alacritty", "--working-directory", dir }, { detach = true })
end, { desc = "Open terminal in current directory" })

vim.opt.runtimepath:append('/home/dani/Projects/nvim-nightmare')
vim.pack.add({
  -- Colorscheme
  { src = "https://github.com/pineapplegiant/spaceduck" },

  -- UI for messages, cmdline, popupmenu
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/rcarriga/nvim-notify" },
  { src = "https://github.com/folke/noice.nvim" },

  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/rmagatti/auto-session" },
  { src = "https://github.com/Joakker/lua-json5" },
  { src = "https://github.com/Kotska/snippet-converter.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-mini/mini.files" },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/nvim-mini/mini.extra" },
  { src = "https://github.com/jiaoshijie/undotree" },
  { src = "https://github.com/folke/ts-comments.nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/aznhe21/actions-preview.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",             version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/MagicDuck/grug-far.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  -- { src = "https://github.com/karb94/neoscroll.nvim" },
  -- { src = "https://github.com/terryma/vim-expand-region" },
  { src = "https://github.com/wakatime/vim-wakatime" },
  -- Autocompletion
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-cmdline" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/stevearc/aerial.nvim" },
  { src = "https://github.com/mattn/emmet-vim" },
  { src = "/home/dani/Projects/cmp-emmet-vim" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/nickjvandyke/opencode.nvim" },
  { src = "https://github.com/andymass/vim-matchup" },
  { src = "https://github.com/Shatur/neovim-ayu" },
})

-- vim.cmd("colorscheme nightmare")
require('ayu').setup({
    mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    terminal = true, -- Set to `false` to let terminal manage its own colors.
    overrides = {
      Normal = { bg = "None" },
      NormalFloat = { bg = "none" },
      ColorColumn = { bg = "None" },
      SignColumn = { bg = "None" },
      Folded = { bg = "None" },
      FoldColumn = { bg = "None" },
      CursorLine = { bg = "None" },
      CursorColumn = { bg = "None" },
      VertSplit = { bg = "None" },
    }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})
require('ayu').colorscheme()

local json5_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/lua-json5"
if vim.fn.isdirectory(json5_dir) == 1 and vim.fn.filereadable(json5_dir .. "/lua/json5.so") == 0 then
  vim.system({ json5_dir .. "/install.sh" }, { cwd = json5_dir })
end

require('mason-tool-installer').setup({
  ensure_installed = {
    { 'gopls', condition = function() return vim.fn.executable('go') == 1 end },
    "lua-language-server",
    "html-lsp",
    "typescript-language-server",
    "intelephense",
  }
})

require("bufferline").setup {}
require("notify").setup({
  render = "wrapped-compact",
  stages = "static",
})

local notify = require("notify")

require('render-markdown').setup()

require("auto-session").setup()

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'notify',
  callback = function()
    vim.keymap.set('n', 'q', function()
      require('notify').dismiss({ pending = true, silent = true })
    end, { buffer = true, desc = 'Dismiss notification' })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php',
  callback = function()
    vim.bo.autoindent = true
    vim.b.did_indent = true
    vim.bo.indentexpr = "nvim-treesitter#indent()"
  end,
})

require("toggleterm").setup({
  size = 12,
  open_mapping = nil,
  hide_numbers = true,
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true,
  close_on_exit = false,
  shell = vim.o.shell,
  float_opts = {
    border = "rounded",
  },
  on_open = function(term)
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = term.bufnr })
  end,
})

vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

local function get_runner_cmd()
  local ft_runners = {
    go = 'go run %',
    lua = 'lua %',
    python = 'python %',
    javascript = 'node %',
    typescript = 'tsx %',
  }
  return ft_runners[vim.bo.filetype]
end

vim.keymap.set('n', '<leader>rn', function()
  local cmd = get_runner_cmd()
  if not cmd then
    print('No runner for ' .. vim.bo.filetype)
    return
  end
  local file = vim.fn.expand('%:p')
  local term_cmd = cmd:gsub('%%', file)
  require("toggleterm").exec(term_cmd)
end, { desc = 'Run current file in toggleterm' })

local snippet_locations = {
    "/home/dani/.var/app/com.vscodium.codium/config/VSCodium/User/snippets/media.code-snippets",
    "/mnt/c/Users/Dani/AppData/Roaming/Code/User/snippets/media.code-snippets"
}
for i, path in ipairs(snippet_locations) do
  if vim.fn.filereadable(path) == 0 then
    snippet_locations[i] = nil
  end
end
local template = {
  -- name = "t1", (optionally give your template a name to refer to it in the `ConvertSnippets` command)
  sources = {
    vscode = {
      unpack(snippet_locations)
    },
  },
  output = {
    -- Specify the output formats and paths
    vscode_luasnip = {
      vim.fn.stdpath("config") .. "/vscode_snippets",
    },
  },
}
-- run - :ConvertSnippets
require("snippet_converter").setup({
  templates = { template },
})
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
  paths = "./vscode_snippets",
})
local ls = require("luasnip")

require('lualine').setup({
  sections = {
    lualine_x = {
      'encoding',
      'fileformat',
      'filetype',
      {
        function()
          local count = vim.fn.searchcount { recompute = 1, maxcount = 0 }
          if not count or count.total == 0 then return '' end
          local cur = count.current > 0 and tostring(count.current) or '?'
          return string.format('%s [%s/%d]', vim.fn.getreg('/'), cur, count.total)
        end,
        cond = function()
          local count = vim.fn.searchcount { recompute = 1, maxcount = 0 }
          return count and count.total > 0
        end,
      },
    },
  },
})
vim.api.nvim_set_keymap('n', 'W', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

require "mason".setup()

-- Not working with which-key
-- require('neoscroll').setup({
--   duration_multiplier = 0.3,
--   respect_scrolloff = true,
-- })

require('nvim-autopairs').setup{}
require('mini.files').setup({
  mappings = {
    synchronize = '<C-s>',
  },
})
require('mini.pick').setup()
require('mini.extra').setup()
vim.keymap.set("n", "<leader>fl", function()
  MiniExtra.pickers.oldfiles()
end)

local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local cur_target = MiniFiles.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. ' split')
      return vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target)

    -- This intentionally doesn't act on file under cursor in favor of
    -- explicit "go in" action (`l` / `L`). To immediately open file,
    -- add appropriate `MiniFiles.go_in()` call instead of this comment.
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = 'Split ' .. direction
  vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak keys to your liking
    map_split(buf_id, 'S', 'belowright horizontal')
    map_split(buf_id, '<C-v>', 'belowright vertical')
    map_split(buf_id, '<C-t>', 'tab')
  end,
})


require('mini.icons').setup()
-- vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<cr>", { desc = "File picker" })

vim.keymap.set("n", "<leader>ff", function()
  MiniFiles.open()
end, { desc = "Open file picker" })
vim.keymap.set("n", "<leader>fy", function()
  vim.cmd("let @+ = expand('%:p')")
end, { desc = "Copy current file path" })
vim.keymap.set("n", "<leader>fe", function()
  vim.cmd("echo expand('%:p')")
end, { desc = "Print current filepath" })
vim.keymap.set("n", "<leader>fg", function()
  MiniPick.builtin.grep_live()
end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fc", function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
  MiniFiles.open(path)
  MiniFiles.reveal_cwd()
end, { desc = "Open picker for current directory" })
vim.keymap.set('n', '<C-e>', ":Pick buffers<cr>", { desc = "Pick buffer" })

local function get_sshfs_info(path)
  local f = io.open("/proc/mounts", "r")
  if not f then return nil end

  local mounts = {}
  for line in f:lines() do
    local device, mount_point, fstype = line:match("^(%S+) (%S+) (%S+)")
    if fstype == "fuse.sshfs" or (fstype == "fuseblk" and (device:match("@") or device:match("^[^:]+:"))) then
      local user, host, remote_path = device:match("^([^@]+)@([^:]+):(.*)$")
      if not user then
        host, remote_path = device:match("^([^:]+):(.*)$")
      end
      if host then
        local full_host = user and (user .. "@" .. host) or host
        table.insert(mounts, {
          mount_point = mount_point,
          full_host = full_host,
          host = host,
          user = user,
          remote_path = remote_path or "",
        })
      end
    end
  end
  f:close()

  table.sort(mounts, function(a, b)
    return #a.mount_point > #b.mount_point
  end)

  for _, m in ipairs(mounts) do
    if path == m.mount_point or path:sub(1, #m.mount_point + 1) == m.mount_point .. "/" then
      return m
    end
  end
  return nil
end

vim.keymap.set('n', '<leader>fd', function()
  local cwd = vim.fn.getcwd()
  local sshfs = get_sshfs_info(cwd)

  if sshfs then
    local pattern = vim.fn.input("Remote file pattern: ")
    if pattern == "" then return end

    local notify = require("notify")
    notify("Searching for " .. pattern .. " on " .. sshfs.host .. "...", "info", { timeout = false })

    local rel_path = cwd == sshfs.mount_point and "" or cwd:sub(#sshfs.mount_point + 2)
    local remote_dir = sshfs.remote_path .. (rel_path ~= "" and "/" .. rel_path or "")
    local scaped = vim.fn.shellescape
    local cd_cmd = "cd " .. scaped(remote_dir)
    local alt = remote_dir:gsub("^/", "")
    if alt ~= remote_dir then
      cd_cmd = "{ " .. cd_cmd .. " 2>/dev/null || cd " .. scaped(alt) .. "; }"
    end
    local shell_cmd = cd_cmd .. " && fd --hidden --exclude .git -- " .. scaped(pattern)

    vim.system({ "ssh", sshfs.full_host, shell_cmd }, { text = true }, function(result)
      vim.schedule(function()
        notify.dismiss({ pending = true, silent = true })

        if result.code ~= 0 then
          local err_lines = vim.split(result.stderr or "", "\n", { plain = true, trimempty = true })
          local clean_err = vim.tbl_filter(function(l)
            return not l:match("^%*%*")
          end, err_lines)
          local msg = #clean_err > 0 and table.concat(clean_err, "\n") or "remote command failed"
          vim.notify("Remote search failed: " .. msg, "error")
          return
        end

        local lines = vim.split(result.stdout, "\n", { plain = true, trimempty = true })
        if #lines == 0 then
          vim.notify("No matches for '" .. pattern .. "' on " .. sshfs.host, "warn")
          return
        end

        for i, l in ipairs(lines) do
          if l:sub(1, 1) ~= "/" then
            lines[i] = cwd .. "/" .. l
          end
        end

        MiniPick.start({ source = { items = lines, name = "Files (" .. sshfs.host .. ")" } })
      end)
    end)
  else
    local fd_results = vim.fn.systemlist({ "fdfind", "--hidden", "--exclude", ".git" })
    MiniPick.start({ source = { items = fd_results, name = "Files (fd)" } })
  end
end, { desc = "Search for file (remote-aware)" })

-- opencode.nvim
vim.o.autoread = true

vim.g.opencode_opts = {
  server = {
    url = nil,
    username = "opencode",
  },
  ask = {
    prompt = "Ask opencode: ",
  },
}

vim.keymap.set({ "n", "x" }, "<C-a>", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode" })
vim.keymap.set({ "n", "x" }, "<C-x>", function()
  require("opencode").select()
end, { desc = "Select opencode" })
vim.keymap.set({ "n", "t" }, "<C-.>", function()
  require("opencode").toggle()
end, { desc = "Toggle opencode" })

require('nvim-web-devicons').setup()

local wk = require("which-key")
wk.setup({
  delay = function(ctx)
    return ctx.plugin and 0 or 200
  end,
  preset = "helix",
  expand = function(node)
    if node.key == "l" or node.key == "s" then
      return true
    end
    return false
  end,
  replace = {
    key = {
      ["^"] = function(key)
        return key:gsub("^%^", "Ctrl-")
      end,
    },
  },
})
wk.add({
  { "<C-h>",      "<C-w>h",           desc = "Window Left",     group = "windows" },
  { "<C-j>",      "<C-w>j",           desc = "Window Down" },
  { "<C-k>",      "<C-w>k",           desc = "Window Up" },
  { "<C-l>",      "<C-w>l",           desc = "Window Right" },
  { "<leader>y",  '"+y',              mode = { 'n', 'v', 'x' }, hidden = true },
  { '<leader>q',  ':quit<cr>',        hidden = true },
  { '<leader>lf', vim.lsp.buf.format, desc = "Format" }
})


vim.keymap.set({ "n", "v" }, '<leader>sr', ':GrugFar<cr>', { desc = "Search/Replace" })

require "nvim-treesitter".setup {
  ensure_installed = { "php", "html", "css", "javascript", "typescript" },
  indent = {
    enable = true,
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'php', 'css', 'javascript', 'typescript' },
  callback = function()
    vim.treesitter.start()
  end,
})

require("nvim-ts-autotag").setup({
  filetypes = { "html", "xml", "php", "javascriptreact", "typescriptreact", "javascript", "typescript" },
})

vim.g.matchup_matchparen_deferred = 1
vim.g.matchup_matchparen_offscreen = { method = "popup" }
require("nvim-treesitter-textobjects").setup {
  select = {
    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,
    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V',  -- linewise
      ['@class.outer'] = '<c-v>', -- blockwise
    },
    include_surrounding_whitespace = false,
  },
}

vim.keymap.set({ "x", "o" }, "af", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "as", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end)

vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = true })
end, { desc = "Buffer Local Keymaps (which-key)" })

vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true, desc = "File history" })

require('grug-far').setup()

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { '<filetype>' },
--   callback = function() vim.treesitter.start() end,
-- })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local buf = args.buf
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = buf, desc = "LSP hover" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "LSP definition" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "LSP hover" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = buf, desc = "LSP implementation" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buf, desc = "LSP rename" })
  end,
})

vim.lsp.enable({ "lua_ls", "intelephense", "ts_ls", "gopls", "goimports", "html" })

vim.lsp.config("intelephense", {
  settings = {
    intelephense = {
      format = {
        braces = "k&r",
      },
      stubs = {
        "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core",
        "ctype", "curl", "date", "dba", "dom", "enchant", "exif",
        "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext",
        "gmp", "hash", "iconv", "imap", "intl", "json", "ldap",
        "libxml", "mbstring", "meta", "mysqli", "oci8", "odbc",
        "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql",
        "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", "pspell",
        "random", "readline", "Reflection", "session", "shmop",
        "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL",
        "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem",
        "sysvshm", "tidy", "tokenizer", "xml", "xmlreader", "xmlrpc",
        "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
        "wordpress",
      },
    },
    files = {
      associations = {"*.php", "*.html"}
    },
    completion = {
      insertUseDeclaration = true,
      fullyQualifyGlobalConstantsAndFunctions = true,
      triggerParameterHints = true,
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }
  }
})

vim.lsp.config("goimports", {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params(0, "utf-16")
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end
})


require("noice").setup({
  cmdline = {
    view = "cmdline",
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
    -- search_count suppressed via shortmess+=S, shown in lualine
    -- {
    --   filter = {
    --     event = "msg_show",
    --     kind = "search_count",
    --   },
    --   opts = { skip = true },
    -- },
  },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
})

-- Autocompletion setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    --     ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if vim.fn['emmet#isExpandable']() > 0 then
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes('<Plug>(emmet-expand-abbr)', true, false, true),
          'n', true
        )
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'emmet_vim' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- Cmdline completion
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

require('ftp-scratch').setup()
