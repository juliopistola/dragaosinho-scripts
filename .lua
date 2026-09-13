--// MADIUM - FULL FIGMA STYLE UI (FIVEM / CYBERPUNK THEME) - VERSÃO COMPLETA ORIGINAL
--// Pronto para carregar via Loadstring do GitHub

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local playerGui = player:WaitForChild("PlayerGui")

local antiga = playerGui:FindFirstChild("MadiuM_FigmaUI")
if antiga then antiga:Destroy() end

local C = {
	Background = Color3.fromRGB(11, 11, 15),
	Sidebar = Color3.fromRGB(16, 16, 22),
	Container = Color3.fromRGB(20, 20, 28),
	Button = Color3.fromRGB(26, 26, 36),
	ButtonHover = Color3.fromRGB(45, 30, 75),
	NeonBlue = Color3.fromRGB(0, 180, 255),
	Text = Color3.fromRGB(240, 240, 245),
	SubText = Color3.fromRGB(120, 120, 140),
	Red = Color3.fromRGB(240, 50, 70),
	Green = Color3.fromRGB(40, 210, 110)
}

local S = {
	speed = false, jump = false, noclip = false, fly = false,
	vehFly = false, god = false, infJump = false, esp = false,
	rave = false, fullBright = false, autoClick = false,
	aimbot = false, hitbox = false
}

local specPlayer, selPlayer, flySpeed, savedWp = nil, nil, 50, nil
local bg, bv, vBg, vBv
local amigos = {}

local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "MadiuM_FigmaUI"
gui.ResetOnSpawn = false

local floating = Instance.new("TextButton", gui)
floating.Size = UDim2.fromOffset(48, 48)
floating.Position = UDim2.new(0, 25, 0.5, -24)
floating.BackgroundColor3 = C.Sidebar
floating.Text = "⚡"
floating.TextSize = 20
floating.Visible = false
Instance.new("UICorner", floating).CornerRadius = UDim.new(0, 10)
local floatStroke = Instance.new("UIStroke", floating)
floatStroke.Color = C.NeonBlue
floatStroke.Thickness = 1.5

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(780, 480)
main.Position = UDim2.new(0.5, -390, 0.5, -240)
main.BackgroundColor3 = C.Background
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(40, 35, 65)

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = C.Sidebar
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", header)
title.Position = UDim2.fromOffset(18, 0)
title.Size = UDim2.fromOffset(250, 50)
title.Text = "GULART // MENU"
title.TextColor3 = C.Text
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local status = Instance.new("TextLabel", header)
status.AnchorPoint = Vector2.new(1, 0.5)
status.Position = UDim2.new(1, -65, 0.5, 0)
status.Size = UDim2.fromOffset(200, 20)
status.Text = "● ONLINE | FPS: 60 | Ping: 0ms"
status.TextColor3 = C.Green
status.TextSize = 10
status.Font = Enum.Font.Code
status.BackgroundTransparency = 1
status.TextXAlignment = Enum.TextXAlignment.Right

local close = Instance.new("TextButton", header)
close.Size = UDim2.fromOffset(28, 28)
close.Position = UDim2.new(1, -42, 0, 11)
close.BackgroundColor3 = C.Button
close.Text = "✕"
close.TextColor3 = C.Text
close.TextSize = 12
close.Font = Enum.Font.GothamBold
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)

local menu = Instance.new("ScrollingFrame", main)
menu.Size = UDim2.fromOffset(165, 408)
menu.Position = UDim2.fromOffset(14, 60)
menu.BackgroundColor3 = C.Sidebar
menu.CanvasSize = UDim2.new(0, 0, 0, 310)
menu.ScrollBarThickness = 2
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 8)

local menuPad = Instance.new("UIPadding", menu)
menuPad.PaddingTop = UDim.new(0, 10)
menuPad.PaddingLeft = UDim.new(0, 8)
menuPad.PaddingRight = UDim.new(0, 8)

local menuLayout = Instance.new("UIListLayout", menu)
menuLayout.Padding = UDim.new(0, 5)

local contentScroll = Instance.new("ScrollingFrame", main)
contentScroll.Size = UDim2.fromOffset(573, 408)
contentScroll.Position = UDim2.fromOffset(193, 60)
contentScroll.BackgroundColor3 = C.Container
contentScroll.BackgroundTransparency = 0.5
contentScroll.ScrollBarThickness = 3
Instance.new("UICorner", contentScroll).CornerRadius = UDim.new(0, 8)

