--// Stellix Admin 6/21/2021


local Admin = {
    Prefix = ">",
    Ver = "1.0",
    Cmds = {}                     
}

--//Variables
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local workspace = game:GetService("Workspace")



--//Functions 

Admin.AddCommand = function(Name, Function)
    Admin.Cmds[Name] = Function 
end 

Admin.GetPlayers = function(target) 
    local plrs = game:service("Players"):GetPlayers()
	if target:lower() == "all" then
		return plrs
	elseif target:lower() == "others" then
		for index, plr in pairs(plrs) do
			if plr == game:service("Players").LocalPlayer then
				table.remove(plrs, index)
				return plrs
			end
		end
	elseif target:lower() == "me" then
		return {game:service("Players").LocalPlayer}
	else
		local plrTargets = {}
		for index, plr in pairs(plrs) do
      if plr.Name:sub(1, #target):lower() == target:lower() or plr.DisplayName:sub(1, #target) == target:lower() then
			  table.insert(plrTargets, plr)
      end
		end
		return plrTargets
	end
end 

Admin.ExecuteCommand = function(cmdText)
    local cmd = cmdText:match("^" .. Admin.Prefix .. "%w+"):sub(2)
	local args = cmdText:gsub(cmdText:match("^" .. Admin.Prefix .. "%w+").." ",""):gsub(", ",","):split(",")
	if type(Admin.Cmds[cmd]) == "function" then
		Admin.Cmds[cmd](unpack(args))
	else
		warn("Unknown Command", 'Cannot find command called "' .. cmd .. '"')
	end
end


game:service("Players").LocalPlayer.Chatted:Connect(function(msg)
	if msg:match("^".. Admin.Prefix) then
		Admin.ExecuteCommand(msg)
	end

end)

local net = true 

local function CFrameBypass(tool,pos)
    local Arm = game.Players.LocalPlayer.Character['Right Arm'].CFrame * CFrame.new(0, -1, 0, 1, 0, 0, 0, 0, 1, 0, -1, 0)
    local cframe = Arm:toObjectSpace(pos):inverse()
    tool.Parent = game.Players.LocalPlayer.Backpack
    tool.Grip = cframe
end

Admin.Attach = function(Target)
    if (Target) then  
         local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid") 
         LocalPlayer.Character.Animate.Disabled = true
         local Clone = Humanoid:Clone(); Clone.Parent = LocalPlayer.Character Humanoid:Destroy()
         LocalPlayer.Character.Animate.Disabled = false  
         wait()
         local Tool = nil 
         for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do 
            if tool:IsA("Tool") then 
                Tool = tool 
                print(Tool)
                Tool.Parent = LocalPlayer.Character
                repeat 
                    Target.Character:SetPrimaryPartCFrame(tool.Handle.CFrame)
                    wait()
                 until tool.Parent == Target.Character 
              end 
         end 
    end 
end 

Admin.RegularAttach = function(Target)
    if (Target) then  
        local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid") 
        LocalPlayer.Character.Animate.Disabled = true
        local Clone = Humanoid:Clone(); Clone.Parent = LocalPlayer.Character Humanoid:Destroy()
        LocalPlayer.Character.Animate.Disabled = false  
        wait()
   end 
end 

Admin.AddCommand("whitelist", function(target)
    for _, plr in pairs(Admin.GetPlayers(target)) do 
        if (plr) then 
            warn(plr.Name)
            while wait() do
                workspace.FallenPartsDestroyHeight = 0/0
                plr.MaximumSimulationRadius = 0/0
                setsimulationradius(0/0, 0/0)
                coroutine.wrap(function()
                    plr.MaximumSimulationRadius = 0/0
                    setsimulationradius(0/0, 0/0)
                end)()
            end
        end --
    end 
end, "Player") 

Admin.AddCommand("kill", function(target)
    for _, plr in pairs(Admin.GetPlayers(target)) do 
         if (plr) and (game:service("Players").LocalPlayer.Character) then 
             warn(plr.Name)
             local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid") 
             LocalPlayer.Character.Animate.Disabled = true
             local Clone = Humanoid:Clone(); Clone.Parent = LocalPlayer.Character Humanoid:Destroy()
             LocalPlayer.Character.Animate.Disabled = false  
             wait()
             local Tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
             Tool.Parent = LocalPlayer.Character
             wait() 
             repeat wait() plr.Character.HumanoidRootPart.CFrame = Tool.Handle.CFrame until Tool.Parent == plr.Character
             firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Tool.Handle, 0)
             firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Tool.Handle, 1)
             LocalPlayer.Character.Humanoid.Health = 0
             LocalPlayer.Character = nil 
         end 
    end 
end, "Player")

Admin.AddCommand("tbring", function(target)
    for _, plr in pairs(Admin.GetPlayers(target)) do 
        if (plr) and (game:service("Players").LocalPlayer.Character) then 
            warn(plr.Name)
            local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid") 
            LocalPlayer.Character.Animate.Disabled = true
            local Clone = Humanoid:Clone(); Clone.Parent = LocalPlayer.Character Humanoid:Destroy()
            LocalPlayer.Character.Animate.Disabled = false  
            wait()
            local Tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
            Tool.Parent = LocalPlayer.Character
            wait() 
            repeat wait() plr.Character.HumanoidRootPart.CFrame = Tool.Handle.CFrame until Tool.Parent == plr.Character
            firetouchinterest(plr.Character.HumanoidRootPart, Tool.Handle, 0)
            firetouchinterest(plr.Character.HumanoidRootPart, Tool.Handle, 1)
        end 
   end 
end, "Player") 
