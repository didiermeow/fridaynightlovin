local state = {}

state.vars = {}

state.current = "ejdbjsdjebueuene73u3bf"

local lvcb1 = {
    "update",
    "draw",
    "errorhandler",
    "lowmemory",
    "quit",
    "threaderror",
    "directorydropped",
    "filedropped",
    "displayrotated",
    "focus",
    "mousefocus",
    "resize",
    "visible",
    "keypressed",
    "keyreleased",
    "textedited",
    "textinput",
    "mousemoved",
    "mousepressed",
    "mousereleased",
    "wheelmoved",
    "gamepadaxis",
    "gamepadpressed",
    "gamepadreleased",
    "joystickadded",
    "joystickaxis",
    "joystickhat",
    "joystickpressed",
    "joystickreleased",
    "joystickremoved",
    "touchmoved",
    "touchpressed",
    "touchreleased"
}

local lvcb2 = {}
for _,v in ipairs(lvcb1) do
    lvcb2[v] = v
end

state.loadscreen = function(name, msg)
  if name and msg then
    love.graphics.print(name .. msg)
  elseif name and (not msg) then
    love.graphics.print(name .. " is loading")
  elseif (not name) and msg then
    love.graphics.print(msg)
  else
    love.graphics.print("state loading...")
  end
end

function state.setloadscreen(func)
  if type(func) == "function" then
    state.loadscreen = func
  else
    state.loadscreen = function(name, msg)
      if name and msg then
        love.graphics.print(name .. msg)
      elseif name and (not msg) then
        love.graphics.print(name .. " is loading")
      elseif (not name) and msg then
        love.graphics.print(msg)
      else
        love.graphics.print("state loading...")
      end
    end
  end
end

function state.switch(newstate, ...)
  love.draw = function()
    state.loadscreen(newstate)
  end
  state.vars = {...}
  package.loaded[state.current] = nil
  state.cb = {}
  local new = require(newstate)
  assert(type(new) == "table","not state")
  if type(new.load)=="function" then
    new.load()
  end
  for i,v in pairs(new) do
    if lvcb2[i] then
        love[i]=v
    end
  end
  state.current = newstate
end

function state.getvars(i)
  if i then
    return state.vars[i]
  else
    return state.vars or {}
  end
end

function state.clearvars(i)
  if i then
    state.vars[i] = nil
  else
    state.vars = {}
  end
end

return state