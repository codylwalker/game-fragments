import 'util'

local Box = class 'Box'

function Box:init (position, size)
  if Box.is_type_of (position) then
    position, size = position.position, position.size
  end

  self._position = Vec2 (0, 0)
  self._size = Vec2 (0, 0)

  if position then 
    self._position:set_from (position)
  end
  if size then
    self._size:set_from (size)
  end
end

function Box.get:position ()
  return self._position
end

function Box.set:position (value)
  self._position:set_from (value)
end

function Box.get:size ()
  return self._size
end

function Box.set:size (value)
  self._size:set_from (value)
end

function Box.get:width ()
  return self.size.x
end

function Box.get:height ()
  return self.size.y
end

function Box.get:left ()
  return self.position.x
end

function Box.get:right ()
  return self.position.x + self.size.x
end

function Box.get:top ()
  return self.position.y
end

function Box.get:bottom ()
  return self.position.y + self.size.y
end

function Box.get:top_left ()
  return self.position
end

function Box.get:top_right ()
  return self.position + Vec2 (self.size.x, 0)
end

function Box.get:bottom_left ()
  return self.position + Vec2 (0, self.size.y)
end

function Box.get:bottom_right ()
  return self.position + Vec2 (self.size.x, self.size.y)
end

function Box:get_anchor (offset_x, offset_y)
  if Vec2.is_type_of (offset_x) then
    offset_x, offset_y = offset_x.x, offset_x.y
  end
  return Vec2 (
    self.position.x + offset_x * self.size.x,
    self.position.y + offset_y * self.size.y)
end

function Box:contains(point)
  return point.x > self.position.x and point.x < self.position.x + self.size.x and
    point.y > self.position.y and point.y < self.position.y + self.size.y
end

function Box:draw()
  love.graphics.rectangle('fill', self.position.x, self.position.y, self.size.x, self.size.y)
end

return Box
