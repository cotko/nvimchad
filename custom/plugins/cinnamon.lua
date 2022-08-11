local present, plug = pcall(require, "cinnamon")

if not present then
  return
end

plug.setup {}
