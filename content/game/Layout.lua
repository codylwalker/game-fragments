import 'util'
import 'game'

local Layout = class 'Layout'

function Layout:init(parent_ctx)
  self.context = parent_ctx:new(self)

  self.panel_res = Vec2(480, 600)

  self.sides = {Box(), Box()}
  self.panels = {Box(), Box()}
end

function Layout.listens:update(dt)
  local screen_w, screen_h = love.graphics.getDimensions()

  -- sides
  self.sides[LEFT].position:set_xy(0,0)
  self.sides[LEFT].size:set_xy(screen_w/2, screen_h)
  self.sides[RIGHT].position:set_xy(screen_w/2, 0)
  self.sides[RIGHT].size:set_xy(screen_w/2, screen_h)

  local function update_panel(side, panel)
    local h = side.size.y * 0.65
    local w = h * self.panel_res.x/self.panel_res.y
    panel.size:set_xy(w, h)
    panel.position = side:get_anchor(0.5, 0.5) - panel.size/2
  end

  update_panel(self.sides[LEFT], self.panels[LEFT])
  update_panel(self.sides[RIGHT], self.panels[RIGHT])
end

function Layout:draw()
  Color('teal'):set()
  self.sides[LEFT]:draw()

  Color('orange'):set()
  self.sides[RIGHT]:draw()

  Color('grey'):set()
  self.panels[LEFT]:draw()

  Color('grey'):set()
  self.panels[RIGHT]:draw()
end

return Layout
