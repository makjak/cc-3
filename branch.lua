-- branch mining


-- CONFIG --
local depth = 16

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


-- dig functions that deals with gravel dy
-- repeatedly calling turtle.dig() and friends
-- until it returns false.

function dig_persistently()
   while turtle.dig() do end
end

function dig_up_persistently()
   while turtle.digUp() do end
end

function dig_down_persistently()
   while turtle.dig() do end
end

-- move one step forward, to the
-- next "node" in the "ore tree"
function branch_step()
   dig_persistently()
   turtle.forward()
   -- attemt to branch forward, left and right
   -- TODO: branch up and down as well
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


-- mine one branch
function mine_branch(length)
   for i = 1, length do
      dig_persistently()
      turtle.forward()
      branch_left()
      branch_right()
   end
end
