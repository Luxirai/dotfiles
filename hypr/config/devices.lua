hl.config({ input = { kb_layout = "us, ara" } })
hl.config({ input = { kb_variant = "," } })
hl.config({ input = { kb_model = "" } })
hl.config({ input = { kb_options = "grp:shifts_toggle" } })
hl.config({ input = { kb_rules = "" } })
hl.config({ input = { follow_mouse = 1 } })
hl.config({ input = { sensitivity = 0 } })
hl.config({ input = { touchpad = { natural_scroll = false } } })

hl.device({
    name = "logitech-usb-receiver-mouse",
    sensitivity = -0.5,
})

-- Keep pen input on the Samsung DisplayPort screen, not the combined desktop.
hl.device({
    name = "wacom-intuos-m-pen",
    output = "DP-2",
    relative_input = false,
})
