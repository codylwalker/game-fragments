-- useful actions triggered by key presses

local function key_pressed(key, scancode)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'f' then
        local is_fullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not is_fullscreen)
    elseif key == 'f4' then
        -- use the date & time as the screenshot file name
        local file_name = os.date('%Y-%m-%d (%Hh %Mm %Ss)')

        print("screenshot taken: " .. file_name)
        local s = love.graphics.newScreenshot()
        s:encode('png', file_name .. '.png')
    elseif key == 'f3' then
        love.system.openURL("file://"..love.filesystem.getSaveDirectory())
    end
end

love.keypressed:listen(key_pressed)