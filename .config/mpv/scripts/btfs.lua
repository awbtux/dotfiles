local utils = require "mp.utils";
local btfs_mountpoints = {}

local settings = {
    unmount = true,
    base_mount_directory = "/tmp/mpv-btfs",
    only_handle_prefixed_files = false,
    btfs_data_directory = "",
    btfs_flags = [[]],
}

require("mp.options").read_options(settings, "btfs-stream")


-- helper
local function ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

-- decide whether btfs should handle the file/url schema
local function is_handled_url(url)
    if settings.only_handle_prefixed_files then
        return url:find("btfs://") == 1
    else
        return (url:find("magnet:") == 1 or url:find("peerflix://") == 1 or url:find("btfs://") == 1 or ends_with(url, "torrent"))
    end
end

-- main
local function btfs_play_torrent()
    local url = mp.get_property("stream-open-filename")
    if is_handled_url(url) then
        if url:find("btfs://") == 1 then url = url:sub(8) end
        if url:find("peerflix://") == 1 then url = url:sub(12) end
        local new_dir = mp.get_time()
        local torrent_info = mp.command_native({
            name = "subprocess",
            playback_only = false,
            capture_stdout = true,
            args = {"webtorrent", "info", url},
        })
        if torrent_info.status == 0 then
            local infoHash = utils.parse_json(torrent_info.stdout)["infoHash"]
            if infoHash ~= nil then new_dir = infoHash end
        end
        local mount_dir = utils.join_path(settings.base_mount_directory, new_dir)
        mp.commandv("run", "mkdir", "-p", mount_dir)

        local btfs_command = {"run", "btfs"}
        local btfs_flags = utils.parse_json(settings.btfs_flags)
        if btfs_flags ~= nil then
            for _, flag in pairs(btfs_flags) do
                table.insert(btfs_command, flag)
            end
        end
        if settings.btfs_data_directory ~= "" then
            local data_dir = mp.command_native({"expand-path", settings.btfs_data_directory})
            table.insert(btfs_command, "--data-directory=" .. data_dir)
        end
        table.insert(btfs_command, url)
        table.insert(btfs_command, mount_dir)
        mp.command_native(btfs_command)

        mp.msg.info("Waiting for video to load")
        while utils.readdir(mount_dir)[1] == nil do
            os.execute("sleep 1")
        end

        table.insert(btfs_mountpoints, mount_dir)
        mp.set_property("stream-open-filename", mount_dir)
    end
end

-- os.execute, commandv, and command_native all block even with nohup; from docs: "Only the run command can start processes in a truly detached way." (not supbrocess)
local function btfs_cleanup()
    if settings.unmount then
        for _, mount_dir in pairs(btfs_mountpoints) do
            mp.msg.verbose("Unmounting and deleting " .. mount_dir)
            mp.commandv("run", "setsid", "-f", "sh", "-c", '"fusermount -u ' .. "'" .. mount_dir .. "'" .. ' && rmdir ' .. "'" .. mount_dir .. "'" .. '"')
        end
    end
end

mp.add_hook("on_load", 50, btfs_play_torrent)
mp.register_event("shutdown", btfs_cleanup)
