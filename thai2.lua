local player = game.Players.LocalPlayer
local ui = script.Parent -- ต้องแน่ใจว่า UI อยู่ใน ScreenGui
local itemListFrame = ui:FindFirstChild("ScrollingFrame") -- กรอบรายการไอเท็ม
local itemButtonTemplate = itemListFrame:FindFirstChild("ItemButton") -- ปุ่มต้นแบบ

-- ฟังก์ชันค้นหาไอเท็มทั้งหมดในแมพ
local function getAllItems()
    local items = {}
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Tool") or obj:IsA("Model") and obj:FindFirstChild("Handle") then
            table.insert(items, obj)
        end
    end
    return items
end

-- ฟังก์ชันอัปเดตรายการไอเท็มใน UI
local function updateItemList()
    -- ล้าง UI เก่า
    for _, child in pairs(itemListFrame:GetChildren()) do
        if child:IsA("TextButton") and child ~= itemButtonTemplate then
            child:Destroy()
        end
    end

    local items = getAllItems()
    
    for _, item in pairs(items) do
        local newItemButton = itemButtonTemplate:Clone()
        newItemButton.Parent = itemListFrame
        newItemButton.Text = item.Name
        newItemButton.Visible = true

        -- เมื่อกดปุ่ม จะให้ไอเท็มนั้นกับผู้เล่น
        newItemButton.MouseButton1Click:Connect(function()
            local char = player.Character
            if char then
                local backpack = player:FindFirstChild("Backpack")
                if item:IsA("Tool") then
                    item.Parent = backpack
                elseif item:IsA("Model") and item:FindFirstChild("Handle") then
                    local clone = item:Clone()
                    clone.Parent = char
                end
            end
        end)
    end
end

-- เรียกใช้ตอนเปิด UI
updateItemList()
