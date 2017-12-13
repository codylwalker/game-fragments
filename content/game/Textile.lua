import 'util'
import 'game'

local Textile = class('Textile')

function Textile:init(parent_ctx, obj)
    self.context = parent_ctx:new(self)

    self.glyphs = {}
    self.buttons = {}
    self.num_rows = obj.num_rows or 1
    self.num_columns = obj.num_columns or 1
    self.font = self.context.resources.font

    self:create_glyphs()
    self.write_pos = Vec2(0,0)
end

function Textile:create_glyphs()
    -- empty existing glyphs
    self.glyphs = {}

    for x = 0, self.num_columns - 1 do
        for y = 0, self.num_rows - 1 do
            self:set_glyph(x , y, Glyph(x,y, self.font))
        end
    end
end

function Textile.get:text()
    return self._text
end

function Textile:add_option(string, func, colors)
    local bg_color = Color.get_background()
    local glyphs = self:add_text(string, bg_color)
    local button = Button(self.context, glyphs, func, colors)
    table.insert(self.buttons, button)
end

function Textile:add_text(string, color)
    local glyphs = {}

    for i=1, #string do
        local char = string:sub(i,i)
        local is_added, glyph = self:add_char(char, color)

        if is_added then
            table.insert(glyphs, glyph)
        end
    end


    return glyphs
end

function Textile:add_char(char, color)
    -- go to next line when reaching end of line
    if self.write_pos.x >= self.num_columns then
        self:add_newline()
    end

    -- go back to the top when out of rows
    if self.write_pos.y >= self.num_rows then
        self:loop()
    end
    local glyph = self:get_glyph(self.write_pos.x, self.write_pos.y)
    glyph:set_text(char, color)

    -- update write position
    self.write_pos.x = self.write_pos.x + 1    
    return true, glyph
end

function Textile:add_newline()

    -- clear remaining glyphs on the row
    if self.write_pos.y < self.num_rows then
        while self.write_pos.x < self.num_columns do
            local glyph = self:get_glyph(self.write_pos.x, self.write_pos.y)
            glyph:clear()
            self.write_pos.x = self.write_pos.x + 1
        end
    end

    self.write_pos.x = 0
    self.write_pos.y = self.write_pos.y + 1
end

function Textile:loop()
    self:clear()
    self.write_pos:set_xy(0,0)
end

function Textile:clear()
    for i=0, #self.glyphs do
        self.glyphs[i]:clear()
    end

    for _,button in ipairs(self.buttons) do
        button.context.removed()
    end
    self.buttons = {}

    self.write_pos:set_xy(0,0)
end

function Textile.get:width()
    return self.num_columns * self.glyphs[0].size
end

function Textile.get:height()
    local line_height = self.glyphs[0].line_height
    return self.num_rows * (self.glyphs[0].size + line_height) - line_height
end

function Textile.get:text_height()
    local grid_height = self.glyphs[#self._text - 1].grid_pos.y + 1
    local line_height = self.glyphs[0].line_height
    return (self.glyphs[0].size + line_height) * grid_height - line_height
end

function Textile:check_bounds(x,y)
    assert(0 <= x)
    assert(x < self.num_columns)
    assert(0 <= y)
    assert(y < self.num_rows)
end

function Textile:set_glyph(x, y, value)
    self:check_bounds(x,y)
    self.glyphs[y * self.num_columns + x] = value
end

function Textile:get_glyph(x, y)
    self:check_bounds(x,y)
    return self.glyphs[y * self.num_columns + x]
end

function Textile.listens:update(dt)
    for i=0, #self.glyphs do
        self.glyphs[i]:update(dt)
    end

    if love.keyboard.isDown('space') then
        self:scatter()
    end
end

function Textile:scatter()
    for i=0, #self.glyphs do
        self.glyphs[i]:scatter()
    end
end

function Textile:draw()
    love.graphics.setFont(self.font)

    Color.reset()
    for _,button in ipairs(self.buttons) do
        button:draw()
    end

    local last_color
    for i=0, #self.glyphs do
        local glyph = self.glyphs[i]
        if glyph.color.a >= 0.5/256 then
          local skip_color = last_color and Color.almost_equal (last_color, glyph.color)
          glyph:draw(skip_color)
          last_color = glyph.color
        end
    end

    --self:draw_mouse()
end

function Textile:draw_mouse()
    local mouse_pos = Vec2(love.mouse.getPosition())
    local index = self.context.console.index
    mouse_pos = self.context.game:screen_to_console_pos(index, mouse_pos)

    if mouse_pos then
    graphics.draw_circle
    {
        x = mouse_pos.x,
        y = mouse_pos.y,
        color = Color('red'),
        r = 10
    }
    end
end

return Textile
