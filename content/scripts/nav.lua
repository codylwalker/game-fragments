import 'util'

local script = {}

script.colors =
{
  bg = Color('#161412'),
  button = {
    up = Color('#722ebb'),
    over = Color('#a147ff'),
    down = Color('#53d554'),
  },

  Color('#dfd9d5'),
  Color('#6da9c3'),
  Color('#eb4d1c'),
}
local consoles = false
local left = false
local right = false
local reader = false
local scripts = false
local num_rows = false
local num_columns = false 
local dir = Vec2(1, 0)
local pos = Vec2(0, 0)

local function change_direction (x, y)
  dir.x = x
  dir.y = y
end

function script.run(obj)
  consoles = obj.consoles
  left = obj.consoles[LEFT]
  right = obj.consoles[RIGHT]
  reader = obj.reader
  scripts = reader.scripts
  num_rows = consoles[LEFT].num_rows
  num_columns = consoles[LEFT].num_columns
  left:clear()
  right:clear()

  local l_align = "                "
  left:print(l_align) 
  left:option('\\', function() change_direction(-1, -1) end)
  left:print('  ') 
  left:option('^', function() change_direction(0, -1) end)
  left:print('  ') 
  left:option('/', function() change_direction(1, -1) end) 
  left:endln() 
  left:endln() 
  left:print(l_align) 
  left:option('<', function() change_direction(-1, 0) end) 
  left:print('  ')
  left:option('0', function() change_direction(0, 0) end) 
  left:print('  ') 
  left:option('>', function() change_direction(1, 0) end) 
  left:endln()
  left:endln() 
  left:print(l_align)
  left:option('/', function() change_direction(-1, 1) end) 
  left:print('  ') 
  left:option('v', function() change_direction(0, 1) end) 
  left:print('  ') 
  left:option('\\', function() change_direction(1, 1) end) 
  left:endln()
  left:endln() 
  left:print(l_align) 


  -- bottom back button
  for i=1, 17 do left:endln() end
  left:optionln('back', function() reader:load(scripts.intro) end) 

  script.weave()

end

function script.weave() 
  while true do 
    local x, y = pos.x, pos.y
    if not (dir.x == 0 and dir.y == 0) then
      right:print_at('#',Vec2(x,y), 2) 
    end 

    reader:wait(0.2) 

    pos.x = pos.x+dir.x 
    pos.y = pos.y+dir.y

    -- check boundaries, wrap
    if pos.x < 1 then pos.x = num_columns-1 end
    if pos.x > num_columns-1 then pos.x = 1 end 

    if pos.y < 0 then pos.y = num_rows-1 end
    if pos.y > num_rows-1 then pos.y = 0 end 
  end


end

return script
