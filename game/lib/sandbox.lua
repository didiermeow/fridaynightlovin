local safe = {
  print = print,
  type = type,
  tostring = tostring,
  tonumber = tonumber,
  pairs = pairs,
  ipairs = ipairs,
  pcall = pcall,
  math = {  },
  string = {  },
  table = {  },
  os = {  }
}
safe._G = safe

return function(path)
  local chunk, err = loadfile(path)
  if not chunk then
    return nil, err
  end
  setfenv(chunk, safe)
  local success, res = pcall(chunk)
  if not success then
    return nil, res
  end
  return res
end