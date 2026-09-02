" SPDX-FileCopyrightText: © 2019 HiPhish
" SPDX-License-Identifier: 0BSD

if !&textwidth
	setlocal textwidth=100
endif

" ---[ Build system detection ]------------------------------------------------
" Known build system specifications in decreasing order of relevance; a
" specifications is a list of three elements: the settings file, the name of
" the build system binary, and the wrapper file
let s:build_systems = [
	\ ['makefile', 'make', ''],
	\ ['Makefile', 'make', ''],
	\ ['build.gradle', 'gradle -q', 'gradlew -q'],
	\ ['pom.xml', 'mvn -q', 'mvnw -q'],
\ ]

for [s:settings, s:makeprg, s:wrapper] in s:build_systems
	if filereadable(s:settings)
		let &makeprg = executable(s:wrapper) ? './'..s:wrapper : s:makeprg
		break
	endif
endfor


" ---[ vim-test integration ]--------------------------------------------------
if filereadable('build.gradle') && !has_key(g:, 'test#java#runner')
   	let test#java#runner = 'gradletest'
endif
