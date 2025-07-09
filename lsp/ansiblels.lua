---Language server for the ansible configuration management tool.
---
---https://github.com/ansible/vscode-ansible
---
---`ansible-language-server` can be installed via `npm`:
---
---```sh
---npm install -g @ansible/ansible-language-server
---```
return {
	cmd = {'ansible-language-server', '--stdio'},
	filetypes = {'yaml.ansible'},
	root_markers = {'ansible.cfg', '.ansible-lint'},
	settings = {
		python = {
			interpreterPath = 'python',
		},
		ansible = {
			path = 'ansible',
		},
		executionEnvioronment = {
			enabled = false,
		},
		validation = {
			enabled = true,
			lint = {
				endabled = true,
				path = 'ansible-lint',
			},
		},
	},
}
