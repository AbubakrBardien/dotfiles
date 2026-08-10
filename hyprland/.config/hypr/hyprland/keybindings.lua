-------------------
--- Keybindings ---
-------------------

local globals = require("hyprland.global_variables")

-- stylua: ignore start

-- Function Keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("volume_popup.sh up"))
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("volume_popup.sh down"))
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("volume_popup.sh mute"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brillo -q -U 5 -u 250000"))
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brillo -q -A 5 -u 250000"))

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + Return",    hl.dsp.exec_cmd(globals.terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen { action = "toggle" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float { action = "toggle" })

-- Dwindle layout specific 
hl.bind(mainMod .. " + K", hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + L", hl.dsp.layout("togglesplit"))

-- Launch Apps
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(globals.browser))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(globals.appLauncher))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(globals.powerMenu))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(globals.wifiMenu))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(globals.screenshot))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(globals.emojiMenu))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(globals.appLauncherAlt))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0

	-- Switch workspaces with mainMod + [0-9]
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))

	-- Move active window to a workspace with mainMod + SHIFT + [0-9]
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272",        hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + CTRL + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- stylua: ignore end
