local M = {}

function M.get_nix_package_path(package_name)
  local eval_command = {
    "nix",
    "eval",
    "--raw",
    string.format("nixpkgs#%s", package_name),
  }

  local result = vim.system(eval_command):wait()
  assert(result.code == 0, "Failed to get base path code:" .. vim.inspect(result))
  local basepath = result.stdout
  return basepath
end

return M
