local path = "/"..fs.getDir(shell.getRunningProgram())
shell.run(path.."/src/main.lua", path)