game = {}
game.images = {}
game.classes = {}

function love.load()
  game.state = require("lib.state")

  game.classes.Object = require("lib.classic")
  game.lovebpm = require("lib.lovebpm")

  game.curMod = love.filesystem.read("loadedMod.txt") or false

  local baseImagesPath = "assets/images"

  local function loadallimg(imgpath,cut)
    if not cut then cut=1 end
    local items = love.filesystem.getDirectoryItems( imgpath )
    for i,v in ipairs(items) do
      local path = imgpath.."/"..v
      local info = love.filesystem.getInfo( path )
      if info then
        if info.type == "file" then
          game.images[path:sub(cut,-1)] = love.graphics.newImage(path)
        elseif info.type == "directory" then
          loadallimg(path,cut)
        end
      end
    end
  end

  loadallimg(baseImagesPath, baseImagesPath:len())

  if game.curMod then
    local modImagesPath = "mods/images"
    loadallimg(modImagesPath, modImagesPath:len())
  end

  game.state.switch("splash")
end