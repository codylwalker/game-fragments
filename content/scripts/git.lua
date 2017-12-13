import 'util'
import 'game'

local script = {}

script.colors =
{
  bg = Color('#e2dccd'),
  button = {
    up = Color('#2aa1ae'),
    over = Color('#100a14'),
    down = Color('#6c4173'),
  },

  Color('#000000'),
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

local commits = {}
table.insert(commits, {name = "a345750", message = "initial commit.. ~~HOPE THIS GOES WELL~~"})
table.insert(commits, {name = "8eb60ca", message = "Going to try a branch here"}) 
table.insert(commits, {name = "e0865f8", message = "first pass on clickable buttons"}) 
table.insert(commits, {name = "2878cb0", message = "ERROR: HASH COLLISION"})
table.insert(commits, {name = "ffdccc0", message = "updated foobar.txt to reflect the values of this institution"})
local commit_index = 0

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

  left:option('*', function() reader:branch(function() script.show_commit(5) end) end)
  left:endln()
  left:println("|")
  left:println("|")
  left:println("|")
  left:option('*', function() reader:branch(function() script.show_commit(4) end) end)
  left:endln()
  left:println("|\\")
  left:println("| \\")
  left:println("|  \\")
  left:option('*', function() reader:branch(function() script.show_commit(3) end) end)
  left:print("   ")
  left:option('*', function() reader:branch(function() script.show_commit(2) end) end) 
  left:endln()
  left:println("|  /") 
  left:println("| /")
  left:println("|/")
  left:option('*', function() reader:branch(function() script.show_commit(1) end) end) 


  for i=1, 10 do left:endln() end
  left:optionln('back', function() reader:load(scripts.intro) end) 

end

function script.show_commit(commit_index) 
  local name, message = commits[commit_index].name, commits[commit_index].message 

  right:clear() 
  right:println("commit: " .. name)
  reader:wait(0.3) 
  right:endln()
  scriptUtil.print_letters(right, reader, message, 0.03, 1)
end

return script
