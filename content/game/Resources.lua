import 'util'
import 'game'

local Resources = class 'Resources'

function Resources:init(parent_ctx)
  self.context = parent_ctx:new(self)
  self.scripts = require 'game.scripts'

  self.font = love.graphics.newFont ('fonts/CPMono.otf', 32)
  love.graphics.setFont(self.font)
  
end

return Resources
