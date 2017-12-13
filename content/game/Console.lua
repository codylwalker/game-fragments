import 'util'
import 'game'

local Console = class 'Console'

function Console.provides:console()
  return self
end

function Console.get:num_rows()
  return self.textile.num_rows
end

function Console.get:num_columns()
  return self.textile.num_columns
end

function Console.get:write_pos()
  return self.textile.write_pos
end

function Console:init(parent_ctx, index)
  self.context = parent_ctx:new(self)
  self.index = index
  self.buttons = {}
  self.colors = false

  self.textile = Textile(self.context,
  {
      num_rows = 24,
      num_columns = 40,
  })
end

function Console:draw()
  Color.reset()
  self.textile:draw()
end

-- script commands

function Console:print(string, color_index)
  assert(type(string) == 'string', 'print: requires a string')
  assert(not color_index or type(color_index) == 'number', 'print: color_index requires a number' )
  if string == '' then return end

  color_index = color_index or 1
  local color = self.colors[color_index]

  self.textile:add_text(string, color)
end

function Console:println(line, color_index)
  self:print(line, color_index)
  self:endln()
end

function Console:endln()
  self.textile:add_newline()
end

function Console:clear()
  self.textile:clear()
end

function Console:option(string, func)
  self.textile:add_option(string, func, self.colors.button)
end

function Console:optionln(string, func)
  self:option(string, func)
  self:endln()
end

function Console:print_at(string, position, color_index)
  self.textile.write_pos:set_from(position)
  self:print(string, color_index)
end

return Console