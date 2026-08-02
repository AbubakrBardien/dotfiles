local M = {}

-- stylua: ignore start

M.terminal = "foot"
M.browser = "brave"
M.fileManager = "nemo"
M.calculator = "qalculate-gtk"
M.appLauncher =    os.getenv("XDG_CONFIG_HOME") .. "/wofi/scripts/appLauncher.sh"
M.appLauncherAlt = os.getenv("XDG_CONFIG_HOME") .. "/rofi/scripts/appLauncher.sh"
M.powerMenu =      os.getenv("XDG_CONFIG_HOME") .. "/wofi/scripts/powerMenu.sh"
M.wifiMenu =       os.getenv("XDG_CONFIG_HOME") .. "/wofi/scripts/wifiMenu.sh"
M.emojiMenu =      os.getenv("XDG_CONFIG_HOME") .. "/wofi/scripts/emojiMenu.sh"
M.screenshot =     os.getenv("XDG_CONFIG_HOME") .. "/wofi/scripts/screenshot.sh"

-- stylua: ignore end

return M
