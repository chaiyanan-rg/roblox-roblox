local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = game.Workspace.CurrentCamera

-- สร้าง ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- ปุ่มหลัก (ใช้ข้อความแทนรูปภาพ)
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(0.05, 0, 0.5, -30)
toggleButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- สีม่วง
toggleButton.Text = "⚙️"
toggleButton.TextSize = 24
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Visible = true -- ปุ่มแสดง

-- สร้าง Dashboard (แนวนอน)
local dashboard = Instance.new("Frame")
dashboard.Parent = screenGui
dashboard.Size = UDim2.new(0, 600, 0, 100) -- ขนาดแดชบอร์ดเป็นแนวนอน
dashboard.Position = UDim2.new(0.5, -300, 0.5, -50) -- อยู่กลางหน้าจอ
dashboard.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- พื้นหลังสีขาว
dashboard.BackgroundTransparency = 0.5 -- ความโปร่งใสของพื้นหลัง
dashboard.BorderSizePixel = 2
dashboard.BorderColor3 = Color3.fromRGB(128, 0, 128) -- สีม่วง
dashboard.Visible = false -- เริ่มต้นซ่อนแดชบอร์ด

local dashboardCorner = Instance.new("UICorner")
dashboardCorner.Parent = dashboard
dashboardCorner.CornerRadius = UDim.new(0.1, 0)

-- หัวข้อ Dashboard
local title = Instance.new("TextLabel")
title.Parent = dashboard
title.Size = UDim2.new(0.3, 0, 1, 0) -- ขนาดหัวข้อ
title.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- สีม่วง
title.Text = "⚙️ แผงควบคุมแอดมิน"
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold

local titleCorner = Instance.new("UICorner")
titleCorner.Parent = title
titleCorner.CornerRadius = UDim.new(0.1, 0)

-- ช่องค้นหาผู้เล่น
local searchBox = Instance.new("TextBox")
searchBox.Parent = dashboard
searchBox.Size = UDim2.new(0.2, 0, 1, 0)
searchBox.Position = UDim2.new(0.3, 0, 0, 0)
searchBox.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- สีม่วง
searchBox.Text = "🔍 ค้นหาผู้เล่น..."
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.ClearTextOnFocus = true

local searchCorner = Instance.new("UICorner")
searchCorner.Parent = searchBox
searchCorner.CornerRadius = UDim.new(0.2, 0)

-- รายการผู้เล่น
local playerList = Instance.new("ScrollingFrame")
playerList.Parent = dashboard
playerList.Size = UDim2.new(0.5, 0, 1, 0)
playerList.Position = UDim2.new(0.5, 0, 0, 0)
playerList.BackgroundColor3 = Color3.fromRGB(230, 230, 230) -- สีรอง
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)

-- ฟังก์ชันดึงรูปโปรไฟล์ผู้เล่น
local function getProfileImage(player)
    local avatarImage = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
    return avatarImage
end

