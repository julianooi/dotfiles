function ColorMyPencils(color)
	color = color or "base16-ashes"
	vim.cmd.colorscheme(color)

	--	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	--
	local links = {
		["@lsp.type.namespace"] = "@namespace",
		["@lsp.type.type"] = "@type",
		["@lsp.type.class"] = "@type",
		["@lsp.type.enum"] = "@type",
		["@lsp.type.interface"] = "@type",
		["@lsp.type.struct"] = "@structure",
		["@lsp.type.parameter"] = "@parameter",
		["@lsp.type.variable"] = "@variable",
		["@lsp.type.property"] = "@property",
		["@lsp.type.enumMember"] = "@constant",
		["@lsp.type.function"] = "@function",
		["@lsp.type.method"] = "@method",
		["@lsp.type.macro"] = "@macro",
		["@lsp.type.decorator"] = "@function",
		["@lsp.mod.readonly"] = "@constant",
	}
	for newgroup, oldgroup in pairs(links) do
		vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
	end
end

ColorMyPencils()
