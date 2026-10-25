local safe = {
  print = print,
  type = type,
  tostring = tostring,
  tonumber = tonumber,
  pairs = pairs,
  ipairs = ipairs,
  pcall = pcall
}
safe._G = safe