local TOTAL_INSTALL_SIZE = 171647248;
local GAME_NAME = "TheLegendOfKyrandia";
local LONG_GAME_NAME = "The Legend Of Kyrandia";
local GAME_DESCRIPTION = "Adventure Video Game";
local VENDOR_NAME = "WestwoodStudios";

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
        description = LONG_GAME_NAME .. ", Book One README",
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
            name = "Pinball Fantasies Deluxe",
            genericname = "Pinball Fantasies Deluxe",
            tooltip = GAME_DESCRIPTION,
            builtin_icon = false,
            icon = "gameicon.png",
            commandline = "%0/start.sh pinfant",
            category = "Game"
        }

        Setup.DesktopMenuItem
        {
            disabled = false,
            name = "Pinball Dreams Deluxe",
            genericname = "Pinball Dreams Deluxe",
            tooltip = GAME_DESCRIPTION,
            builtin_icon = false,
            icon = "gameicon2.png",
            commandline = "%0/start.sh pindrms",
            category = "Game"
        }

        Setup.DesktopMenuItem
        {
            disabled = false,
            name = "Pinall Illusions",
            genericname = "Pinall Illusions",
            tooltip = GAME_DESCRIPTION,
            builtin_icon = false,
            icon = "gameicon3.png",
            commandline = "%0/start.sh pinill",
            category = "Game"
        }


    }
}

-- end of config.lua ...

