-- Primitive Farming Turtle.
-- Farms a standard 9x9 crop farm with water
-- in the center. It is only suited for early-
-- game play, because it is quite crude.
--   For one, potatoes are hard-coded, so it
-- is necessary to edit the code to harvest
-- other crops. I won't make this version
-- good, because lategame i want something more
-- sophisticated anyways.

-- Refuel routine.
-- Attempts to grab 8 fuel from a chest above it.
-- Slot 16 should be free, since this function is
-- only called at the bginning of a route, after
-- the turtle has, hypothetically, dropped its crops
-- in a chest.
function try_refuel()
   if turtle.getFuelLevel() < 512 then
      turtle.select(16)
      turtle.suckUp(8)
      turtle.refuel()
      turtle.select(1)
   end
end

-- unload the harvested crops
function unload_crops()
   -- for all but the first inventory slot
   for i = 2, 16 do
      turtle.select(i)
      turtle.drop()
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

-- farm an entire strip.
-- the argument is the strip number, ( the first
-- strip harvested is 1, the next is 2 etc...).
--   The strip number is used to determine whether
-- the turtle should turn left or right after a
-- strip.
function farm_strip(strip_number)
   -- PRECONDITION: Hovering directly above the
   -- fist tile of the strip, FACING FORWARD, i.e.
   -- the direction the turtle needs to move to
   -- harvest the strip.

   farm_tile()
   for i = 1, 8 do
      turtle.forward()
      farm_tile()
   end

   -- determine direction to turn
   if strip_number == 9 then -- last strip, we don't want to move over
      unload_crops()
      return
   end
   
   if strip_number % 2 == 1 then
      turtle.turnRight()
      turtle.forward()
      turtle.turnRight()
   else
      turtle.turnLeft()
      turtle.forward()
      turtle.turnLeft()
   end
end

-- main loop
while true do
   do break end

   -- refuel and move to corner.
   try_refuel()
   move_to_corner()
   turtle.turnRight()

   -- wait 10 minutes between harvests.
   os.sleep(600)
end
