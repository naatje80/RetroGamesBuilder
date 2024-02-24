local TOTAL_INSTALL_SIZE = 1069637961;
local GAMENAME = "Gobliiins5";
local LONG_GAMENAME = "Gobliiins 5";
local GAME_DESCRIPTION = "Adventure Video Game";
local VENDOR_NAME = "SchnibbleProductions";

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

