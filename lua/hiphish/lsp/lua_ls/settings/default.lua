---Default settings, used by all other settings.
---
---This table forms a basis of my personal defaults which I want to use for all
---other configurations. More concrete settings should overwrite and extend
---this table.
local M = {
	Lua = {
		completion = {
			callSnippet = 'Both',
		},
		diagnostics = {
			-- Do not warn about unused underscore variables
			unusedLocalExclude = {'_*'},
		},
		workspace = {
			maxPreload = 1000,
			preloadFileSize = 1000,
			checkThirdParty = false,
		},
		telemetry = {
			enable = false,
		},
	}
}


return M
