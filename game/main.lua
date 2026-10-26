game = {}
game.images = {}

function love.load()
  state = require("lib.state")

  Object = require("lib.classic")
  lovebpm = require("lib.lovebpm")

  game.curMod = love.filesystem.read("loadedMod.txt") or false

  local baseImagesPath = "assets/images"

  local function loadallimg(imgpath)
    local items = love.filesystem.getDirectoryItems( imgpath )
    for i,v in ipairs(items) do
      local path = imgpath.."/"..v
      local info = love.filesystem.getInfo( path )
      if info then
        if info.type == "file" then
          game.images[path] = love.graphics.newImage(path)
        elseif info.type == "directory" then
          loadallimg(path)
        end
      end
    end
  end

  loadallimg(baseImagesPath)

  state.switch("splash")
end