
local aktif = false
local miktar = 0
Citizen.CreateThread(function()
	while true do
		local time = 1000
		local playerPed = PlayerPedId()
		local car = GetVehiclePedIsIn(playerPed, false)
		if car then
			if IsPedInAnyVehicle(playerPed, false) then
				time = 1
				if IsPlayerFreeAiming(PlayerId()) and not aktif and GetFollowVehicleCamViewMode() ~= 4 then
					--print("Wert")
					SetFollowVehicleCamViewMode(4)
					aktif = true
				elseif not IsPlayerFreeAiming(PlayerId()) and aktif then
					--print("Nişan iptal Wert")
					aktif = false
				elseif miktar == 1 then
					SetFollowVehicleCamViewMode(4)
					aktif = true
				end
			else
				if aktif then aktif = false end
			end

			if ( IsControlJustPressed(0, 330) ) and not IsPlayerFreeAiming(PlayerId()) and IsPedInAnyVehicle(playerPed, false) and GetFollowVehicleCamViewMode() ~= 4 then
				time = 1
				miktar = 1
			else
				miktar = 0
			end
			
			if aktif then
				time = 1
				if IsPlayerFreeAiming(PlayerId()) and GetFollowVehicleCamViewMode() ~= 4 then
					SetFollowVehicleCamViewMode(4)
				end
			end
		end
		Citizen.Wait(time)
	end
end)
