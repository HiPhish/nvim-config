local resolarized = require 'resolarized'
local schemes = {
	'solarized',
	'solarized-dark',
	'solarized-light',
	'selenized-dark',
	'selenized-light',
	'selenized-black',
	'selenized-light',
}

local solarized = resolarized.scheme.solarized.hlgroups
local selenized = resolarized.scheme.selenized.hlgroups


---[ nvim-ts-rainbow2 ]--------------------------------------------------------
solarized.TSRainbowRed    = solarized.RainbowRed
solarized.TSRainbowYellow = solarized.RainbowYellow
solarized.TSRainbowBlue   = solarized.RainbowBlue
solarized.TSRainbowGreen  = solarized.RainbowGreen
solarized.TSRainbowCyan   = solarized.RainbowCyan
solarized.TSRainbowOrange = solarized.RainbowOrange
solarized.TSRainbowViolet = solarized.RainbowViolet

selenized.TSRainbowRed    = selenized.RainbowRed
selenized.TSRainbowYellow = selenized.RainbowYellow
selenized.TSRainbowBlue   = selenized.RainbowBlue
selenized.TSRainbowGreen  = selenized.RainbowGreen
selenized.TSRainbowCyan   = selenized.RainbowCyan
selenized.TSRainbowOrange = selenized.RainbowOrange
selenized.TSRainbowViolet = selenized.RainbowViolet


---[ vim-matchup ]-------------------------------------------------------------
solarized.MatchWord = {bold = true}
selenized.MatchWord = {bold = true}


---[ navic ]-------------------------------------------------------------------
solarized.NavicIconsFile          = 'StatusLineNC'
solarized.NavicIconsModule        = 'StatusLineNC'
solarized.NavicIconsNamespace     = 'StatusLineNC'
solarized.NavicIconsPackage       = 'StatusLineNC'
solarized.NavicIconsClass         = 'StatusLineNC'
solarized.NavicIconsMethod        = 'StatusLineNC'
solarized.NavicIconsProperty      = 'StatusLineNC'
solarized.NavicIconsField         = 'StatusLineNC'
solarized.NavicIconsConstructor   = 'StatusLineNC'
solarized.NavicIconsEnum          = 'StatusLineNC'
solarized.NavicIconsInterface     = 'StatusLineNC'
solarized.NavicIconsFunction      = 'StatusLineNC'
solarized.NavicIconsVariable      = 'StatusLineNC'
solarized.NavicIconsConstant      = 'StatusLineNC'
solarized.NavicIconsString        = 'StatusLineNC'
solarized.NavicIconsNumber        = 'StatusLineNC'
solarized.NavicIconsBoolean       = 'StatusLineNC'
solarized.NavicIconsArray         = 'StatusLineNC'
solarized.NavicIconsObject        = 'StatusLineNC'
solarized.NavicIconsKey           = 'StatusLineNC'
solarized.NavicIconsNull          = 'StatusLineNC'
solarized.NavicIconsEnumMember    = 'StatusLineNC'
solarized.NavicIconsStruct        = 'StatusLineNC'
solarized.NavicIconsEvent         = 'StatusLineNC'
solarized.NavicIconsOperator      = 'StatusLineNC'
solarized.NavicIconsTypeParameter = 'StatusLineNC'
solarized.NavicSeparator          = 'StatusLineNC'

selenized.NavicIconsFile          = 'StatusLineNC'
selenized.NavicIconsModule        = 'StatusLineNC'
selenized.NavicIconsNamespace     = 'StatusLineNC'
selenized.NavicIconsPackage       = 'StatusLineNC'
selenized.NavicIconsClass         = 'StatusLineNC'
selenized.NavicIconsMethod        = 'StatusLineNC'
selenized.NavicIconsProperty      = 'StatusLineNC'
selenized.NavicIconsField         = 'StatusLineNC'
selenized.NavicIconsConstructor   = 'StatusLineNC'
selenized.NavicIconsEnum          = 'StatusLineNC'
selenized.NavicIconsInterface     = 'StatusLineNC'
selenized.NavicIconsFunction      = 'StatusLineNC'
selenized.NavicIconsVariable      = 'StatusLineNC'
selenized.NavicIconsConstant      = 'StatusLineNC'
selenized.NavicIconsString        = 'StatusLineNC'
selenized.NavicIconsNumber        = 'StatusLineNC'
selenized.NavicIconsBoolean       = 'StatusLineNC'
selenized.NavicIconsArray         = 'StatusLineNC'
selenized.NavicIconsObject        = 'StatusLineNC'
selenized.NavicIconsKey           = 'StatusLineNC'
selenized.NavicIconsNull          = 'StatusLineNC'
selenized.NavicIconsEnumMember    = 'StatusLineNC'
selenized.NavicIconsStruct        = 'StatusLineNC'
selenized.NavicIconsEvent         = 'StatusLineNC'
selenized.NavicIconsOperator      = 'StatusLineNC'
selenized.NavicIconsTypeParameter = 'StatusLineNC'
selenized.NavicSeparator          = 'StatusLineNC'


-------------------------------------------------------------------------------

for _, scheme in ipairs(schemes) do
	if vim.g.colors_name == scheme then
		vim.cmd.colorscheme(scheme)
	end
end
