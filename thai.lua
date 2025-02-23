local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ปุ่มเปิด/ปิด UI
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0.01, 0, 0.9, 0)
toggleButton.Text = "📋 เปิดเมนู"
toggleButton.TextSize = 16
toggleButton.Font = Enum.Font.GothamBold
toggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local toggleCorner = Instance.new("UICorner")
toggleCorner.Parent = toggleButton
toggleCorner.CornerRadius = UDim.new(0.2, 0)

-- หน้าหลัก (ล็อคกลางจอ)
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 700, 0, 500)
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false

local frameCorner = Instance.new("UICorner")
frameCorner.Parent = mainFrame
frameCorner.CornerRadius = UDim.new(0.05, 0)

-- หัวข้อ UI
local header = Instance.new("TextLabel")
header.Parent = mainFrame
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
header.Text = "🎮 เมนูควบคุมผู้เล่น"
header.TextColor3 = Color3.fromRGB(255, 255, 255)
header.TextSize = 20
header.Font = Enum.Font.GothamBold

local headerCorner = Instance.new("UICorner")
headerCorner.Parent = header
headerCorner.CornerRadius = UDim.new(0.1, 0)

-- ช่องค้นหา
local searchBox = Instance.new("TextBox")
searchBox.Parent = mainFrame
searchBox.Size = UDim2.new(0.9, 0, 0, 40)
searchBox.Position = UDim2.new(0.05, 0, 0.12, 0)
searchBox.PlaceholderText = "🔍 ค้นหาผู้เล่น..."
searchBox.Text = ""
searchBox.TextSize = 16
searchBox.Font = Enum.Font.Gotham
searchBox.BackgroundColor3 = Color3.fromRGB(230, 230, 250)
searchBox.TextColor3 = Color3.fromRGB(100, 0, 150)

local searchCorner = Instance.new("UICorner")
searchCorner.Parent = searchBox
searchCorner.CornerRadius = UDim.new(0.1, 0)

-- รายการผู้เล่น (Scroll)
local playerList = Instance.new("ScrollingFrame")
playerList.Parent = mainFrame
playerList.Size = UDim2.new(0.9, 0, 0.7, 0)
playerList.Position = UDim2.new(0.05, 0, 0.2, 0)
playerList.BackgroundColor3 = Color3.fromRGB(230, 230, 250)
playerList.BorderSizePixel = 0
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)
playerList.ScrollBarThickness = 5
playerList.AutomaticCanvasSize = Enum.AutomaticSize.Y

local listCorner = Instance.new("UICorner")
listCorner.Parent = playerList
listCorner.CornerRadius = UDim.new(0.1, 0)

local selectedPlayer = nil

-- อัปเดตรายชื่อผู้เล่น
local function updatePlayerList(searchTerm)
    playerList:ClearAllChildren()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if searchTerm == "" or string.find(string.lower(plr.Name), string.lower(searchTerm)) then
            local playerFrame = Instance.new("Frame")
            playerFrame.Parent = playerList
            playerFrame.Size = UDim2.new(1, 0, 0, 100)
            playerFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            playerFrame.BackgroundTransparency = 0.2

            local frameCorner = Instance.new("UICorner")
            frameCorner.Parent = playerFrame
            frameCorner.CornerRadius = UDim.new(0.2, 0)

            -- รูปโปรไฟล์
            local avatar = Instance.new("ImageLabel")
            avatar.Parent = playerFrame
            avatar.Size = UDim2.new(0, 60, 0, 60)
            avatar.Position = UDim2.new(0.02, 0, 0.1, 0)
            avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..plr.UserId.."&width=100&height=100&format=png"
            avatar.BackgroundTransparency = 1

            -- ชื่อผู้เล่น
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Parent = playerFrame
            nameLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
            nameLabel.Position = UDim2.new(0.2, 0, 0.1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = plr.Name
            nameLabel.TextSize = 18
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextColor3 = Color3.fromRGB(100, 0, 150)

            -- ปุ่มแอ็กชัน
            local actionButtons = {
                {Text = "🚶‍♂️ ไปหา", Action = function() player.Character:MoveTo(plr.Character:GetPrimaryPartCFrame().Position) end},
                {Text = "🤲 ดึง", Action = function() plr.Character:SetPrimaryPartCFrame(player.Character:GetPrimaryPartCFrame()) end},
                {Text = "💀 ฆ่า", Action = function() plr.Character:BreakJoints() end}
            }

            local followButton = Instance.new("TextButton")
            followButton.Parent = playerFrame
            followButton.Size = UDim2.new(0, 80, 0, 30)
            followButton.Position = UDim2.new(0.8, 0, 0.1, 0)
            followButton.Text = "👁️‍🗨️ ติดตาม"
            followButton.TextSize = 14
            followButton.Font = Enum.Font.Gotham
            followButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
            followButton.TextColor3 = Color3.fromRGB(255, 255, 255)

            local followCorner = Instance.new("UICorner")
            followCorner.Parent = followButton
            followCorner.CornerRadius = UDim.new(0.2, 0)

            local isFollowing = false

            followButton.MouseButton1Click:Connect(function()
                if not isFollowing then
                    game.Workspace.CurrentCamera.CameraSubject = plr.Character
                    followButton.Text = "↩️ กลับมุมมอง"
                    isFollowing = true
                else
                    game.Workspace.CurrentCamera.CameraSubject = player.Character
                    followButton.Text = "👁️‍🗨️ ติดตาม"
                    isFollowing = false
                end
            end)

            for i, btnData in ipairs(actionButtons) do
                local actionButton = Instance.new("TextButton")
                actionButton.Parent = playerFrame
                actionButton.Size = UDim2.new(0, 80, 0, 30)
                actionButton.Position = UDim2.new(0.2 + (i - 1) * 0.2, 0, 0.6, 0)
                actionButton.Text = btnData.Text
                actionButton.TextSize = 14
                actionButton.Font = Enum.Font.Gotham
                actionButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
                actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)

                local actionCorner = Instance.new("UICorner")
                actionCorner.Parent = actionButton
                actionCorner.CornerRadius = UDim.new(0.2, 0)

                actionButton.MouseButton1Click:Connect(btnData.Action)
            end
        end
    end
end

-- เปิด/ปิด UI
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    toggleButton.Text = mainFrame.Visible and "❌ ปิดเมนู" or "📋 เปิดเมนู"
end)

-- ค้นหาผู้เล่น
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updatePlayerList(searchBox.Text)
end)

updatePlayerList("")

