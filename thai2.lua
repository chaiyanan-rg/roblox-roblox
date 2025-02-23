-- สร้างหน้าต่างเมนู
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- สร้างปุ่มขีด 3 ขีด
local hamburgerMenu = Instance.new("TextButton")
hamburgerMenu.Size = UDim2.new(0, 40, 0, 40)
hamburgerMenu.Position = UDim2.new(1, -50, 0, 10)
hamburgerMenu.Text = "≡"
hamburgerMenu.TextSize = 30
hamburgerMenu.BackgroundTransparency = 1
hamburgerMenu.TextColor3 = Color3.fromRGB(255, 255, 255)
hamburgerMenu.Parent = screenGui

-- สร้างหน้า UI
local menuPage1 = Instance.new("Frame")
menuPage1.Size = UDim2.new(0.5, 0, 0.8, 0)
menuPage1.Position = UDim2.new(0.25, 0, 0.1, 0)
menuPage1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
menuPage1.Visible = true
menuPage1.Parent = screenGui

local menuPage2 = Instance.new("Frame") -- หน้า 2: จัดการตัวเอง
menuPage2.Size = UDim2.new(0.5, 0, 0.8, 0)
menuPage2.Position = UDim2.new(0.25, 0, 0.1, 0)
menuPage2.BackgroundColor3 = Color3.fromRGB(240, 240, 255)
menuPage2.Visible = false
menuPage2.Parent = screenGui

local menuPage3 = Instance.new("Frame") -- หน้า 3: Command
menuPage3.Size = UDim2.new(0.5, 0, 0.8, 0)
menuPage3.Position = UDim2.new(0.25, 0, 0.1, 0)
menuPage3.BackgroundColor3 = Color3.fromRGB(240, 240, 255)
menuPage3.Visible = false
menuPage3.Parent = screenGui

-- ฟังก์ชันเปิดปิดหน้า
local currentPage = menuPage1
local function switchPage(page)
    currentPage.Visible = false
    page.Visible = true
    currentPage = page
end

hamburgerMenu.MouseButton1Click:Connect(function()
    if currentPage == menuPage1 then
        switchPage(menuPage2) -- ไปที่หน้า 2: จัดการตัวเอง
    elseif currentPage == menuPage2 then
        switchPage(menuPage3) -- ไปที่หน้า 3: Command
    elseif currentPage == menuPage3 then
        switchPage(menuPage1) -- ไปที่หน้า 1: จัดการผู้เล่น
    end
end)

-- เพิ่มฟังก์ชันจัดการตัวเอง (เปิดปิดยศ, ล่องหน, บิน, ทะลุ)
local toggleInvisibleButton = Instance.new("TextButton")
toggleInvisibleButton.Size = UDim2.new(0, 150, 0, 40)
toggleInvisibleButton.Position = UDim2.new(0.05, 0, 0.1, 0)
toggleInvisibleButton.Text = "ล่องหน"
toggleInvisibleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
toggleInvisibleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleInvisibleButton.Parent = menuPage2

toggleInvisibleButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character then
        character:FindFirstChild("Humanoid").HipWidth = 0
    end
end)

-- ฟังก์ชันเปิดปิดยศ
local toggleRankButton = Instance.new("TextButton")
toggleRankButton.Size = UDim2.new(0, 150, 0, 40)
toggleRankButton.Position = UDim2.new(0.05, 0, 0.2, 0)
toggleRankButton.Text = "เปิด/ปิดยศ"
toggleRankButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
toggleRankButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleRankButton.Parent = menuPage2

toggleRankButton.MouseButton1Click:Connect(function()
    -- เพิ่มฟังก์ชันเปิด/ปิดยศ
    local player = game.Players.LocalPlayer
    -- ตรงนี้สามารถใช้ระบบยศในแมพนั้น ๆ เช่น กำหนดให้ผู้เล่นมียศหรือไม่มียศ
end)

-- ฟังก์ชันบิน
local toggleFlyButton = Instance.new("TextButton")
toggleFlyButton.Size = UDim2.new(0, 150, 0, 40)
toggleFlyButton.Position = UDim2.new(0.05, 0, 0.3, 0)
toggleFlyButton.Text = "บิน"
toggleFlyButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
toggleFlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleFlyButton.Parent = menuPage2

toggleFlyButton.MouseButton1Click:Connect(function()
    -- ฟังก์ชันบิน
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character then
        -- ให้ผู้เล่นสามารถบินได้
    end
end)

-- ฟังก์ชันทะลุ
local toggleNoClipButton = Instance.new("TextButton")
toggleNoClipButton.Size = UDim2.new(0, 150, 0, 40)
toggleNoClipButton.Position = UDim2.new(0.05, 0, 0.4, 0)
toggleNoClipButton.Text = "ทะลุ"
toggleNoClipButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
toggleNoClipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleNoClipButton.Parent = menuPage2

toggleNoClipButton.MouseButton1Click:Connect(function()
    -- ฟังก์ชันทะลุ
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character then
        -- ทำให้ผู้เล่นทะลุได้
    end
end)

-- เพิ่มฟังก์ชัน Command
local commandBox = Instance.new("TextBox")
commandBox.Size = UDim2.new(0.9, 0, 0, 40)
commandBox.Position = UDim2.new(0.05, 0, 0.1, 0)
commandBox.PlaceholderText = ":to ชื่อผู้เล่น"
commandBox.TextSize = 16
commandBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
commandBox.TextColor3 = Color3.fromRGB(0, 0, 0)
commandBox.Parent = menuPage3

commandBox.FocusLost:Connect(function()
    local commandText = commandBox.Text
    if commandText == ":to" then
        -- ทำงานกับคำสั่ง :to
    elseif commandText == "command มอบยศ" then
        -- ทำงานกับคำสั่ง มอบยศ
    end
end)

-- เพิ่มฟังก์ชันดึงคำสั่งและยศจากแผนที่
local function getCommandsAndRanks()
    -- ดึงคำสั่งและยศทั้งหมดจากแผนที่ (สามารถดึงจากข้อมูลในเกมได้)
    -- สมมุติว่าคำสั่งและยศถูกเก็บใน RemoteEvent
end
