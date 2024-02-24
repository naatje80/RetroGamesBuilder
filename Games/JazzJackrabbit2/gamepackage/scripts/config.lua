local TOTAL_INSTALL_SIZE = 1759099182;
local GAMENAME = "JazzJackrabbit2TheSecretFiles";
local LONG_GAMENAME = "Jazz Jackrabbit 2 The Secret Files";
local GAME_DESCRIPTION = "Platform Video Game";
local VENDOR_NAME = "EpicGames";

local _ = MojoSetup.translate

-- Vendor must be one word, otherwise icon creation fails
Setup.Package
{
    vendor = VENDOR_NAME,
    id = GAMENAME,
    description = GAMENAME,
    version = "1.1.3",
    splash = "splash.jpg",
    superuser = false,
    write_manifest = true,
    support_uninstall = true,
    recommended_destinations =
    {
        MojoSetup.info.homedir .. "/Games",
        "/opt/games"
    },

    Setup.Readme
    {
        description = LONG_GAMENAME .. " README",
        source = "README-linux.txt"
    },

    Setup.Option
    {
        value = true,
        required = true,
        disabled = false,
        bytes = TOTAL_INSTALL_SIZE,
        description = LONG_GAMENAME,

        Setup.File
        {
            -- Just install everything we see...
        },

        Setup.DesktopMenuItem
        {
            disabled = false,
            name = LONG_GAMENAME,
            genericname = LONG_GAMENAME,
            tooltip = GAME_DESCRIPTION,
            builtin_icon = false,
            icon = "gameicon.png",
            commandline = "%0/start.sh",
            category = "Game"
        }
    }
}

-- end of config.lua ...

