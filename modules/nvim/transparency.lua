local function apply_transparency()
  -- 需要被强制去除背景色的高亮组列表
  local highlights = {
    "Normal",
    "NormalNC",
    "Comment",
    "Constant",
    "Special",
    "Identifier",
    "Statement",
    "PreProc",
    "Type",
    "Underlined",
    "Todo",
    "String",
    "Function",
    "Conditional",
    "Repeat",
    "Operator",
    "Structure",
    "LineNr",
    "SignColumn",
    "CursorLine",
    "CursorLineNr",
    "StatusLine",
    "StatusLineNC",
    "EndOfBuffer",
    "NormalFloat", -- 浮动窗口
    "FloatBorder", -- 浮动窗口边框
  }

  for _, group in ipairs(highlights) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
  end
end

-- 创建自动命令：每当切换/加载色彩主题时，立刻剥离其背景色
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_transparency,
})

-- 或者是手动立刻执行一次（确保如果主题已经加载也能生效）
apply_transparency()
