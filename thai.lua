local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI หลัก
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- พื้นหลังเต็มจอ
local background = Instance.new("Frame")
background.Parent = screenGui
background.Size = UDim2.new(1, 0, 1, 0)
background.Position = UDim2.new(0, 0, 0, 0)
background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
background.BackgroundTransparency = 0.5
background.ZIndex = 0

-- ปุ่มเมนูหลัก (เปลี่ยนจาก TextButton เป็น ImageButton)
local mainButton = Instance.new("ImageButton")
mainButton.Parent = screenGui
mainButton.Size = UDim2.new(0, 60, 0, 60)
mainButton.Position = UDim2.new(0.05, 0, 0.5, -30)
mainButton.BackgroundTransparency = 1 -- ปิดพื้นหลัง
mainButton.Image = "https://chaiyanan-rg.github.io/roblox-roblox/rg-cn.png" -- URL ของภาพ
mainButton.ClipsDescendants = true
mainButton.Visible = true
mainButton.ZIndex = 10

-- เมนูเต็มหน้าจอ
local menuFrame = Instance.new("Frame")
menuFrame.Parent = screenGui
menuFrame.Size = UDim2.new(1, 0, 0.4, 0) -- ครอบจอด้านล่าง
menuFrame.Position = UDim2.new(0, 0, 0.6, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
menuFrame.BackgroundTransparency = 0.3 -- โปร่งใส
menuFrame.BorderSizePixel = 0
menuFrame.Visible = false

local menuCorner = Instance.new("UICorner")
menuCorner.Parent = menuFrame
menuCorner.CornerRadius = UDim.new(0.1, 0)

-- แบ่ง UI เป็น 3 ส่วน
local leftFrame = Instance.new("Frame")
leftFrame.Parent = menuFrame
leftFrame.Size = UDim2.new(0.3, 0, 1, 0)
leftFrame.BackgroundTransparency = 1

local middleFrame = Instance.new("Frame")
middleFrame.Parent = menuFrame
middleFrame.Size = UDim2.new(0.4, 0, 1, 0)
middleFrame.Position = UDim2.new(0.3, 0, 0, 0)
middleFrame.BackgroundTransparency = 1

local rightFrame = Instance.new("Frame")
rightFrame.Parent = menuFrame
rightFrame.Size = UDim2.new(0.3, 0, 1, 0)
rightFrame.Position = UDim2.new(0.7, 0, 0, 0)
rightFrame.BackgroundTransparency = 1

-- ด้านบนแสดงรูปและชื่อผู้เล่น
local headerFrame = Instance.new("Frame")
headerFrame.Parent = menuFrame
headerFrame.Size = UDim2.new(1, 0, 0.2, 0)
headerFrame.Position = UDim2.new(0, 0, 0, 0)
headerFrame.BackgroundTransparency = 1

local avatarImage = Instance.new("ImageLabel")
avatarImage.Parent = headerFrame
avatarImage.Size = UDim2.new(0, 80, 0, 80)
avatarImage.Position = UDim2.new(0.02, 0, 0.1, 0)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

local playerNameLabel = Instance.new("TextLabel")
playerNameLabel.Parent = headerFrame
playerNameLabel.Size = UDim2.new(0.4, 0, 0.8, 0)
playerNameLabel.Position = UDim2.new(0.12, 0, 0.1, 0)
playerNameLabel.Text = "เลือกผู้เล่น"
playerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
playerNameLabel.TextSize = 24
playerNameLabel.BackgroundTransparency = 1

-- ช่องค้นหา (ซ้าย)
local searchBox = Instance.new("TextBox")
searchBox.Parent = leftFrame
searchBox.Size = UDim2.new(0.9, 0, 0, 30)
searchBox.Position = UDim2.new(0.05, 0, 0.05, 0)
searchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
searchBox.Text = "🔍 ค้นหาผู้เล่น..."
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.ClearTextOnFocus = true

local searchCorner = Instance.new("UICorner")
searchCorner.Parent = searchBox
searchCorner.CornerRadius = UDim.new(0.2, 0)

-- รายชื่อผู้เล่น
local playerList = Instance.new("ScrollingFrame")
playerList.Parent = leftFrame
playerList.Size = UDim2.new(0.9, 0, 0.8, 0)
playerList.Position = UDim2.new(0.05, 0, 0.15, 0)
playerList.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)
playerList.ScrollBarThickness = 8

