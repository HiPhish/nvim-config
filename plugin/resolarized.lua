local resolarized = require 'resolarized'
local schemes = {
	'solarized',
	'solarized-dark',
	'solarized-light',
	'selenized-dark',
	'selenized-light',
	'selenized-black',
	'selenized-white',
}

local solarized = resolarized.scheme.solarized.hlgroups
local selenized = resolarized.scheme.selenized.hlgroups


---[ rainbow-delimiters.nvim ]-------------------------------------------------
solarized.RainbowDelimiterRed    = solarized.RainbowRed
solarized.RainbowDelimiterYellow = solarized.RainbowYellow
solarized.RainbowDelimiterBlue   = solarized.RainbowBlue
solarized.RainbowDelimiterGreen  = solarized.RainbowGreen
solarized.RainbowDelimiterCyan   = solarized.RainbowCyan
solarized.RainbowDelimiterOrange = solarized.RainbowOrange
solarized.RainbowDelimiterViolet = solarized.RainbowViolet

selenized.RainbowDelimiterRed    = selenized.RainbowRed
selenized.RainbowDelimiterYellow = selenized.RainbowYellow
selenized.RainbowDelimiterBlue   = selenized.RainbowBlue
selenized.RainbowDelimiterGreen  = selenized.RainbowGreen
selenized.RainbowDelimiterCyan   = selenized.RainbowCyan
selenized.RainbowDelimiterOrange = selenized.RainbowOrange
selenized.RainbowDelimiterViolet = selenized.RainbowViolet


---[ vim-matchup ]-------------------------------------------------------------
solarized.MatchWord = {bold = true}
selenized.MatchWord = {bold = true}


---[ navic ]-------------------------------------------------------------------
do
	local navic_groups = {
		'IconsFile', 'IconsModule', 'IconsNamespace', 'IconsPackage',
		'IconsClass', 'IconsMethod', 'IconsProperty', 'IconsField',
		'IconsConstructor', 'IconsEnum', 'IconsInterface', 'IconsFunction',
		'IconsVariable', 'IconsConstant', 'IconsString', 'IconsNumber',
		'IconsBoolean', 'IconsArray', 'IconsObject', 'IconsKey', 'IconsNull',
		'IconsEnumMember', 'IconsStruct', 'IconsEvent', 'IconsOperator',
		'IconsTypeParameter', 'Separator',
	}

	for _, name in ipairs(navic_groups) do
		solarized[string.format('Navic%s', name)] = 'StatusLineNC'
		selenized[string.format('Navic%s', name)] = 'StatusLineNC'
	end
end


---[ Neotest ]-----------------------------------------------------------------
for _, scheme in ipairs({selenized, solarized}) do
	scheme.NeotestPassed  = {fg = 'green',  bg=scheme.LineNr.bg}
	scheme.NeotestFailed  = {fg = 'red',    bg=scheme.LineNr.bg}
	scheme.NeotestRunning = {fg = 'yellow', bg=scheme.LineNr.bg}
	scheme.NeotestSkipped = {fg = 'yellow', bg=scheme.LineNr.bg}
end
-- 'NeotestAdapterName'
-- 'NeotestBorder'
-- 'NeotestDir'
-- 'NeotestExpandMarker'
-- 'NeotestFile'
-- 'NeotestFocused'
-- 'NeotestIndent'
-- 'NeotestMarked'
-- 'NeotestNamespace'
-- 'NeotestWinSelect'
-- 'NeotestTarget'
-- 'NeotestTest'
-- 'NeotestUnknown'




-------------------------------------------------------------------------------

for _, scheme in ipairs(schemes) do
	if vim.g.colors_name == scheme then
		vim.cmd {cmd = 'colorscheme', args = {scheme}}
		break
	end
end
