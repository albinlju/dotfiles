local M = {}

---@param lsp_name string
---@return string
function M.get_nix_profile_binary_path(name)
  local handle = io.popen("nix profile list --json")
  local result = handle:read("*a")
  handle:close()
  local data = vim.json.decode(result)

  local store_path
  for _, element in pairs(data.elements) do
    if element.active then
      store_path = element.storePaths[1]
      break
    end
  end
  assert(store_path, "Failed to find active nix profile element")

  return store_path .. "/bin/" .. name
end

return M
