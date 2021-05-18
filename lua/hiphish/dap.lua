local dap = require 'dap'

require 'hiphish.dap.options'  -- Required for side effects only

for language, adapter in pairs(require 'hiphish.dap.adapters') do
	dap.adapters[language] = adapter
end

for language, configurations in pairs(require 'hiphish.dap.configurations') do
	dap.configurations[language] = configurations
end

require 'hiphish.dap.debugpy'
