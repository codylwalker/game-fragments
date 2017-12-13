import 'util'
import 'game'

local Glyph = class('Glyph')

local bg_color = Color('white', 0.08)
local off_distance = 40

function Glyph:init(grid_x, grid_y, font)
    self.grid_pos = Vec2(grid_x,grid_y)
    self.char = ''
    self.font = font
    self.position = Vec2(0,0)
    self.size = font:getWidth ('X')
    self.line_height = self.size
    self.color = Color()
    self.off_position = self:get_random_position()
    self.position = self.off_position
    self.active = false
    self.alpha = 0
    self.font_baseline = font:getBaseline ()
end

function Glyph:set_text(char, color)
    self.char = char
    self.color = Color(color, 0)
    self.active = true
    self.position = self.off_position
end

function Glyph:clear()
    self.active = false
end

function Glyph:scatter()
    if self.active then
        self.off_position = self:get_random_position()

        local dir_vector = self.final_pos - self.off_position
        dir_vector = dir_vector * 0.05
        self.position = self.final_pos + dir_vector
    end
end

function Glyph:get_random_position()
    local dir = Vec2(help.random() - 0.5, help.random()-0.5)
    dir:do_normalize()
    dir = self.final_pos + dir * off_distance
    return dir
end

function Glyph:update(dt)
    local target_pos = self.active and self.final_pos or self.off_position

    if self.position ~= target_pos then
        local speed = 360
        local delta = speed * dt

        if self.position:within_distance(target_pos, delta) then
            self.position = target_pos
        else
            local dir_vector = target_pos - self.position
            local distance = dir_vector:magnitude ()
            self.position = self.position + (dir_vector * (delta / distance))
        end

        -- set alpha based on distance from final position
        local dir_vector = self.final_pos - self.position
        local distance = dir_vector:magnitude ()
        self.color.a = 1 - (distance/off_distance)
    end
end

function Glyph.get:final_pos()
    local pos = self.grid_pos * self.size
    pos.y = pos.y + self.line_height * self.grid_pos.y
    return pos
end


function Glyph:draw(skip_color)
    -- self:draw_background()

    -- if not skip_color then
      self.color:set()
    -- end
    local y = self.position.y + self.size - self.font_baseline
    love.graphics.print(self.char, self.position.x, y , 0, 1, 1)
end

function Glyph:draw_background()
    graphics.draw_rectangle
    {
        x = self.position.x,
        y = self.position.y,
        w = self.size,
        h = self.size,
        mode = 'fill',
        color = bg_color
    }
end

return Glyph