local function clearContent()
	for _, v in ipairs(contentScroll:GetChildren()) do v:Destroy() end
end

local function makeTitle(name, desc)
	local t = Instance.new("TextLabel", contentScroll)
	t.Position = UDim2.fromOffset(18, 14)
	t.Size = UDim2.new(1, -36, 0, 22)
	t.Text = name
	t.TextColor3 = C.Text
	t.TextSize = 16
	t.Font = Enum.Font.GothamBold
	t.BackgroundTransparency = 1
	t.TextXAlignment = Enum.TextXAlignment.Left

	local d = Instance.new("TextLabel", contentScroll)
	d.Position = UDim2.fromOffset(18, 36)
	d.Size = UDim2.new(1, -36, 0, 18)
	d.Text = desc
	d.TextColor3 = C.SubText
	d.TextSize = 11
	d.Font = Enum.Font.Code
	d.BackgroundTransparency = 1
	d.TextXAlignment = Enum.TextXAlignment.Left
end

local function makeButton(text, y, callback)
	local b = Instance.new("TextButton", contentScroll)
	b.Size = UDim2.new(1, -36, 0, 38)
	b.Position = UDim2.fromOffset(18, y)
	b.BackgroundColor3 = C.Button
	b.Text = text
	b.TextColor3 = C.Text
	b.TextSize = 11
	b.Font = Enum.Font.GothamMedium
	b.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	
	local pad = Instance.new("UIPadding", b)
	pad.PaddingLeft = UDim.new(0, 12)

	b.MouseEnter:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = C.ButtonHover}):Play()
	end)
	b.MouseLeave:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = C.Button}):Play()
	end)
	b.MouseButton1Click:Connect(function() if callback then callback(b) end end)
	return b
end

task.spawn(function()
	while true do
		local ok, fps = pcall(function() return math.floor(1 / RunService.RenderStepped:Wait()) end)
		local ping = 0
		pcall(function() ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
		if ok then status.Text = "● ONLINE | FPS: " .. fps .. " | Ping: " .. ping .. "ms" end
		task.wait(1)
	end
end)

task.spawn(function()
	while true do
		if S.autoClick then
			pcall(function()
				VirtualUser:Button1Down(Vector2.new(0,0))
				task.wait(0.05)
				VirtualUser:Button1Up(Vector2.new(0,0))
			end)
		end
		task.wait(0.1)
	end
end)

RunService.Heartbeat:Connect(function()
	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			if S.speed then hum.WalkSpeed = 35 end
			if S.jump then hum.JumpPower = 80 end
			if S.god then hum.Health = hum.MaxHealth end
		end
		if S.noclip or S.god then
			for _, p in ipairs(char:GetDescendants()) do
				if p:IsA("BasePart") then
					if S.noclip then p.CanCollide = false end
				end
			end
		end
	end

	if S.aimbot then
		local target, minDist = nil, math.huge
		local myRoot = char and char:FindFirstChild("HumanoidRootPart")
		if myRoot then
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= player and not amigos[p] and p.Character and p.Character:FindFirstChild("Head") then
					local dist = (p.Character.Head.Position - myRoot.Position).Magnitude
					if dist < minDist then minDist = dist target = p end
				end
			end
			if target then camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.Head.Position) end
		end
	end

	if S.hitbox then
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and not amigos[p] and p.Character then
				local root = p.Character:FindFirstChild("HumanoidRootPart")
				if root then root.Size = Vector3.new(6, 6, 6) root.Transparency = 0.7 root.CanCollide = false end
			end
		end
	end

	if specPlayer and specPlayer.Character then
		local hum = specPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then camera.CameraSubject = hum end
	end

	if selPlayer and selPlayer.Character and char and char:FindFirstChild("HumanoidRootPart") then
		local tRoot = selPlayer.Character:FindFirstChild("HumanoidRootPart")
		if tRoot then
			tRoot.CFrame = char.HumanoidRootPart.CFrame + (char.HumanoidRootPart.CFrame.LookVector * 4) + Vector3.new(0, 1, 0)
			local tHum = selPlayer.Character:FindFirstChildOfClass("Humanoid")
			if tHum then tHum.PlatformStand = true end
		end
	end

	if S.rave then
		local rainbow = Color3.fromHSV(tick() % 5 / 5, 1, 1)
		floatStroke.Color = rainbow
		mainStroke.Color = rainbow
	end
end)

