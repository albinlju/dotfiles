local M = {}

M.flake_location = "/home/vscode/dotfiles/nix/profiles/base/"

---@return string
function M.get_hostname()
  local non_nix_systems = {}
  local hostname = vim.uv.os_gethostname()
  if vim.tbl_contains(non_nix_systems, hostname) then
    return "x1"
  end
  return hostname
end

return M
