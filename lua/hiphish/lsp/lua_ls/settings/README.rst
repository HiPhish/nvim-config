.. SPDX-FileCopyrightText: © 2021 HiPhish
.. SPDX-License-Identifier: 0BSD
.. default-role:: code

Predefined settings
===================

These files describe the server settings for the various purposes Lua can be
used for.

The values of `Lua.runtime.path` and `Lua.workspace.library` are still a
mystery to me. According to the author it works as follows:

- `Lua.runtime.path` is used for `require` and contains the same patterns
  as `package.path` in Lua, except as a list table instead of a string
- `Lua.library.workspace` is a table with paths for keys; these paths are
  recursively searched for global definitions.

Either his explanation is wrong, or the code does not work properly. The
below values are just me randomly poking at things until everything works,
or at least seems to work.

Here are my findings:

- The directories in `Lua.workspace.library` need to be one level *above*
  the directory containing the modules. E.g. for Luarocks use
  `~/.luarocks/share/lua` instead of `~/.luarocks/share/lua/5.3`

- The patterns in `Lua.runtime.require` should be the usual patterns (e.g.
  `{'?.lua', '?/init.lua}`, except prefixed with the directory missing
  from above. E.g. for Luarocks use `{'5.3/?.lua', '5.3/?/init.lua'}`

Any other combination seems to produce either too many (and wrong)
suggestions, or the symbol cannot be resolved.
