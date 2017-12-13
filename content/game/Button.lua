import 'util'
import 'game'

local Button = class 'Button'

local padding = 10

function Button:init(parent_ctx, glyphs, click_func, colors)
  self.context = parent_ctx:new(self)
  self.glyphs = glyphs
  self.colors = colors

  self.over = false
  self.down = false
  self.click_func = click_func
end

function Button:draw()
  local color
  if self.down then
    color = self.colors.down
  elseif self.over then
    color = self.colors.over
  else
    color = self.colors.up
  end

  color:set()

  for _,glyph in ipairs(self.glyphs) do
    graphics.draw_rectangle
    {
        x = glyph.position.x - padding,
        y = glyph.position.y - padding,
        w = glyph.size + padding * 2,
        h = glyph.size + padding * 2,
        mode = 'fill',
    }
  end
end

function Button:on_mouse_move(x, y)
  local mouse_pos = Vec2(love.mouse.getPosition())
  local index = self.context.console.index
  mouse_pos = self.context.game:screen_to_console_pos(index, mouse_pos)

  if mouse_pos then
    for _,glyph in ipairs(self.glyphs) do
      self.over = mouse_pos.x > glyph.position.x - padding and mouse_pos.x < glyph.position.x + glyph.size + padding*2 and
                  mouse_pos.y > glyph.position.y - padding and mouse_pos.y < glyph.position.y + glyph.size + padding*2

      if self.over then
        break
      end
    end
    
    if not self.over then
      self.down = false
    end
  end
end

function Button:on_mouse_down(is_down)
  if self.down and not is_down and self.over then
    self:click()
  end

  self.down = self.over and is_down
end

function Button.listens:mousepressed(x, y, button)
  self:on_mouse_move (x, y)
  if button == 1 then
    self:on_mouse_down (true)
  end
end

function Button.listens:mousereleased(x, y, button)
  self:on_mouse_move (x, y)
  if button == 1 then
    self:on_mouse_down (false)
  end
end

function Button.listens:mousemoved(x, y, dx, dy)
  self:on_mouse_move(x, y)
end

function Button:click()
  self.click_func()
  -- play sound
end


return Button