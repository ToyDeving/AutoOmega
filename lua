local UIS = game:GetService("UserInputService")
local Activated = false
local UisConnection
UisConnection = UIS.InputBegan:Connect(function(input, bge)
	if input.KeyCode == Enum.KeyCode.N then
		if not Activated then
			Activated = true
			DoScript()
		else
			Activated = false
		end
	elseif input.KeyCode == Enum.KeyCode.M then
		Activated = false
		UisConnection:Disconnect()
	end
end)
local DoPushup = false
local DoSquat = false

local PushupID = "rbxassetid://4931281501"
local SquatID = "rbxassetid://4934239228"

local CurrentTrack
function DoScript()
	task.spawn(function()
		while true and Activated do
			local CurrentStamina = game.Players.LocalPlayer.Character:WaitForChild("CurrentStamina")
			game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
			if DoPushup == false then
				DoPushup = true
				DoSquat = false
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:WaitForChild("Push up"))
				repeat task.wait() until CurrentStamina.Value >= 100 or Activated == false
				repeat 
					game.Players.Ruyzus.Character["Push up"]:Activate()
					repeat for i, v in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do if v.Animation.AnimationId == PushupID then CurrentTrack = v end end task.wait() until CurrentTrack ~= nil
					CurrentTrack.Stopped:Wait()
					CurrentTrack = nil
				until CurrentStamina.Value <= 13 or Activated == false
			elseif DoSquat == false then
				DoSquat = true
				DoPushup = false
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:WaitForChild("Squat"))
				repeat task.wait() until CurrentStamina.Value >= 100 or Activated == false
				repeat 
					game.Players.Ruyzus.Character["Squat"]:Activate()
					repeat for i, v in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do if v.Animation.AnimationId == SquatID then CurrentTrack = v end end task.wait() until CurrentTrack ~= nil
					CurrentTrack.Stopped:Wait()
					CurrentTrack = nil
				until CurrentStamina.Value <= 13 or Activated == false
			end
			task.wait()
		end
	end)
end
