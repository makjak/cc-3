
-- refuel routine.
function try_refuel()
   if turtle.getFuelLevel() < 512 then
      turtle.select(16)
      turtle.suckUp(8)
      turtle.refuel()
      turtle.select(1)
   end
end

-- move from center to forward/right corner.
function move_to_corner()
   for i = 1, 4 do
      turtle.forward()
   end
   turtle.turnRight()
   for i = 1, 4 do
      turtle.forward()
   end
end

-- farm one tile.
function farm_tile()
   -- figure out what is under me.
   local success, data = turtle.inspectDown()
   if success and data.name == "minecraft:potatoes" then
      -- if the block underneath me is potatoes:
      if data.state.age == 7 then
	 turtle.digDown()
	 turtle.placeDown()
      end
   end
end

function farm_strip()
   return
end

-- main loop
while true do
   -- wait 10 minutes between harvests.
   os.sleep(600)

   -- refuel and move to corner.
   try_refuel()
   move_to_corner()
   turtle.turnRight()


end
