import 'util'
import 'game'

local ScriptReader = class 'ScriptReader'

function ScriptReader.get:scripts()
  return self.context.resources.scripts
end

function ScriptReader:init(parent_ctx, consoles)
  self.context = parent_ctx:new(self)
  self.consoles = consoles
  self.coroutine = false
  self.wait_time = 0
  self.saved = false

  self:init_saved()
end

function ScriptReader:init_saved()
  self.saved = require 'game.saved'
end

function ScriptReader:load(script)
  local interface = {
    consoles = self.consoles,
    saved = self.saved,
    reader = self,
  }

  -- clear consoles
  self.consoles[LEFT]:clear()
  self.consoles[RIGHT]:clear()

  -- set colors
  self.consoles[LEFT].colors = script.colors
  self.consoles[RIGHT].colors = script.colors

  -- set bg
  script.colors.bg:set_background()

  self.coroutine = coroutine.create(function() 
    assert (xpcall (function()
      script.run(interface)
      end, debug.traceback ) )
  end)
  self:resume()
end

function ScriptReader:branch(func)
  self.coroutine = coroutine.create(function() 
    assert (xpcall (function()
      func()
      end, debug.traceback ) )
  end)
  self:resume()
end

function ScriptReader:wait(time)
  assert(type(time) == "number", "wait: requires a number")
  coroutine.yield(time)
end

function ScriptReader:resume()
  local success, time = assert(coroutine.resume(self.coroutine))
  self.wait_time = self.wait_time + (time or 0)
end

function ScriptReader.listens:update(dt)
  -- x2 time speed when tab pressed
  -- x4 with shift-tab
  if love.keyboard.isDown('tab') then
    local shift = love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift')
    dt = dt * (shift and 8 or 4)
  end

  self.wait_time = self.wait_time - dt
  while self.wait_time <= 0 and coroutine.status (self.coroutine) ~= 'dead' do
    self:resume ()
  end
  self.wait_time = math.max (0, self.wait_time)
end

return ScriptReader
