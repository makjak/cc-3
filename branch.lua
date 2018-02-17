-- branch mining


-- CONFIG --
local depth = 10

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
   while turtle.digDown() do end
end

function branch_step_forward()
   dig_persistently()
   turtle.forward()
   branch()
   turtle.back()
end

function branch_step_up()
   dig_up_persistently()
   turtle.up()
   branch_after_plane_change()
   turtle.down()
end

function branch_step_down()
   dig_down_persistently()
   turtle.down()
   branch_after_plane_change()
   turtle.up()
end

-- Core --
-- these functions comprise the core
-- of the algorithm. The strategy is
-- simple:
--
--   for every direction:
--     if the block in front is valuable:
--       break the block.
--       move in the direction.
--       call the algorithm. (Recursive step!)
--       move back.

function branch_forward()
   local succ, data = turtle.inspect()
   if is_valuable(data.name) then
      branch_step_forward()
   end
end

function branch_back()
   turtle.turnLeft()
   turtle.turnLeft()
   local succ, data = turtle.inspect()
   if is_valuable(data.name) then
      branch_step_forward()
   end
   turtle.turnRight()
   turtle.turnRight()
end

function branch_left()
   turtle.turnLeft()
   local succ, data = turtle.inspect()
   if is_valuable(data.name) then
      branch_step_forward()
   end
   turtle.turnRight()
end

function branch_right()
   turtle.turnRight()
   local succ, data = turtle.inspect()
   if is_valuable(data.name) then
      branch_step_forward()
   end
   turtle.turnLeft()
end

function branch_up()
   local succ, data = turtle.inspectUp()
   if is_valuable(data.name) then
      branch_step_up()
   end
end

function branch_down()
   local succ, data = turtle.inspectDown()
   if is_valuable(data.name) then
      branch_step_down()
   end
end

-- try to branch in all directions
function branch()
   branch_forward()
   branch_up()
   branch_down()
   branch_left()
   branch_right()
end

-- after moving up or down, it is nexessary
-- to branch backwards as well.
function branch_after_plane_change()
   branch()
   branch_back()
end

-- mine one branch
function mine_branch(length)
   -- dig a branch with the given length,
   -- and, for each step, call the
   -- recursive algorithm
   for i = 1, length do
      dig_persistently()
      turtle.forward()
      -- run the algorithm, minus forward,
      -- because we will move forward next
      -- iteration anyways.
      branch_up()
      branch_down()
      branch_left()
      branch_right()
   end
   -- turn around
   turtle.turnLeft()
   turtle.turnLeft()
   -- dig back (this is in case something
   -- stupid has happened, like someone
   -- placing a block in the way or whatever)
   for i = 1, length do
      dig_persistently()
      turtle.forward()
   end
end

-- dumps the entire inventory in a chest below the robot.
function dump_down()
   for i = 1, 16 do
      turtle.select(i)
      turtle.dropDown()
   end
end


-- the modulo of the branch number
-- determines the height of the branch
local branch_number = 1

-- main loop
while true do
   -- break the loop if there is no chest to dump
   -- our shit in when we are done
   local succ, data = turtle.inspectDown()
   if data.name != "minecraft:chest" then
      break
   end

   if branch_number % 2 == 1 then
      turtle.up()
   end

   mine_branch(depth)
   
   if branch_number % 2 == 1 then
      turtle.down()
   end

   dump_down()

   local succ = true
   turtle.turnLeft()
   succ = turtle.forward()
   succ = turtle.forward()
   turtle.turnLeft()

   -- bvreak the loop if we hit a wall between branches
   if not succ then break end
end
