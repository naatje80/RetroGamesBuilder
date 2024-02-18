local TOTAL_INSTALL_SIZE = 512710306;

local _ = MojoSetup.translate

-- Vendor must be one word, otherwise icon creation fails
Setup.Package
{
    vendor = "EidosInteractive",
    id = "TombRaider",
    description = "Tomb Raider",
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
        description = _("Tomb Raider README"),
        source = _("README-linux.txt")
    },

    Setup.Option
    {
        value = true,
        required = true,
        disabled = false,
        bytes = TOTAL_INSTALL_SIZE,
        description = "Tomb Raider",

        Setup.File
        {
            -- Just install everything we see...
        },

        Setup.DesktopMenuItem
        {
            disabled = false,
            name = "Tomb Raider",
            genericname = "Tomb Raider",
            tooltip = "Platform video game",
            builtin_icon = false,
            icon = "gameicon.png",
            commandline = "%0/start.sh",
            category = "Game"
        }
    }
}

-- end of config.lua ...

