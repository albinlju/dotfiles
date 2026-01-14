local M = {}

---@param lsp_name string
---@return string
function M.get_nix_profile_binary_path(name)
  local handle = io.popen("nix profile list --json")
  local result = handle:read("*a")
  handle:close()
  local data = vim.json.decode(result)

  local store_path = data.elements["nix/profiles/base"].storePaths[1]
  --assert(store_path == nil, "Failed to get base path code:" .. vim.inspect(store_path))

  return store_path .. "/bin/" .. name
end

return M