RunService.RenderStepped:Connect(function()
	if S.esp then
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				local root = p.Character:FindFirstChild("HumanoidRootPart")
				if root then
					local bill = p.Character:FindFirstChild("MadiuM_ESP")
					if not bill then
						bill = Instance.new("BillboardGui", p.Character)
						bill.Name = "MadiuM_ESP"
						bill.Size = UDim2.fromOffset(100, 50)
						bill.AlwaysOnTop = true
						bill.StudsOffset = Vector3.new(0, 3, 0)
						local txt = Instance.new("TextLabel", bill)
						txt.Name = "Text"
						txt.Size = UDim2.new(1, 0, 1, 0)
						txt.BackgroundTransparency = 1
						txt.TextSize = 12
						txt.Font = Enum.Font.GothamBold
						txt.TextStrokeTransparency = 0.5
					end
					local txt = bill:FindFirstChild("Text")
					if txt then
						local dist = math.floor((camera.CFrame.Position - root.Position).Magnitude)
						if amigos[p] then
							txt.TextColor3 = C.Green
							txt.Text = "[AMIGO] " .. p.Name .. "\n[" .. dist .."m]"
						else
							txt.TextColor3 = C.Red
							txt.Text = p.Name .. "\n[" .. dist .."m]"
						end
					end
				end
			end
		end
	else
		for _, p in ipairs(Players:GetPlayers()) do
			if p.Character then
				local bill = p.Character:FindFirstChild("MadiuM_ESP")
				if bill then bill:Destroy() end
			end
		end
	end
end)

UserInputService.JumpRequest:Connect(function()
	if S.infJump and player.Character then
		local hum = player.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.N then S.noclip = not S.noclip end
	if input.KeyCode == Enum.KeyCode.Insert then
		main.Visible = not main.Visible
		floating.Visible = not main.Visible
	end
end)

local loadTab = {}

loadTab.PRINCIPAIS = function()
	clearContent()
	contentScroll.CanvasSize = UDim2.new(0, 0, 0, 500)
	makeTitle("PRINCIPAIS", "Ferramentas principais de movimentação")

	makeButton("Velocidade (WalkSpeed): [ " .. (S.speed and "ON" or "OFF") .. " ]", 70, function(b)
		S.speed = not S.speed
		b.Text = "Velocidade (WalkSpeed): [ " .. (S.speed and "ON" or "OFF") .. " ]"
		if not S.speed and player.Character then
			local h = player.Character:FindFirstChildOfClass("Humanoid")
			if h then h.WalkSpeed = 16 end
		end
	end)

	makeButton("Pulo Alto (JumpPower): [ " .. (S.jump and "ON" or "OFF") .. " ]", 115, function(b)
		S.jump = not S.jump
		b.Text = "Pulo Alto (JumpPower): [ " .. (S.jump and "ON" or "OFF") .. " ]"
		if not S.jump and player.Character then
			local h = player.Character:FindFirstChildOfClass("Humanoid")
			if h then h.JumpPower = 50 end
		end
	end)

	makeButton("Pulo Infinito (Infinite Jump): [ " .. (S.infJump and "ON" or "OFF") .. " ]", 160, function(b)
		S.infJump = not S.infJump
		b.Text = "Pulo Infinito (Infinite Jump): [ " .. (S.infJump and "ON" or "OFF") .. " ]"
	end)

	makeButton("Auto-Clicker Automático: [ " .. (S.autoClick and "ON" or "OFF") .. " ]", 205, function(b)
		S.autoClick = not S.autoClick
		b.Text = "Auto-Clicker Automático: [ " .. (S.autoClick and "ON" or "OFF") .. " ]"
	end)

	makeButton("NoClip (Atravessar - Tecla N): [ " .. (S.noclip and "ON" or "OFF") .. " ]", 250, function(b)
		S.noclip = not S.noclip
		b.Text = "NoClip (Atravessar - Tecla N): [ " .. (S.noclip and "ON" or "OFF") .. " ]"
	end)

	makeButton("Fly + Noclip (Voo Livre): [ " .. (S.fly and "ON" or "OFF") .. " ] | Vel: " .. flySpeed, 295, function(b)
		S.fly = not S.fly
		b.Text = "Fly + Noclip (Voo Livre): [ " .. (S.fly and "ON" or "OFF") .. " ] | Vel: " .. flySpeed
		local char = player.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") then return end
		local root = char.HumanoidRootPart

		if S.fly then
			bg = Instance.new("BodyGyro", root)
			bg.P, bg.maxTorque = 9e4, Vector3.new(9e9, 9e9, 9e9)
			bg.cframe = root.CFrame
			bv = Instance.new("BodyVelocity", root)
			bv.velocity = Vector3.new(0, 0.1, 0)
			bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

			task.spawn(function()
				while S.fly and gui.Parent and char and char.Parent do
					local move = Vector3.new()
					if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += camera.CFrame.LookVector end
					if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= camera.CFrame.LookVector end
					if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= camera.CFrame.RightVector end
					if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += camera.CFrame.RightVector end
					if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
					if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0, 1, 0) end
					bv.velocity = move * flySpeed
					bg.cframe = camera.CFrame
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") then part.CanCollide = false end
					end
					RunService.RenderStepped:Wait()
				end
			end)
		else
			if bg then bg:Destroy() end
			if bv then bv:Destroy() end
		end
	end)

	makeButton("Aumentar Velocidade do Fly (+25)", 340, function() flySpeed += 25 end)
	makeButton("Diminuir Velocidade do Fly (-25)", 385, function() flySpeed = math.max(25, flySpeed - 25) end)
	makeButton("Resetar Personagem", 430, function()
		if player.Character then
			local h = player.Character:FindFirstChildOfClass("Humanoid")
			if h then h.Health = 0 end
		end
	end)
