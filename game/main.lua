game = {}
game.images = {}

function love.load()
  state = require("lib.state")

  Object = require("lib.classic")
  lovebpm = require("lib.lovebpm")

  game.curMod = love.filesystem.read("loadedMod.txt")

  if not game.curMod then game.curMod=false end

  local baseImagesPath = love.filesystem.getDirectoryItems( "assets/images" )
  for i,v in ipairs(baseImagesPath) do
    local path = "assets/images".."/"..v
    local info = love.filesystem.getInfo( path )
    if info then
      if info.type == "file" then
      elseif info.type =="directory" then
      end
    end
  end

  state.switch("splash")
end