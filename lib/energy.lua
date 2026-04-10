local M = {}

function M.wrap(side)
    local p = peripheral.wrap(side)
    if not p then return nil end

    local obj = {}

    function obj.get()
        if p.getEnergy then return p.getEnergy() end
        if p.getStored then return p.getStored() end
        return 0
    end

    function obj.getMax()
        if p.getMaxEnergy then return p.getMaxEnergy() end
        if p.getCapacity then return p.getCapacity() end
        if p.getMaxStored then return p.getMaxStored() end
        return nil
    end

    return obj
end

return M