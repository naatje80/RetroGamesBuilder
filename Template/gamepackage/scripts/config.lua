local TOTAL_INSTALL_SIZE = 58619880;
local GAMENAME = <SHORT_GAMENAME>;
local LONG_GAMENAME = <GAMENAME>;
local GAME_DESCRIPTION = <GAME_DESCRIPTION>;
local VENDOR_NAME = <VENDOR_NAME>;

local _ = MojoSetup.translate

-- Vendor must be one word, otherwise icon creation fails
Setup.Package
{
    vendor = VENDOR_NAME,
    id = GAME_NAME,
    description = GAME_NAME,
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
        description = LONG_GAME_NAME .. "README",
        source = "README-linux.txt"
    },

    Setup.Option
    {
        value = true,
        required = true,
        disabled = false,
        bytes = TOTAL_INSTALL_SIZE,
        description = LONG_GAME_NAME,

        Setup.File
        {
            -- Just install everything we see...
        },

        Setup.DesktopMenuItem
        {
            disabled = false,
            name = LONG_GAME_NAME,
            genericname = LONG_GAME_NAME,
            tooltip = GAME_DESCRIPTION,
            builtin_icon = false,
            icon = "gameicon.png",
            commandline = "%0/start.sh",
            category = "Game"
        }
    }
}

-- end of config.lua ...

