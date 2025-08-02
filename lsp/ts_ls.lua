local tsserver_inlay_hints_settings = {
  includeInlayEnumMemberValueHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayVariableTypeHints = true,
}

return {
  setings = {
    javascript = {
      inlayHints = tsserver_inlay_hints_settings,
    },
    javascriptreact = {
      inlayHints = tsserver_inlay_hints_settings,
    },
    typescript = {
      inlayHints = tsserver_inlay_hints_settings,
    },
    typescriptreact = {
      inlayHints = tsserver_inlay_hints_settings,
    },
  },
}
