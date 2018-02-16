args = {...}
file = "raw.githubusercontent.com/steffenhaug/cc/master/" .. args[1]

shell.run("wget " .. file .. " " .. args[1])