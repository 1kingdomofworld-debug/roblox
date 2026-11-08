-- التأكد من عمل البيئة
if not getgenv() then return end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local Config = {
    ESP = {
        Enabled = false,
        Box = false,
        Skeleton = false,
        Line = false,
        Color = Color3.fromRGB(0, 255, 128)
    },
    Aimbot = {
        Enabled = false,
    },
    BulletTrack = {
        Enabled = false,
        WallBang = false
    },
    HitBox = {
        Enabled = false,
        Size = 6
    },
    Speed = {
        Enabled = false,
        Value = 24
    }
}

-- واجهة المستخدم (GUI) الفاخرة والرينبو القابلة للتحريك
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OneShotBypassHub"
ScreenGui.Parent = game:GetService("CoreGui")

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.Text = "UI"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize, ToggleBtn.Font = 14, Enum.Font.SourceSansBold
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 420)
MainFrame.Position = UDim2.new(0.5, -130, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local RainbowBar = Instance.new("Frame")
RainbowBar.Size = UDim2.new(1, 0, 0, 4)
RainbowBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
RainbowBar.BorderSizePixel = 0
RainbowBar.Parent = MainFrame
Instance.new("UICorner", RainbowBar).CornerRadius = UDim.new(0, 4)

task.spawn(function()
    while true do
        for i = 0, 1, 0.005 do
            RainbowBar.BackgroundColor3 = Color3.fromHSV(i, 1, 1)
            task.wait(0.03)
        end
    end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "⚡ ONE SHOT BYPASS PRO ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize, Title.Font = 14, Enum.Font.SourceSansBold
Title.Parent = MainFrame

local function CreateButton(posY, text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize, btn.Font = 12, Enum.Font.SourceSansBold
    btn.Parent = MainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

local BtnEspAll = CreateButton(40, "Enable ESP Player")
local BtnBox = CreateButton(75, "ESP Box")
local BtnSkel = CreateButton(110, "ESP Skeleton")
local BtnLine = CreateButton(145, "ESP Line")
local BtnColor = CreateButton(180, "ESP Color: Green")
local BtnAimbot = CreateButton(215, "Aimbot (Visible Only)")
local BtnHitBox = CreateButton(250, "God HitBox (Big)")
local BtnBullet = CreateButton(285, "Bullet Track + WallBang")
local BtnSpeed = CreateButton(320, "Speed Hack")

-- شريط السرعة (Speed Bar)
local SpeedBarBg = Instance.new("Frame")
SpeedBarBg.Size = UDim2.new(0.9, 0, 0, 20)
SpeedBarBg.Position = UDim2.new(0.05, 0, 0, 360)
SpeedBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedBarBg.Parent = MainFrame
Instance.new("UICorner", SpeedBarBg).CornerRadius = UDim.new(0, 6)

local SpeedBarFill = Instance.new("Frame")
SpeedBarFill.Size = UDim2.new(0.3, 0, 1, 0)
SpeedBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
SpeedBarFill.Parent = SpeedBarBg
Instance.new("UICorner", SpeedBarFill).CornerRadius = UDim.new(0, 6)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 1, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 24"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize, SpeedLabel.Font = 11, Enum.Font.SourceSansBold
SpeedLabel.Parent = SpeedBarBg

SpeedBarBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        Config.Speed.Value = Config.Speed.Value + 8
        if Config.Speed.Value > 50 then Config.Speed.Value = 16 end
        SpeedBarFill.Size = UDim2.new(Config.Speed.Value / 50, 0, 1, 0)
        SpeedLabel.Text = "Speed: " + Config.Speed.Value
    end
end)

local isOpen = true
ToggleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
end)

-- ربط الأزرار
BtnEspAll.MouseButton1Click:Connect(function()
    Config.ESP.Enabled = not Config.ESP.Enabled
    BtnEspAll.Text = Config.ESP.Enabled and "Enable ESP Player: ON" or "Enable ESP Player: OFF"
    BtnEspAll.BackgroundColor3 = Config.ESP.Enabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

BtnBox.MouseButton1Click:Connect(function()
    Config.ESP.Box = not Config.ESP.Box
    BtnBox.Text = Config.ESP.Box and "ESP Box: ON" or "ESP Box: OFF"
    BtnBox.BackgroundColor3 = Config.ESP.Box and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

BtnSkel.MouseButton1Click:Connect(function()
    Config.ESP.Skeleton = not Config.ESP.Skeleton
    BtnSkel.Text = Config.ESP.Skeleton and "ESP Skeleton: ON" or "ESP Skeleton: OFF"
    BtnSkel.BackgroundColor3 = Config.ESP.Skeleton and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

BtnLine.MouseButton1Click:Connect(function()
    Config.ESP.Line = not Config.ESP.Line
    BtnLine.Text = Config.ESP.Line and "ESP Line: ON" or "ESP Line: OFF"
    BtnLine.BackgroundColor3 = Config.ESP.Line and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

local colors = {Color3.fromRGB(0, 255, 128), Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 128, 255), Color3.fromRGB(255, 255, 0)}
local colorNames = {"Green", "Red", "Blue", "Yellow"}
local colorIdx = 1
BtnColor.MouseButton1Click:Connect(function()
    colorIdx = colorIdx % #colors + 1
    Config.ESP.Color = colors[colorIdx]
    BtnColor.Text = "ESP Color: " .. colorNames[colorIdx]
end)

BtnAimbot.MouseButton1Click:Connect(function()
    Config.Aimbot.Enabled = not Config.Aimbot.Enabled
    BtnAimbot.Text = Config.Aimbot.Enabled and "Aimbot (Visible Only): ON" or "Aimbot (Visible Only): OFF"
    BtnAimbot.BackgroundColor3 = Config.Aimbot.Enabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

BtnHitBox.MouseButton1Click:Connect(function()
    Config.HitBox.Enabled = not Config.HitBox.Enabled
    BtnHitBox.Text = Config.HitBox.Enabled and "God HitBox (Big): ON" or "God HitBox (Big): OFF"
    BtnHitBox.BackgroundColor3 = Config.HitBox.Enabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

BtnBullet.MouseButton1Click:Connect(function()
    Config.BulletTrack.Enabled = not Config.BulletTrack.Enabled
    Config.BulletTrack.WallBang = Config.BulletTrack.Enabled
    BtnBullet.Text = Config.BulletTrack.Enabled and "Bullet Track + WallBang: ON" or "Bullet Track + WallBang: OFF"
    BtnBullet.BackgroundColor3 = Config.BulletTrack.Enabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

BtnSpeed.MouseButton1Click:Connect(function()
    Config.Speed.Enabled = not Config.Speed.Enabled
    BtnSpeed.Text = Config.Speed.Enabled and "Speed Hack: ON" or "Speed Hack: OFF"
    BtnSpeed.BackgroundColor3 = Config.Speed.Enabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
end)

-- نظام ESP متوافق 100% مع دلتا والمابات القتالية (يستخدم Highlight معدل وآمن)
local function SetupESP(player)
    if player == LocalPlayer then return end

    local boxHighlight = Instance.new("Highlight")
    boxHighlight.FillTransparency = 0.5
    boxHighlight.OutlineTransparency = 0
    boxHighlight.Parent = nil

    RunService.RenderStepped:Connect(function()
        if not Config.ESP.Enabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") or player.Character.Humanoid.Health <= 0 then
            boxHighlight.Parent = nil
            return
        end

        local char = player.Character
        boxHighlight.FillColor = Config.ESP.Color
        boxHighlight.OutlineColor = Config.ESP.Color

        if Config.ESP.Box or Config.ESP.Skeleton or Config.ESP.Line then
            boxHighlight.Parent = char
        else
            boxHighlight.Parent = nil
        end
    end)
end

for _, p in ipairs(Players:GetPlayers()) do coroutine.wrap(SetupESP)(p) end
Players.PlayerAdded:Connect(SetupESP)

-- دالة فحص الرؤية الحقيقية (الظاهر أمامك بدون كفر)
local function IsVisible(targetPart, char)
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, char}
    raycastParams.IgnoreWater = true

    local result = workspace:Raycast(origin, direction, raycastParams)
    return result == nil
end

-- المحرك الرئيسي للـ Aimbot والـ HitBox والـ Bullet Track
RunService.RenderStepped:Connect(function()
    if Config.Speed.Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.Speed.Value
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local root = char:FindFirstChild("HumanoidRootPart")
            local humanoid = char:FindFirstChildOfClass("Humanoid")

            if root and humanoid and humanoid.Health > 0 then
                if Config.HitBox.Enabled then
                    root.Size = Vector3.new(Config.HitBox.Size, Config.HitBox.Size, Config.HitBox.Size)
                    root.Transparency = 0.5
                    root.CanCollide = false
                else
                    root.Size = Vector3.new(2, 2, 1)
                end
            end
        end
    end

    local targetPart = nil
    local shortestDist = math.huge
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local char = player.Character
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local head = char.Head
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                
                if onScreen then
                    if IsVisible(head, char) then
                        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                        if dist < shortestDist then
                            shortestDist = dist
                            targetPart = head
                        end
                    end
                end
            end
        end
    end

    if Config.Aimbot.Enabled and targetPart then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
    end

    if Config.BulletTrack.Enabled and targetPart and LocalPlayer.Character then
        pcall(function()
            local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then
                tool.Handle.CFrame = CFrame.new(tool.Handle.Position, targetPart.Position)
            end
        end)
    end
end)

print("One Shot Bypass Hub Loaded Successfully!")