end

loadTab.JOGADORES = function()
	clearContent()
	local pCount = #Players:GetPlayers()
	contentScroll.CanvasSize = UDim2.new(0, 0, 0, math.max(400, (pCount * 250) + 70))
	makeTitle("JOGADORES", "Gerenciar Amigos, Puxar, TP, Espectar e Inventário")

	local y = 70
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			local st = amigos[p] and "[ AMIGO ✓ ]" or "[ INIMIGO / NORMAL ]"
			makeButton("⭐ Alternar Amigo: " .. p.Name .. " " .. st, y, function(b)
				amigos[p] = not amigos[p]
				b.Text = "⭐ Alternar Amigo: " .. p.Name .. (amigos[p] and " [ AMIGO ✓ ]" or " [ INIMIGO / NORMAL ]")
			end)
			y += 44

			makeButton("Puxar: " .. p.Name, y, function(b)
				if selPlayer == p then
					if p.Character then
						local h = p.Character:FindFirstChildOfClass("Humanoid")
						if h then h.PlatformStand = false end
					end
					selPlayer = nil
					b.Text = "Puxar: " .. p.Name
				else
					if selPlayer and selPlayer.Character then
						local h = selPlayer.Character:FindFirstChildOfClass("Humanoid")
						if h then h.PlatformStand = false end
					end
					selPlayer = p
					b.Text = "Soltar: " .. p.Name
				end
			end)
			y += 44

			makeButton("⚡ Teleportar ATÉ: " .. p.Name, y, function()
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
				end
			end)
			y += 44

			makeButton("👁️ Espectar (Assistir): " .. p.Name, y, function(b)
				if specPlayer == p then
					specPlayer = nil
					camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
					b.Text = "👁️ Espectar (Assistir): " .. p.Name
				else
					specPlayer = p
					b.Text = "Parar de Espectar: " .. p.Name
				end
			end)
			y += 44

			makeButton("🎒 Ver Inventário de: " .. p.Name, y, function(b)
				local itens = ""
				if p.Backpack then for _, i in ipairs(p.Backpack:GetChildren()) do itens ..= i.Name .. ", " end end
				if p.Character then
					for _, i in ipairs(p.Character:GetChildren()) do
						if i:IsA("Tool") then itens ..= i.Name .. " (Equipado), " end
					end
				end
				if itens == "" then itens = "Mochila Vazia" end
				b.Text = "Itens: " .. string.sub(itens, 1, 35) .. "..."
				task.delay(4, function() b.Text = "🎒 Ver Inventário de: " .. p.Name end)
			end)
			y += 50
		end
	end
