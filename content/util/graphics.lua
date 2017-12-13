import 'util'
local graphics = {}

function graphics.draw_rectangle(rect)
    -- create a rectangle object if missing
    if not rect then rect = {} end

    -- use the objects values unless
    local mode = rect.mode or 'fill' -- line or fill
    local x = rect.x or 0
    local y = rect.y or 0
    local w = rect.w or 10
    local h = rect.h or 10

    -- set a color if provided
    if rect.color then rect.color:set() end

    -- draw rectangle
    love.graphics.rectangle(mode, x, y, w, h)
end

function graphics.draw_circle(circ)

    -- create a circle object if missing
    if not circ then circ = {} end

    local mode = circ.mode or 'fill'
    local x = circ.x or 0
    local y = circ.y or 0
    local radius = circ.radius or circ.r or 10
    local segments = circ.segments or circ.s or 10

    -- set a color if provided
    if circ.color then circ.color:set() end

    love.graphics.circle(mode, x, y, radius, segments)
end

function graphics.draw_image(sprite)
    if not sprite then sprite = {} end

    local image = sprite.image          -- a drawable object
    local x = sprite.x or 0             -- the position to draw the object (x-axis)
    local y = sprite.y or 0             -- the position to draw the object (y-axis)
    local r = sprite.r or 0             -- orientation (radians)
    local sx = sprite.sx or 1           -- scale factor (x-axis)
    local sy = sprite.sy or 1           -- scale factor (y-axis)
    local ox = sprite.ox or 0           -- origin offset (x-axis)
    local oy = sprite.oy or 0           -- origin offset (y-axis)
    local kx = sprite.kx or 0           -- shearing factor (x-axis)
    local ky = sprite.ky or 0           -- shearing factor (y-axis)

     -- set a color if provided
    if sprite.color then sprite.color:set() end

    love.graphics.draw(image, x, y, r, sx, sy, ox, oy, kx, ky)
end

function graphics.draw_graph(graph)
    local x = graph.x or 0
    local y = graph.y or 0
    local ratio = graph.ratio or 0
    local name = graph.name or false
    local color = graph.color or false

    local graph_bar =
    {
        color = color,
        x = x,
        y = y,
        w = 20,
        h = -80 * ratio,
        mode = 'fill'
    }
    graphics.draw_rectangle(graph_bar)

    -- draw outline
    local outline_bar =
    {
        color = color,
        x = x,
        y = y,
        w = 20,
        h = -80,
        mode = 'line'
    }
    graphics.draw_rectangle(outline_bar)

    if name then
        love.graphics.print(name, x, y + 10)
    end
end

return graphics