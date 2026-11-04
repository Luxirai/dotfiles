require("config.monitors")
require("config.autostart")
require("config.environment")
require("config.ui")
require("config.devices")
require("config.keybindings")
require("config.core")

-- For Noctalia Color templates
require("noctalia").apply_theme()

hl.bind("CTRL + SHIFT + 2", hl.dsp.global("com.t3tools.T3Code:capture-window"))
