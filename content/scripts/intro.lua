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
  Color('#8d1114'),
  Color('#eb4d1c'),
}

function script.run(i)
  local left = i.consoles[LEFT]
  local right = i.consoles[RIGHT]
  local reader = i.reader
  local scripts = reader.scripts


  left:println('... textual alchemy ...')
  left:endln()
  left:optionln('navigation', function() reader:load(scripts.nav) end)

  -- instructions 
  right:println('[f] -------- fullscreen')
  right:println('[tab] ------ x4')
  right:println('[shift+tab] - x8')
  right:println('[control+r] --- restart')
end

return script
