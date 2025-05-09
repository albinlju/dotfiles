local nix_package_paths = {}

local function get_nix_package_path_cached(package_name)
  if not nix_package_paths[package_name] then
    local eval_command = {
      "nix",
      "eval",
      "--raw",
      string.format("nixpkgs#%s", package_name),
    }
    local result = vim.system(eval_command):wait()
    assert(result.code == 0, "Failed to get base path code:" .. vim.inspect(result))
    nix_package_paths[package_name] = result.stdout
  end
  return nix_package_paths[package_name]
end

local M = {}
M.get_nix_package_path = get_nix_package_path_cached

return M
