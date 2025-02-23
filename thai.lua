local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- สร้าง ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- ปุ่มเปิด/ปิด Dashboard (ใช้รูปภาพ)
local toggleButton = Instance.new("ImageButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(0.05, 0, 0.5, -30)
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "https://chaiyanan-rg.github.io/roblox-roblox/rg-cn.png"

-- สร้าง Dashboard
local dashboard = Instance.new("Frame")
dashboard.Parent = screenGui
dashboard.Size = UDim2.new(0, 350, 0, 500)
dashboard.Position = UDim2.new(0.65, 0, 0.2, 0)
dashboard.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
dashboard.BorderSizePixel = 2
dashboard.BorderColor3 = Color3.fromRGB(255, 255, 255)
dashboard.Visible = false

local dashboardCorner = Instance.new("UICorner")
dashboardCorner.Parent = dashboard
dashboardCorner.CornerRadius = UDim.new(0.1, 0)

-- หัวข้อ Dashboard
local title = Instance.new("TextLabel")
title.Parent = dashboard
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(80, 0, 130)
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
searchBox.Size = UDim2.new(0.8, 0, 0, 30)
searchBox.Position = UDim2.new(0.1, 0, 0.12, 0)
searchBox.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
searchBox.Text = "🔍 ค้นหาผู้เล่น..."
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.ClearTextOnFocus = true

local searchCorner = Instance.new("UICorner")
searchCorner.Parent = searchBox
searchCorner.CornerRadius = UDim.new(0.2, 0)

-- รายการผู้เล่น
local playerList = Instance.new("ScrollingFrame")
playerList.Parent = dashboard
playerList.Size = UDim2.new(1, 0, 0.7, -50)
playerList.Position = UDim2.new(0, 0, 0.18, 0)
playerList.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)

-- ฟังก์ชันอัปเดตรายการผู้เล่น
local function updateDashboard()
    playerList:ClearAllChildren()
    
    for _, plr in pairs(game.Players:GetPlayers()) do
        if searchBox.Text == "🔍 ค้นหาผู้เล่น..." or plr.Name:lower():find(searchBox.Text:lower()) then
            local row = Instance.new("Frame")
            row.Parent = playerList
            row.Size = UDim2.new(1, 0, 0, 40)
            row.BackgroundColor3 = Color3.fromRGB(150, 0, 200)
            
            local rowCorner = Instance.new("UICorner")
            rowCorner.Parent = row
            rowCorner.CornerRadius = UDim.new(0.2, 0)

            -- ชื่อผู้เล่น
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Parent = row
            nameLabel.Size = UDim2.new(0.4, 0, 1, 0)
            nameLabel.Text = "👤 " .. plr.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.Font = Enum.Font.Gotham

            -- ปุ่มวาร์ปไปหาผู้เล่น
            local tpButton = Instance.new("TextButton")
            tpButton.Parent = row
            tpButton.Size = UDim2.new(0.2, 0, 1, 0)
            tpButton.Position = UDim2.new(0.35, 0, 0, 0)
            tpButton.Text = "🚀 วาร์ป"
            tpButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
            tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)

            -- ปุ่มดึงผู้เล่นมาหา
            local bringButton = Instance.new("TextButton")
            bringButton.Parent = row
            bringButton.Size = UDim2.new(0.2, 0, 1, 0)
            bringButton.Position = UDim2.new(0.55, 0, 0, 0)
            bringButton.Text = "🌀 ดึงมา"
            bringButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
            bringButton.TextColor3 = Color3.fromRGB(255, 255, 255)

            -- ปุ่มเปลี่ยนมุมมอง
            local spectateButton = Instance.new("TextButton")
            spectateButton.Parent = row
            spectateButton.Size = UDim2.new(0.2, 0, 1, 0)
            spectateButton.Position = UDim2.new(0.75, 0, 0, 0)
            spectateButton.Text = "👀 ดู"
            spectateButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            spectateButton.TextColor3 = Color3.fromRGB(255, 255, 255)

            -- ปุ่มเตะออกจากแมพ
            local kickButton = Instance.new("TextButton")
            kickButton.Parent = row
            kickButton.Size = UDim2.new(0.2, 0, 1, 0)
            kickButton.Position = UDim2.new(0.95, 0, 0, 0)
            kickButton.Text = "🚫 เตะ"
            kickButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            kickButton.TextColor3 = Color3.fromRGB(255, 255, 255)

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

            -- ฟังก์ชันเปลี่ยนมุมมองไปที่ผู้เล่น
            spectateButton.MouseButton1Click:Connect(function()
                game.Workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid
            end)

            -- ฟังก์ชันเตะออกจากแมพ
            kickButton.MouseButton1Click:Connect(function()
                plr:Kick("คุณถูกแอดมินเตะออกจากเกม!")
            end)
        end
    end
end

game.Players.PlayerAdded:Connect(updateDashboard)
game.Players.PlayerRemoving:Connect(updateDashboard)
searchBox:GetPropertyChangedSignal("Text"):Connect(updateDashboard)
toggleButton.MouseButton1Click:Connect(function()
    dashboard.Visible = not dashboard.Visible
    updateDashboard()
end)
