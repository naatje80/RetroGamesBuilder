local TOTAL_INSTALL_SIZE = 285885095;
local GAMENAME = "PinballGoldPack";
local LONG_GAMENAME = "Pinball Gold Pack";
local GAME_DESCRIPTION = "Pinball Video Game";
local VENDOR_NAME = "MyBrand";

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
            name = "Pinball Fantasies Deluxe",
            genericname = "Pinball Fantasies Deluxe",
            tooltip = GAME_DESCRIPTION,
            builtin_icon = false,
            icon = "gameicon.png",
            commandline = "%0/start_pinfant.sh",
            category = "Game"
        }, 
        
        Setup.DesktopMenuItem
        {
            disabled = false,
            name = "Pinball Deams Deluxe",
            genericname = "Pinball Dreams Deluxe",
            tooltip = GAME_DESCRIPTION,
            builtin_icon = false,
            icon = "gameicon2.png",
            commandline = "%0/start_pindrms.sh",
            category = "Game"
        },
        
        Setup.DesktopMenuItem
        {
            disabled = false,
            name = "Pinball Illusions",
            genericname = "Pinball Illusions",
            tooltip = GAME_DESCRIPTION,
            builtin_icon = false,
            icon = "gameicon3.png",
            commandline = "%0/start_pinill.sh",
            category = "Game" 
        }
    }
}

-- end of config.lua ...

