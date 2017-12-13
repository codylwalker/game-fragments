import 'util'
import 'game'

local Game = class 'Game'

function Game.provides:game()
  return self
end

function Game.provides:resources()
  return self.resources
end


function Game:init ()
  self.app = App ()
  self.context = self.app.context:new (self)

  print('-- start game --')
  Color('#161412'):set_background()
  
  self.resources = Resources(self.context)

  self.consoles = {Console(self.context, LEFT), Console(self.context, RIGHT)}
  self.layout = Layout(self.context)
  self.script_reader = ScriptReader(self.context, self.consoles)

  self:start()
end

function Game:start()
  self.script_reader:init_saved()

  local START = self.resources.scripts.intro
  self.script_reader:load(START)
end

function Game:get_console_layout(index)
  local console = self.consoles[index]
  local panel = self.layout.panels[index]

  local console_w = console.textile.width
  local console_h = console.textile.height
  local scale = panel.height / console_h
  local offset_x = (panel.width - console_w * scale) / 2
  local position = Vec2(panel.position.x + offset_x, panel.position.y)

  return scale, position
end

function Game:draw_console(index)

  local scale, position = self:get_console_layout(index)

  love.graphics.push()
  love.graphics.translate(position.x, position.y)
  love.graphics.scale(scale, scale)

  self.consoles[index]:draw()

  love.graphics.pop()
end

function Game.listens:keypressed(key, scancode)
  if scancode == 'r' and love.keyboard.isDown ('lctrl', 'rctrl', 'lgui', 'rgui') then
    self:start()
  elseif scancode == 'escape' then
    self.script_reader:load(self.resources.scripts.intro)
  end
end

function Game.listens:draw()
  self:draw_console(LEFT)
  self:draw_console(RIGHT)
end

function Game:screen_to_console_pos(index, screen_pos)
  if self.layout.sides[index]:contains(screen_pos) then
    local scale, position = self:get_console_layout(index)
    screen_pos = (screen_pos - position) / scale
    return screen_pos
  else
    return false
  end
end

return Game
