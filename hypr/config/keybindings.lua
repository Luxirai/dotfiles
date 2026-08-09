local terminal = "kitty"
local fileManager = "thunar"
local ipc = "/home/h4ni0/.local/bin/noctalia msg "
local mod = "SUPER"
local modShift = "SUPER + SHIFT"

local function resizeActive(dx, dy)
    local window = hl.get_active_window()
    if not window then
        return
    end

    local size = window.size
    local width = size.x + dx
    local height = size.y + dy
    if width < 1 or height < 1 then
        return
    end

    return hl.dispatch(hl.dsp.window.resize({
        x = width,
        y = height,
        window = window,
    }))
end

-- Programs
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mod .. " + O", hl.dsp.exec_cmd("obsidian"))

-- General
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(modShift .. " + Q", hl.dsp.window.kill())
hl.bind(mod .. " + W", hl.dsp.window.close({ window = "" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + M", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(modShift .. " + V", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))
hl.bind(mod .. " + Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mod .. " + t", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mod .. " + F4", hl.dsp.exec_cmd(ipc .. "session lock-and-suspend"))
hl.bind(modShift .. " + equal", function()
    hl.monitor({
        output = "DP-2",
        mode = "3840x2160@60",
        position = "0x0",
        scale = 2.5,
    })
end)
hl.bind(modShift .. " + minus", function()
    hl.monitor({
        output = "DP-2",
        mode = "3840x2160@60",
        position = "0x0",
        scale = 2,
    })
end)
hl.bind(modShift .. " + Space", hl.dsp.exec_cmd(ipc .. "screenshot-region"))
hl.bind(modShift .. " + CTRL + Space", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))
hl.bind(modShift .. " + BackSpace", hl.dsp.exec_cmd(ipc .. "bar-toggle"))

-- Windows
hl.bind(mod .. " + tab", hl.dsp.focus({ last = true }))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))
hl.bind(mod .. " + S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mod .. " + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))

hl.bind(mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(modShift .. " + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(modShift .. " + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(modShift .. " + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(modShift .. " + j", hl.dsp.window.move({ direction = "down" }))

hl.bind(mod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("l", function() return resizeActive(20, 0) end, { repeating = true })
    hl.bind("h", function() return resizeActive(-20, 0) end, { repeating = true })
    hl.bind("k", function() return resizeActive(0, -20) end, { repeating = true })
    hl.bind("j", function() return resizeActive(0, 20) end, { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind(mod .. " + R", hl.dsp.submap("reset"))
end)

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mod .. " + C", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + C", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mod .. " + mouse_right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_left", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize())

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"), { repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. "mic-mute"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"), { repeating = true, locked = true })

-- Player controls
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(ipc .. "media next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(ipc .. "media toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(ipc .. "media toggle"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(ipc .. "media previous"), { locked = true })


hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
