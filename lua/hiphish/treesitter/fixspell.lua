-- At the moment treesitter-nvim has a problem with spell checking in that it
-- will try to spell-check everything. This will work around the issue until a
-- clean solution can be found.
--
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/698

local spellgroups = {
	c = {
		{  -- Single-line comment
			type = 'match',
			pattern = '"//.*"'
		}, {  -- C comment
			type = 'region',
			start = [["\v\/\*"]],
			['end'] = '"\\v\\*\\/"',
		}, {  -- String literal
			type = 'region',
			start = [[+"+]],
			skip = [[+\\"+]],
			['end'] = [[+"+]],
		}
	},
	javascript = {
		{  -- Double-quote Javascript string
			type = 'region',
			start = [[+"+]],
			skip = [[+\\"+]],
			['end'] = [[+"+]],
		}, {  -- Single-quote Javascript string
			type = 'region',
			start = [[+'+]],
			skip = [[+\\'+]],
			['end'] = [[+'+]],
		}, {  -- Javascript single-line comment
			type = 'match',
			pattern = '"//.*"'
		}, {  -- Javascript multi-line comment
			type = 'region',
			start = [["\v\/\*"]],
			['end'] = '"\\v\\*\\/"',
		}
	},
	html = {
		{  -- HTML/XML comment
			type = 'region',
			start = [[+<!--+]],
			['end'] = [[+-->+]],
		}
	},
	css = {
		{  -- CSS comment
			type = 'region',
			start = [["\v\/\*"]],
			['end'] = '"\\v\\*\\/"',
		}
	},
}

spellgroups.typescript = spellgroups.javascript
spellgroups.vue = vim.list_extend({}, spellgroups.html)
spellgroups.vue = vim.list_extend(spellgroups.vue, spellgroups.javascript)
spellgroups.vue = vim.list_extend(spellgroups.vue, spellgroups.css)

local spell_spec_to_cmd = {
	match = function(spec)
		return string.format('syntax match spellComment %s contains=@Spell', spec.pattern)
	end,
	region = function(spec)
		local start = spec.start
		local end_ = spec['end']
		local skip = spec.skip
		if skip then
			return string.format('syntax region spellComment start=%s skip=%s end=%s contains=@Spell', start, skip, end_)
		end
		return string.format('syntax region spellComment start=%s end=%s contains=@Spell', start, end_)
	end
}


return {
	enable = true,
	attach = function (_, lang)
		local specs = spellgroups[lang]
		if not specs then
			return
		end
		for _, spec in pairs(specs) do
			local cmd = spell_spec_to_cmd[spec.type](spec)
			vim.cmd(cmd)
		end
	end,
	detach = function(_) end,
	is_supported = function(lang)
		if not spellgroups[lang] then
			return false
		end
		if not require'nvim-treesitter.query'.get_query(lang, 'highlights') then
			return false
		end
		return true
	end
}
