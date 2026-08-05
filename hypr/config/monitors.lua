hl.monitor({
    output = "DP-2",
    mode = "3840x2160@60",
    position = "0x0",
    scale = 2,
})

hl.monitor({
    output = "HDMI-A-3",
    mode = "preferred",
    position = "auto-right",
    scale = 1,
})

hl.workspace_rule({ workspace = "1", monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "3", monitor = "DP-2" })
hl.workspace_rule({ workspace = "4", monitor = "DP-2" })
hl.workspace_rule({ workspace = "5", monitor = "DP-2" })
hl.workspace_rule({ workspace = "6", monitor = "DP-2" })
hl.workspace_rule({ workspace = "7", monitor = "DP-2" })
hl.workspace_rule({ workspace = "8", monitor = "DP-2" })
hl.workspace_rule({ workspace = "9", monitor = "DP-2" })
hl.workspace_rule({ workspace = "10", monitor = "DP-2" })
hl.workspace_rule({
    workspace = "11",
    monitor = "HDMI-A-3",
    default = true,
    persistent = true,
})
