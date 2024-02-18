local TOTAL_INSTALL_SIZE = 56553918;

local _ = MojoSetup.translate

-- Vendor must be one word, otherwise icon creation fails
Setup.Package
{
    vendor = "EpicMegaGames",
    id = "JazzJackrabbit",
    description = "Jazz Jackrabbit",
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
        description = _("Jazz Jackrabbit README"),
        source = _("README-linux.txt")
    },

    Setup.Option
    {
        value = true,
        required = true,
        disabled = false,
        bytes = TOTAL_INSTALL_SIZE,
        description = "Jazz Jackrabbit",

        Setup.File
        {
            -- Just install everything we see...
        },

        Setup.DesktopMenuItem
        {
            disabled = false,
            name = "Jazz Jackrabbit",
            genericname = "Jazz Jackrabbit",
            tooltip = "Platform video game",
            builtin_icon = false,
            icon = "gameicon.png",
            commandline = "%0/start.sh",
            category = "Game"
        }
    }
}

-- end of config.lua ...

