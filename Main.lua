local executed
local any = "Any.lua"
local main = {
    ["Games"] = "https://raw.githubusercontent.com/FemIsCool/Sigma/main/Games/",
    ["GuiLibraray"] = "https://raw.githubusercontent.com/FemIsCool/Sigma/main/GuiLibrary.lua/",
    ["Main"] = "https://raw.githubusercontent.com/FemIsCool/Sigma/main/Main.lua/",
}
local function url(link)
    loadstring(game:HttpGet(link, true))()
end
if executed == false then
    executed = true
else
    error("Sigma already executed!")
    return
end
local function loadGame(id)
    if main["Main"]..id..".lua" then
        url(main["Main"]..id..".lua")
    else
        url(main["Games"]..any)
        error("Game was either not supported or there was a error")
    end
end
repeat task.wait() until game:IsLoaded() == true
