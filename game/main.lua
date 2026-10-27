game = {}
game.images = {}
game.classes = {}

function love.load()
  game.state = require("lib.state")

  game.classes.Object = require("lib.classic")
  game.lovebpm = require("lib.lovebpm")
  game.json = require("lib.json")

  game.curMod = love.filesystem.read("save/loadedMod.txt") or false
  if game.curMod=="" then game.curMod=false end

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
    local modImagesPath = "mods/"..game.curMod.."/images"
    loadallimg(modImagesPath, modImagesPath:len())
    local json = game.json
    local rawmdata = love.filesystem.read("mods/"..game.curMod.."/data/metadata.json")
    game.modMetadata = json.decode(rawmdata)
  end

  game.state.switch("states.splash")
end