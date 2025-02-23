local player = game.Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(100, 0, 150)

local inputBox = Instance.new("TextBox")
inputBox.Parent = mainFrame
inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
inputBox.Size = UDim2.new(0.8, 0, 0.3, 0)
inputBox.Position = UDim2.new(0.1, 0, 0.2, 0)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Text = "Enter Amount"
inputBox.TextSize = 18

local addButton = Instance.new("TextButton")
addButton.Parent = mainFrame
addButton.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
addButton.Size = UDim2.new(0.8, 0, 0.3, 0)
addButton.Position = UDim2.new(0.1, 0, 0.6, 0)
addButton.TextColor3 = Color3.fromRGB(255, 255, 255)
addButton.Text = "Add Cash"
addButton.TextSize = 20

addButton.MouseButton1Click:Connect(function()
    local amount = tonumber(inputBox.Text)
    if amount and amount > 0 then
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            local cash = leaderstats:FindFirstChild("Cash")
            if cash then
                cash.Value = cash.Value + amount
            end
        end
    end
end)
