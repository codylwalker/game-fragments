-- Color ------------------------------------

import 'util'
local Color = class('Color')

-- init ------------------------------------------

function Color:init(color, alpha)
    if type(color) == 'string' then
        if string.sub(color,1,1) == '#' then
            color = Color.from_hex(color)
        else
            color = Color.from_name(color)
        end
    end

    self.r = color and color.r or 0
    self.g = color and color.g or 0
    self.b = color and color.b or 0
    self.a = alpha or color and color.a or 1
end

function Color:almost_equal (other)
  return 
    math.abs (self.r - other.r) +
    math.abs (self.g - other.g) +
    math.abs (self.b - other.b) +
    math.abs (self.a - other.a) < 0.25/256
end

-- formats ---------------------------------------

function Color.from_name(name)
    if     name == 'clear'      then return Color({a = 0})
    elseif name == 'black'      then return Color({})
    elseif name == 'white'      then return Color({r = 1, g = 1, b =1})
    elseif name == 'grey'       then return Color({r = 0.5, g = 0.5, b=0.5})
    elseif name == 'red'        then return Color({r = 1})
    elseif name == 'green'      then return Color({g = 1})
    elseif name == 'blue'       then return Color({b = 1})
    elseif name == 'yellow'     then return Color({r = 1, g = 1})
    elseif name == 'magenta'    then return Color({r = 1, b = 1})
    elseif name == 'orange'     then return Color({r = 1, g = 0.5})
    elseif name == 'cyan'       then return Color({g = 1, b = 1})
    elseif name == 'teal'       then return Color({g=0.5, b=0.5})
    elseif name == 'maroon'     then return Color({r=0.5})
    elseif name == 'purple'     then return Color({r=0.5, b=0.5})

    else
        error('cannot create color from name: ' .. name)
    end
end

function Color.random()
    return Color(
        {
            r = help.random(),
            g = help.random(),
            b = help.random(),
        })
end

function Color.from_hex(hex, alpha)
    hex = hex:gsub('#','')
    return Color {
            r = tonumber('0x'..hex:sub(1,2)) / 255,
            g = tonumber('0x'..hex:sub(3,4)) / 255,
            b = tonumber('0x'..hex:sub(5,6)) / 255,
            a = alpha or 1
        }
end

function Color:hex()
    local r = help.num_to_hex(self.r * 255)
    local g = help.num_to_hex(self.g * 255)
    local b = help.num_to_hex(self.b * 255)

    -- add preceding zeros to make sure each value has 2 digits
    if #r == 1 then r = 0 .. r end
    if #g == 1 then g = 0 .. g end
    if #b == 1 then b = 0 .. b end

    return '#' .. r .. g .. b, self.a
end

function Color.from_bytes(r,g,b,a)
    return Color {
        r = r / 255,
        g = g / 255,
        b = b / 255,
        a = a / 255
    }
end

function Color:bytes()
    return self.r * 255, self.g * 255, self.b * 255, self.a * 255
end

function Color:bytes_table()
    return {self.r * 255, self.g * 255, self.b * 255, self.a * 255}
end

-- get & set -------------------------------------

-- setting the __call metamethod for get/set tables (from class) in order to
-- call getColor/setColor and still be able to use getter/setter functionality

setmetatable(Color.get,
{
    __call = function() return Color.from_bytes(love.graphics.getColor()) end
})

setmetatable(Color.set,
{
    __call = function(t, color)
        assert(color ~= Color)

        color = Color.is_type_of(color) and color or Color(color)
        love.graphics.setColor(color:bytes())
    end
})

function Color.get_background()
    return Color.from_bytes(love.graphics.getBackgroundColor())
end

function Color.set_background(color)
    local color = Color.is_type_of(color) and color or Color(color)
    love.graphics.setBackgroundColor(color:bytes())
end

-- resets by showing white
function Color.reset()
    love.graphics.setColor(255,255,255,255)
end

-- HSL -------------------------------------------

-- inspirations:
-- https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua
-- http://www.niwa.nu/2013/05/math-behind-colorspace-conversions-rgb-hsl
--
function Color.from_hsl(h, s, l, a)
  local color = Color()

  if s == 0 then
    color.r, color.g, color.b = l, l, l -- achromatic
  else
    local function hue2rgb(p, q, t)
      if t < 0   then t = t + 1 end
      if t > 1   then t = t - 1 end
      if t < 1/6 then return p + (q - p) * 6 * t end
      if t < 1/2 then return q end
      if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
      return p
    end

    local q
    if l < 0.5 then q = l * (1 + s) else q = l + s - l * s end
    local p = 2 * l - q

    color.r = hue2rgb(p, q, h + 1/3)
    color.g = hue2rgb(p, q, h)
    color.b = hue2rgb(p, q, h - 1/3)
  end

  color.a = a or 1

  return color
end

function Color:hsl()
    local h, s, l

    -- find min / max rgb values
    local min = math.min(self.r, self.g, self.b)
    local max = math.max(self.r, self.g, self.b)

    -- calculate luminance by adding the max and min valued and divide by 2
    l = (min + max) / 2

    -- if the min and max are the same then there is no saturation or hue (achromatic)
    if min == max then
        h, s = 0, 0
    else
        local d = max - min

        -- if luminance is greater than 0.5 then saturation = (max - min) / (2 - max - min)
        if l > 0.5 then
            s = d / (2 - max - min)
        else
            -- otherwise saturation = (max - min) / (2 - max - min)
            s = d / (max + min)
        end

        if max == self.r then -- red is max
            h = (self.g - self.b) / d

            if self.g < self.b then
                h = h + 6
            end

        elseif max == self.g then -- green is max
            h = (self.b - self.r) / d + 2
        elseif max == self.b then -- blue is max
            h = (self.r - self.g) / d + 4
        end

        h = h / 6
    end

    return h, s, l, self.a
end

function Color.get:h()
    local h, s, l = self:hsl()
    return h
end

function Color.get:s()
    local h, s, l = self:hsl()
    return s
end

function Color.get:l()
    local h, s, l = self:hsl()
    return l
end

function Color.set:h(value)
    local h, s, l = self:hsl()
    h = help.clamp(0, value, 1)
    local hsl_color = Color.from_hsl(h,s,l)

    self.r = hsl_color.r
    self.g = hsl_color.g
    self.b = hsl_color.b
end

function Color.set:s(value)
    local h, s, l = self:hsl()
    s = help.clamp(0, value, 1)
    local hsl_color = Color.from_hsl(h,s,l)

    self.r = hsl_color.r
    self.g = hsl_color.g
    self.b = hsl_color.b
end

function Color.set:l(value)
    local h, s, l = self:hsl()
    l = help.clamp(0, value, 1)
    local hsl_color = Color.from_hsl(h,s,l)

    self.r = hsl_color.r
    self.g = hsl_color.g
    self.b = hsl_color.b
end

-- print -----------------------------------------

function Color.metatable:__tostring ()
    return  '{ r = ' .. (self.r or 0) ..
            ', g = ' .. (self.g or 0) ..
            ', b = ' .. (self.b or 0) ..
            ', a = ' .. (self.a or 0) .. '}'
end

return Color
