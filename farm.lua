

-- refuel routine
function try_refuel()
   if turtle.getFuelLevel() < 512 then
      turtle.select(16)
      turtle.suckUp(8)
      turtle.refuel()
      turtle.select(1)
   end
end
