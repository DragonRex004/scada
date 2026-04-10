local config = require("config")
local ui = require("lib/ui")
local energyLib = require("lib/energy")

local energy = energyLib.wrap(config.energySide)
if not energy then error("Kein Energy Peripheral!") end

local monitor = config.monitor and peripheral.find("monitor")
if monitor then monitor.setTextScale(2) end

local termTarget = monitor or term

local last = energy.get()

while true do
    termTarget.setBackgroundColor(colors.black)
    termTarget.clear()

    local current = energy.get()
    local max = energy.getMax()

    local percent = max and (current / max) or 0
    local delta = current - last
    last = current

    -- Titel
    termTarget.setTextColor(colors.cyan)
    ui.center(termTarget, 1, "POWER GRID")

    -- Werte
    termTarget.setTextColor(colors.white)
    ui.center(termTarget, 3, ui.format(current) .. " FE")

    if max then
        ui.center(termTarget, 4, ui.format(max) .. " FE MAX")
        ui.center(termTarget, 5, string.format("%.1f%%", percent * 100))
    else
        ui.center(termTarget, 4, "MAX UNKNOWN")
    end

    -- Balken
    ui.bar(termTarget, 2, 7, 30, percent)

    -- Delta
    termTarget.setCursorPos(2, 9)
    if delta > 0 then
        termTarget.setTextColor(colors.green)
        termTarget.write("+" .. ui.format(delta) .. " FE/t")
    elseif delta < 0 then
        termTarget.setTextColor(colors.red)
        termTarget.write(ui.format(delta) .. " FE/t")
    else
        termTarget.setTextColor(colors.gray)
        termTarget.write("0 FE/t")
    end

    sleep(config.refreshRate)
end