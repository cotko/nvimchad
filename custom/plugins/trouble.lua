local present, plug = pcall(require, "trouble")

if not present then
  return
end

plug.setup {}
