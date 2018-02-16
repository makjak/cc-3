
-- main loop
while true do
   break
end


-- refuel routine
function try_refuel()
   if turtle.getFuelLevel() < 512 then
      turtle.select(16)
      turtle.suckUp(8)
      turtle.refuel()
      turtle.select(1)
   end
end

-- move from center to forward/right corner
function move_to_corner()
   for i = 1, 4 do
      turtle.forward()
   end
   turtle.turnRight()
   for i = 1, 4 do
      turtle.forward()
   end
   
end
