-- Location position in a buffer powered by LSP
-- https://github.com/SmiteshP/nvim-navic

local success, navic = pcall(require, 'nvim-navic')

if not success then
	return
end

local set_hl = vim.api.nvim_set_hl

-- Highlight groups
local icon_highlights = {
	'NavicIconsFile',
	'NavicIconsModule',
	'NavicIconsNamespace',
	'NavicIconsPackage',
	'NavicIconsClass',
	'NavicIconsMethod',
	'NavicIconsProperty',
	'NavicIconsField',
	'NavicIconsConstructor',
	'NavicIconsEnum',
	'NavicIconsInterface',
	'NavicIconsFunction',
	'NavicIconsVariable',
	'NavicIconsConstant',
	'NavicIconsString',
	'NavicIconsNumber',
	'NavicIconsBoolean',
	'NavicIconsArray',
	'NavicIconsObject',
	'NavicIconsKey',
	'NavicIconsNull',
	'NavicIconsEnumMember',
	'NavicIconsStruct',
	'NavicIconsEvent',
	'NavicIconsOperator',
	'NavicIconsTypeParameter',
}

for _, hlgroup in ipairs(icon_highlights) do
	set_hl(0, hlgroup, {link = 'StatusLineNC'})
end

set_hl(0, 'NavicSeparator', {link = 'StatusLineNC'})

navic.setup {
	separator = ' ╱ ',
	-- safe_output = true,
	click = true,
	highlight = true,
	lsp = {
		auto_attach = true,
	},
	icons = {
		File          = "𝐅 ",
		Module        = "𝐌 ",
		Namespace     = "𝐍 ",
		Package       = "𝐏 ",
		Class         = "𝐶 ",
		Method        = "𝑚 ",
		Property      = "𝑝 ",
		Field         = "𝒇 ",
		Constructor   = "𝐜 ",
		Enum          = "𝐸",
		Interface     = "𝐼",
		Function      = "𝑓 ",
		Variable      = "𝑣 ",
		Constant      = "𝑐 ",
		String        = "𝑠 ",
		Number        = "𝑛 ",
		Boolean       = "? ",
		Array         = "[] ",
		Object        = "𝑜 ",
		Key           = "🗝 ",
		Null          = "∅ ",
		EnumMember    = "𝑒 ",
		Struct        = "𝑆 ",
		Event         = "𝑒 ",
		Operator      = "∘ ",
		TypeParameter = "𝐓 ",
	}
}
