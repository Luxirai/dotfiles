hl.config({ xwayland = { force_zero_scaling = true } })
hl.config({ ecosystem = { no_donation_nag = true } })

local globalOptions = { transparent = true }
hl.bind("Insert", hl.dsp.global("io.github.h4ni0.linux-flow:dictate-hold"), globalOptions)
hl.bind("SHIFT + Insert", hl.dsp.global("io.github.h4ni0.linux-flow:dictate-toggle"), globalOptions)
