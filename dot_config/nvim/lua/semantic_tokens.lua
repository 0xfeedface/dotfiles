local vim = vim
local M = {}

-- TODO: get legend from server
local token_kinds = {
  "Variable",
  "LocalVariable",
  "Parameter",
  "Function",
  "Method",
  "StaticMethod",
  "Field",
  "StaticField",
  "Class",
  "Interface",
  "Enum",
  "EnumConstant",
  "Typedef",
  "DependentType",
  "DependentName",
  "Namespace",
  "TemplateParameter",
  "Concept",
  "Primitive",
  "Macro",
  "InactiveCode"
}

local token_kind_to_highlight_group = {
  -- ["Variable"] = "Normal",
  -- ["LocalVariable"] = "Normal",
  -- ["Parameter"] = "Normal",
  -- ["Function"] = "Function",
  -- ["Method"] = "Function",
  -- ["StaticMethod"] = "Function",
  -- ["Field"] = "Normal",
  -- ["StaticField"] = "Normal",
  -- ["Class"] = "Structure",
  -- ["Enum"] = "Structure",
  -- ["EnumConstant"] = "Constant",
  -- ["Typedef"] = "Typedef",
  -- ["DependentType"] = "Type",
  -- ["DependentName"] = "Type",
  -- ["Namespace"] = "Type",
  -- ["TemplateParameter"] = "Type",
  -- ["Concept"] = "Type",
  -- ["Primitive"] = "Constant",
  -- ["Macro"] = "Macro",
  -- ["InactiveCod"] = "Normal",

  ["Variable"] = "Normal",
  ["LocalVariable"] = "Normal",
  ["Parameter"] = "Normal",
  ["Function"] = "Function",
  ["Method"] = "Function",
  ["StaticMethod"] = "Function",
  ["Field"] = "Normal",
  ["StaticField"] = "Normal",
  ["Class"] = "Type",
  ["Interface"] = "Type",
  ["Enum"] = "Type",
  ["EnumConstant"] = "Constant",
  ["Typedef"] = "Typedef",
  ["DependentType"] = "Type",
  ["DependentName"] = "Normal",
  ["Namespace"] = "Normal",
  ["TemplateParameter"] = "Normal",
  ["Concept"] = "Normal",
  -- auto is sometimes a primitive
  ["Primitive"] = "Type",
  ["Macro"] = "Macro",
  ["InactiveCode"] = "Comment",
}

M.hl_namespace = vim.api.nvim_create_namespace('semantic-tokens-ns')

function M.get_highlight_callback(bufnr)
  return function(_, result, ctx, config)
    if result == nil or result['data'] == nil then
      return
    end

    vim.api.nvim_buf_clear_namespace(
      bufnr,
      M.hl_namespace,
      0,
      -1
    )

    local line = 0
    local start = 0
    local data = result["data"]
    local num_tokens = math.floor(table.getn(data) / 5)

    for i = 0, num_tokens - 1 do
      local first_idx = 5*i + 1
      local delta_line = data[first_idx]
      local delta_start = data[first_idx + 1]
      local length = data[first_idx + 2]
      local token_idx = data[first_idx + 3] + 1
      local token_kind = token_kinds[token_idx]

      line = line + delta_line
      if delta_line == 0 then
        start = start + delta_start
      else
        start = delta_start
      end

      vim.api.nvim_buf_add_highlight(
        bufnr,
        M.hl_namespace,
        token_kind_to_highlight_group[token_kind],
        line,
        start,
        start + length
      )
    end
  end
end

M.on_attach = function (_, _)
  local bufnr = vim.api.nvim_get_current_buf()
  local callback = function ()
    local params = { textDocument = { uri = vim.uri_from_bufnr(bufnr) } }
    vim.lsp.buf_request(
      bufnr,
      "textDocument/semanticTokens/full",
      params,
      M.get_highlight_callback(bufnr)
    )
  end
  vim.api.nvim_buf_attach(bufnr, false, {
    on_lines = callback
  })
  callback()
end

return M
