file = "raw.githubusercontent.com/steffenhaug/cc/master/" .. arg[1]

shell.run("wget " .. file .. " " .. arg[1])