-- branch mining

function is_valuable(blockname)
   if blockname == "minecraft:iron_ore" or
      blockname == "minecraft:coal_ore" or
      blockname == "minecraft:gold_ore" or
      blockname == "minecraft:redstone_ore" or
      blockname == "minecraft:diamond_ore"
   then
      return true
   else 
      return false
   end
end

function branch_step()
   turtle.dig()
   turtle.forward()
   branch_forward()
   branch_left()
   branch_right()
   turtle.back()
end

function branch_forward()
   local succ, data = turtle.inspect()
   if is_valuable(data.name) then
      branch_step()
   end
end

function branch_left()
   turtle.turnLeft()
   local succ, data = turtle.inspect()
   if is_valuable(data.name) then
      branch_step()
   end
   turtle.turnRight()
end

function branch_right()
   turtle.turnRight()
   local succ, data = turtle.inspect()
   if is_valuable(data.name) then
      branch_step()
   end
   turtle.turnLeft()
end

-- main loop
while true do
   turtle.dig()
   turtle.forward()
   branch_left()
   branch_right()
end