local selectedPlayer = nil
local isViewing = false

-- อัปเดตรายชื่อผู้เล่น
local function updatePlayerList()
    playerList:ClearAllChildren()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and (searchBox.Text == "🔍 ค้นหาผู้เล่น..." or string.find(plr.Name:lower(), searchBox.Text:lower())) then
            local button = Instance.new("TextButton")
            button.Parent = playerList
            button.Size = UDim2.new(1, 0, 0, 25)
            button.Text = plr.Name
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)

            button.MouseButton1Click:Connect(function()
                selectedPlayer = plr
                avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. plr.UserId .. "&width=420&height=420&format=png"
                playerNameLabel.Text = "ผู้เล่น: " .. plr.Name
            end)
        end
    end
end

searchBox.Focused:Connect(updatePlayerList)
searchBox.Changed:Connect(updatePlayerList)

-- ปุ่มกลาง (สำหรับผู้เล่นที่เลือก)
local function createMiddleButton(icon, text, action)
    local button = Instance.new("TextButton")
    button.Parent = middleFrame
    button.Size = UDim2.new(0.8, 0, 0, 35)
    button.Position = UDim2.new(0.1, 0, 0.2, 0)
    button.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
    button.Text = icon .. " " .. text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = button
    btnCorner.CornerRadius = UDim.new(0.2, 0)

    button.MouseButton1Click:Connect(function()
        if selectedPlayer then
            action(selectedPlayer, button)
        end
    end)
end

-- ปุ่มขวา (คำสั่งเกี่ยวกับผู้เล่นคนอื่น)
local function createRightButton(icon, text, action)
    local button = Instance.new("TextButton")
    button.Parent = rightFrame
    button.Size = UDim2.new(0.8, 0, 0, 35)
    button.Position = UDim2.new(0.1, 0, 0.2, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
    button.Text = icon .. " " .. text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = button
    btnCorner.CornerRadius = UDim.new(0.2, 0)

    button.MouseButton1Click:Connect(action)
end

-- ดู/ออกจากมุมมอง
createMiddleButton("👀", "ดูมุมมอง", function(target, button)
    local camera = workspace.CurrentCamera
    if not isViewing then
        if target.Character and target.Character:FindFirstChild("Head") then
            camera.CameraSubject = target.Character.Head
            button.Text = "🔙 ออกจากมุมมอง"
            isViewing = true
        end
    else
        camera.CameraSubject = player.Character.Humanoid
        button.Text = "👀 ดูมุมมอง"
        isViewing = false
    end
end)

-- ปุ่มสำหรับผู้เล่นที่เลือก
createMiddleButton("💀", "ฆ่าผู้เล่น", function(target)
    if target.Character then
        target.Character:BreakJoints()
    end
end)

createMiddleButton("🚀", "ไปหาผู้เล่น", function(target)
    if player.Character and target.Character then
        player.Character:MoveTo(target.Character:GetPrimaryPartCFrame().Position)
    end
end)

-- ปุ่มคำสั่งทั่วไป (ขวา)
createRightButton("🏠", "วาร์ปไปจุดเกิด", function()
    local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
    if player.Character and spawn then
        player.Character:MoveTo(spawn.Position)
    end
end)

-- เปิด/ปิดเมนู
local isMenuOpen = false
mainButton.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    menuFrame.Visible = isMenuOpen
    if not isMenuOpen and isViewing then
        workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
        isViewing = false
    end
end)
