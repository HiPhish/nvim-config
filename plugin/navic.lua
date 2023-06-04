-- Location position in a buffer powered by LSP
-- https://github.com/SmiteshP/nvim-navic

local success, navic = pcall(require, 'nvim-navic')

if not success then
	return
end

local set_hl = vim.api.nvim_set_hl
local get_hl = vim.api.nvim_get_hl

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

local icon_hl = get_hl(0, {name = 'StatusLine'})
icon_hl.italic = true
for _, hlgroup in ipairs(icon_highlights) do
	set_hl(0, hlgroup, icon_hl)
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
		File          = "F ",
		Module        = "M ",
		Namespace     = "N ",
		Package       = "P ",
		Class         = "C ",
		Method        = "m ",
		Property      = "p ",
		Field         = "f ",
		Constructor   = "c ",
		Enum          = "E",
		Interface     = "I",
		Function      = "f ",
		Variable      = "v ",
		Constant      = "c ",
		String        = "s ",
		Number        = "n ",
		Boolean       = "? ",
		Array         = "[] ",
		Object        = "o ",
		Key           = "k: ",
		Null          = "∅ ",
		EnumMember    = "e ",
		Struct        = "s ",
		Event         = "e ",
		Operator      = "∘ ",
		TypeParameter = "T ",
	}
}
