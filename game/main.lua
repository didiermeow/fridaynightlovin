game = {}
game.images = {}

function love.load()
  state = require("lib.state")

  Object = require("lib.classic")
  lovebpm = require("lib.lovebpm")

  game.curMod = love.filesystem.read("loadedMod.txt")

  if not game.curMod then game.curMod=false end

  local baseImagesPath = love.filesystem.getDirectoryItems( "assets/images" )

  local function loadallimg(imgpath,fp)
    fullpath = fp or imgpath
    local items = love.filesystem.getDirectoryItems( imgpath )
    for i,v in ipairs(items) do
      local path = imgpath.."/"..v
      local info = love.filesystem.getInfo( path )
      if info then
        if info.type == "file" then
          game.images[fullpath] = love.graphics.newImage(path)
        elseif info.type == "directory" then
          -- do something
        end
      end
    end
  end

  state.switch("splash")
end