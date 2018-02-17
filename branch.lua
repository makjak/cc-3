-- branch mining

function is_valuable(blockname)
   -- determine whether a block is valuable
   return false
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
