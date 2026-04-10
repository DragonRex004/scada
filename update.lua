local base = "https://raw.githubusercontent.com/DragonRex004/scada/main/"

local files = {
    "main.lua",
    "startup.lua",
    "config.lua",
    "lib/ui.lua",
    "lib/energy.lua"
}

for _, file in ipairs(files) do
    print("Updating " .. file .. "...")
    shell.run("delete " .. file)
    shell.run("wget " .. base .. file .. " " .. file)
end

print("Update complete!")