local M = {}

function M.center(term, y, text)
    local w, _ = term.getSize()
    term.setCursorPos(math.floor((w - #text)/2)+1, y)
    term.write(text)
end

function M.bar(term, x, y, width, percent)
    local filled = math.floor(width * percent)

    term.setCursorPos(x, y)
    term.write("[")

    for i = 1, width do
        if i <= filled then
            term.setTextColor(colors.green)
        else
            term.setTextColor(colors.gray)
        end
        term.write("|")
    end

    term.setTextColor(colors.white)
    term.write("]")
end

function M.format(n)
    if n >= 1e6 then return string.format("%.1fM", n/1e6) end
    if n >= 1e3 then return string.format("%.1fk", n/1e3) end
    return tostring(math.floor(n))
end

return M