end

loadTab.VEÍCULOS = function()
	clearContent()
	contentScroll.CanvasSize = UDim2.new(0, 0, 0, 230)
	makeTitle("VEÍCULOS", "Ferramentas para veículos e mapas")

	makeButton("Fly Vehicular (Fazer Veículo Voar): [ " .. (S.vehFly and "ON" or "OFF") .. " ]", 70, function(b)
		S.vehFly = not S.vehFly
		b.Text = "Fly Vehicular (Fazer Veículo Voar): [ " .. (S.vehFly and "ON" or "OFF") .. " ]"
		
		task.spawn(function()
			while S.vehFly and gui.Parent do
				local char = player.Character
				if char and char:FindFirstChildOfClass("Humanoid") then
					local seat = char.Humanoid.SeatPart
					if seat and seat.Parent then
						local primary = seat.Parent.PrimaryPart or seat
						if not vBg then
							vBg = Instance.new("BodyGyro", primary)
							vBg.P, vBg.maxTorque = 9e4, Vector3.new(9e9, 9e9, 9e9)
							vBv = Instance.new("BodyVelocity", primary)
							vBv.maxForce = Vector3.new(9e9, 9e9, 9e9)
						end
						local move = Vector3.new()
						if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += camera.CFrame.LookVector end
						if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= camera.CFrame.LookVector end
						if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= camera.CFrame.RightVector end
						if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += camera.CFrame.RightVector end
						if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
						vBv.velocity = move * 60
						vBg.cframe = camera.CFrame
					end
				end
				if not S.vehFly then
					if vBg then vBg:Destroy() vBg = nil end
					if vBv then vBv:Destroy() vBv = nil end
					break
				end
				RunService.RenderStepped:Wait()
			end
			if vBg then vBg:Destroy() vBg = nil end
			if vBv then vBv:Destroy() vBv = nil end
		end)
	end)

	makeButton("Puxar Ferramentas do Mundo", 115, function()
		for _, obj in ipairs(Workspace:GetDescendants()) do
			if obj:IsA("Tool") then obj:Clone().Parent = player.Backpack end
		end
	end)

	makeButton("Virar Veículo / Desbugar Posição", 160, function()
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local r = player.Character.HumanoidRootPart
			r.CFrame = CFrame.new(r.Position + Vector3.new(0, 3, 0))
		end
	end)
end

loadTab.TELEPORTE = function()
	clearContent()
	contentScroll.CanvasSize = UDim2.new(0, 0, 0, 275)
	makeTitle("TELEPORTE", "Ferramentas de localização e Waypoints")

	makeButton("Salvar Posição Atual (Waypoint)", 70, function(b)
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			savedWp = player.Character.HumanoidRootPart.CFrame
			b.Text = "Posição Salva com Sucesso! [✓]"
			task.delay(2, function() b.Text = "Salvar Posição Atual (Waypoint)" end)
		end
	end)

	makeButton("Ir para Posição Salva", 115, function(b)
		if savedWp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = savedWp + Vector3.new(0, 3, 0)
		else
			b.Text = "Nenhum Waypoint Salvo!"
			task.delay(2, function() b.Text = "Ir para Posição Salva" end)
		end
	end)

	makeButton("Teleportar para Cima (Subir 50 studs)", 160, function()
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame += Vector3.new(0, 50, 0)
		end
	end)

	makeButton("Teleportar para o Spawn do Jogo", 205, function()
		local sp = Workspace:FindFirstChildOfClass("SpawnLocation")
		if sp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = sp.CFrame + Vector3.new(0, 3, 0)
		end
	end)
end