-- ฟังก์ชันอัปเดตรายการผู้เล่น
local function updateDashboard()
    playerList:ClearAllChildren()
    
    for _, plr in pairs(game.Players:GetPlayers()) do
        if searchBox.Text == "🔍 ค้นหาผู้เล่น..." or plr.Name:lower():find(searchBox.Text:lower()) then
            local row = Instance.new("Frame")
            row.Parent = playerList
            row.Size = UDim2.new(1, 0, 0, 60)
            row.BackgroundColor3 = Color3.fromRGB(200, 200, 255) -- สีรอง

            local rowCorner = Instance.new("UICorner")
            rowCorner.Parent = row
            rowCorner.CornerRadius = UDim.new(0.2, 0)

            -- รูปโปรไฟล์ผู้เล่น
            local profileImage = Instance.new("ImageLabel")
            profileImage.Parent = row
            profileImage.Size = UDim2.new(0, 50, 0, 50)
            profileImage.Position = UDim2.new(0, 10, 0, 5)
            profileImage.Image = getProfileImage(plr)  -- ดึงรูปโปรไฟล์จาก URL
            profileImage.BackgroundTransparency = 1
            profileImage.BorderSizePixel = 0

            -- ชื่อผู้เล่น
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Parent = row
            nameLabel.Size = UDim2.new(0.4, 0, 1, 0)
            nameLabel.Position = UDim2.new(0.2, 0, 0, 0)
            nameLabel.Text = "👤 " .. plr.Name
            nameLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
            nameLabel.Font = Enum.Font.Gotham

            -- ปุ่มวาร์ปไปหาผู้เล่น
            local tpButton = Instance.new("TextButton")
            tpButton.Parent = row
            tpButton.Size = UDim2.new(0.2, 0, 1, 0)
            tpButton.Position = UDim2.new(0.55, 0, 0, 0)
            tpButton.Text = "🚀 วาร์ป"
            tpButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
            tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)

            -- ปุ่มดึงผู้เล่นมาหา
            local bringButton = Instance.new("TextButton")
            bringButton.Parent = row
            bringButton.Size = UDim2.new(0.2, 0, 1, 0)
            bringButton.Position = UDim2.new(0.75, 0, 0, 0)
            bringButton.Text = "🌀 ดึงมา"
            bringButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
            bringButton.TextColor3 = Color3.fromRGB(255, 255, 255)

            -- ฟังก์ชันวาร์ปไปหาผู้เล่น
            tpButton.MouseButton1Click:Connect(function()
                if player.Character and plr.Character then
                    player.Character:SetPrimaryPartCFrame(plr.Character:GetPrimaryPartCFrame())
                end
            end)

            -- ฟังก์ชันดึงผู้เล่นมาหา
            bringButton.MouseButton1Click:Connect(function()
                if plr.Character and player.Character then
                    plr.Character:SetPrimaryPartCFrame(player.Character:GetPrimaryPartCFrame())
                end
            end)

            -- ปุ่มดูมุมมองผู้เล่น
            local viewButton = Instance.new("TextButton")
            viewButton.Parent = row
            viewButton.Size = UDim2.new(0.2, 0, 1, 0)
            viewButton.Position = UDim2.new(0.95, 0, 0, 0)
            viewButton.Text = "👁️ ดูมุมมอง"
            viewButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
            viewButton.TextColor3 = Color3.fromRGB(255, 255, 255)

            -- ฟังก์ชันดูมุมมองผู้เล่น
            viewButton.MouseButton1Click:Connect(function()
                if plr.Character then
                    camera.CameraSubject = plr.Character
                    camera.CameraType = Enum.CameraType.Attach
                end
            end)
        end
    end
end

game.Players.PlayerAdded:Connect(updateDashboard)
game.Players.PlayerRemoving:Connect(updateDashboard)
searchBox:GetPropertyChangedSignal("Text"):Connect(updateDashboard)

-- ฟังก์ชันกลับไปมุมมองของตัวเอง
local backToSelfButton = Instance.new("TextButton")
backToSelfButton.Parent = dashboard
backToSelfButton.Size = UDim2.new(0.2, 0, 1, 0)
backToSelfButton.Position = UDim2.new(1, -100, 0, 0)
backToSelfButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- สีม่วง
backToSelfButton.Text = "🔄 กลับไปมุมมองตัวเอง"
backToSelfButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local backCorner = Instance.new("UICorner")
backCorner.Parent = backToSelfButton
backCorner.CornerRadius = UDim.new(0.2, 0)

backToSelfButton.MouseButton1Click:Connect(function()
    camera.CameraSubject = player.Character
    camera.CameraType = Enum.CameraType.Custom
end)

-- เปิดปิดแดชบอร์ด
toggleButton.MouseButton1Click:Connect(function()
    dashboard.Visible = not dashboard.Visible
end)
