local globals = require("hyprland.global_variables")

--------------------------------
-- Default Graphical Programs --
--------------------------------

hl.env("BROWSER", globals.browser)

-----------------------------------
-- Graphics Driver Configuration --
-----------------------------------

-- stylua: ignore start

hl.env("LIBVA_DRIVER_NAME",         "nvidia")
hl.env("GBM_BACKEND",               "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND",               "direct")

-- stylua: ignore end

--------------------------
-- Cursor Configuration --
--------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------
-- Other --
-----------

hl.env("QT_STYLE_OVERRIDE", "kvantum")