loadTab.ADMIN = function()
	clearContent()
	contentScroll.CanvasSize = UDim2.new(0, 0, 0, 365)
	makeTitle("ADMIN", "Aimbot, Hitbox Extender, ESP e FullBright")

	makeButton("🎯 Aimbot Automático (Trava de Mira): [ " .. (S.aimbot and "ON" or "OFF") .. " ]", 70, function(b)
		S.aimbot = not S.aimbot
		b.Text = "🎯 Aimbot Automático (Trava de Mira): [ " .. (S.aimbot and "ON" or "OFF") .. " ]"
	end)

	makeButton("📦 Hitbox Extender (Aumentar Inimigos): [ " .. (S.hitbox and "ON" or "OFF") .. " ]", 115, function(b)
		S.hitbox = not S.hitbox
		b.Text = "📦 Hitbox Extender (Aumentar Inimigos): [ " .. (S.hitbox and "ON" or "OFF") .. " ]"
	end)

	makeButton("ESP / Wallhack (Players e Amigos): [ " .. (S.esp and "ON" or "OFF") .. " ]", 160, function(b)
		S.esp = not S.esp
		b.Text = "ESP / Wallhack (Players e Amigos): [ " .. (S.esp and "ON" or "OFF") .. " ]"
	end)

	makeButton("FullBright / Remover Escuridão e Fog: [ " .. (S.fullBright and "ON" or "OFF") .. " ]", 205, function(b)
		S.fullBright = not S.fullBright
		b.Text = "FullBright / Remover Escuridão e Fog: [ " .. (S.fullBright and "ON" or "OFF") .. " ]"
		Lighting.Brightness = S.fullBright and 2 or 1
		Lighting.ClockTime = S.fullBright and 14 or 12
		Lighting.GlobalShadows = not S.fullBright
		Lighting.FogEnd = S.fullBright and 9e9 or 100000
	end)

	makeButton("God Mode (Vida Infinita): [ " .. (S.god and "ON" or "OFF") .. " ]", 250, function(b)
		S.god = not S.god
		b.Text = "God Mode (Vida Infinita): [ " .. (S.god and "ON" or "OFF") .. " ]"
	end)

	makeButton("Curar / Encher Vida", 295, function()
		if player.Character then
			local h = player.Character:FindFirstChildOfClass("Humanoid")
			if h then h.Health = h.MaxHealth end
		end
	end)
end

loadTab.CONFIG = function()
	clearContent()
	contentScroll.CanvasSize = UDim2.new(0, 0, 0, 275)
	makeTitle("CONFIG", "Configurações da interface e temas")

	makeButton("Modo Rave RGB (Cores Dinâmicas): [ " .. (S.rave and "ON" or "OFF") .. " ]", 70, function(b)
		S.rave = not S.rave
		b.Text = "Modo Rave RGB (Cores Dinâmicas): [ " .. (S.rave and "ON" or "OFF") .. " ]"
		if not S.rave then
			floatStroke.Color = C.NeonBlue
			mainStroke.Color = Color3.fromRGB(40, 35, 65)
		end
	end)

	makeButton("Fechar Painel", 115, function() main.Visible = false floating.Visible = true end)
	makeButton("Reabrir Painel", 160, function() main.Visible = true floating.Visible = false end)
	makeButton("Restaurar Posição da Tela", 205, function() main.Position = UDim2.new(0.5, -390, 0.5, -240) end)
end

local tabBtns = {}
local function selectTab(name)
	if loadTab[name] then loadTab[name]() end
	for tName, btn in pairs(tabBtns) do
		btn.BackgroundColor3 = (tName == name) and C.ButtonHover or C.Button
		btn.TextColor3 = (tName == name) and C.NeonBlue or C.SubText
	end
end

for _, name in ipairs({"PRINCIPAIS", "JOGADORES", "VEÍCULOS", "TELEPORTE", "ADMIN", "CONFIG"}) do
	local b = Instance.new("TextButton", menu)
	b.Size = UDim2.new(1, 0, 0, 38)
	b.BackgroundColor3 = C.Button
	b.Text = name
	b.TextColor3 = C.SubText
	b.TextSize = 11
	b.Font = Enum.Font.GothamBold
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	tabBtns[name] = b
	b.MouseButton1Click:Connect(function() selectTab(name) end)
end

close.MouseButton1Click:Connect(function() main.Visible = false floating.Visible = true end)
floating.MouseButton1Click:Connect(function() main.Visible = true floating.Visible = false end)

local dragging, dragStart, startPos
header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true dragStart = input.Position startPos = main.Position
	end
end)
header.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

selectTab("PRINCIPAIS")
print("[MadiuM Figma] Versão Completa carregada com sucesso!")
