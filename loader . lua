local HttpService = game:GetService("HttpService")

local base = "https://raw.githubusercontent.com/dreibang/ReiHub/main"
local version_url = base .. "/version.txt"
local script_url = base .. "/AFS-GUI.lua"
local changelog_url = base .. "/changelog.txt"

local current_version = "1.0"

local success, remote_version = pcall(function()
    return game:HttpGet(version_url)
end)

if success and remote_version then
    remote_version = remote_version:gsub("%s+", "")
    if remote_version ~= current_version then
        print("🔁 ReiHub update available! v" .. remote_version)

        local changelog
        pcall(function()
            changelog = game:HttpGet(changelog_url)
        end)
        if changelog then
            print("📋 Changelog:\n" .. changelog)
        end
    else
        print("✅ ReiHub is up to date (v" .. current_version .. ")")
    end
else
    warn("⚠️ Failed to check version.")
end

loadstring(game:HttpGet(script_url))()
