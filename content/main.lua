if not love.filesystem.isFused() then
  io.stdout:setvbuf("no")
end

LEFT = 1
RIGHT = 2

require 'util'
import 'util'
import 'game'

love.load:listen (function ()
  local game = Game ()
  collectgarbage ()
  collectgarbage ()
end)

collectgarbage ()
collectgarbage ()
