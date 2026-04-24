-- EDIT THIS COOLDOWN VALUE IN SECONDS
local COOLDOWN = 60
local cooldowns = {}

-- EDIT FOLDER NAMES (NOT PATHS) YOU WANT TO AVOID RUNNING THE SCRIPT ON
local EXEMPT_ROOT_FOLDERS = {
    ["FOLDER1"] = true,
    ["FOLDER2"] = true,
    ["FOLDER3"] = true,
}

local mp = mp
local os_time = os.time

local function get_model_from_path(path)
    if not path or path == "" then return nil end

    path = path:gsub("\\", "/")
    path = path:gsub("^[a-zA-Z]+://", "")
    path = path:gsub("^[a-zA-Z]:/", "/")
    path = path:gsub("^/+", "")

    local i = 0
    for part in path:gmatch("[^/]+") do
        i = i + 1
        if i == 2 then
            if EXEMPT_ROOT_FOLDERS[part] then
                return nil
            end
            return part
        end
    end

    return nil
end

local function osd(t)
    mp.osd_message(t, 2)
end

local function pick_next_valid(now, start_index, playlist)
    for i = start_index, #playlist do
        local e = playlist[i]
        if e and e.filename then
            local m = get_model_from_path(e.filename)

            if not m then
                return i
            end

            local last = cooldowns[m]
            if not last or (now - last >= COOLDOWN) then
                return i
            end
        end
    end
    return nil
end

-- 🔥 EARLIEST CONTROL POINT
mp.add_hook("on_preloaded", 50, function()
    local now = os_time()

    local playlist = mp.get_property_native("playlist")
    local pos = mp.get_property_number("playlist-pos")

    if not playlist or not pos then return end

    local cur = playlist[pos + 1]
    if not cur then return end

    local model = get_model_from_path(cur.filename)
    if not model then
        return
    end

    local last = cooldowns[model]

    if last and (now - last < COOLDOWN) then
        local found = pick_next_valid(now, pos + 2, playlist)

        if found then
            osd("SKIPPING " .. model)
            mp.set_property_number("playlist-pos", found - 1)
        else
            osd("No eligible items → anything")
            cooldowns[model] = now
        end

        return
    end

    cooldowns[model] = now
    osd("PLAYING " .. model)
end)
