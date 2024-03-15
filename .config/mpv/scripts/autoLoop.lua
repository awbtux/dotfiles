-- automatically loop files shorter than 8 seconds
-- also applies to files without a duration (eg. images)
require 'mp.options'

function set_loop()
    local duration = mp.get_property_native("duration")

    -- Checks whether the loop status was changed for the last file
    was_loop = mp.get_property_native("loop-file")

    -- Cancel operation if there is no file duration
    if not duration then
        mp.set_property_native("loop-file", true)
        return
    end

    -- Loops file if was_loop is false, and file meets requirements
    if not was_loop and duration <= 8 then
        mp.set_property_native("loop-file", true)
        mp.set_property_bool("file-local-options/save-position-on-quit", false)
    elseif was_loop and duration > autoloop_duration then
        mp.set_property_native("loop-file", false)
    end
end

mp.register_event("file-loaded", set_loop)
