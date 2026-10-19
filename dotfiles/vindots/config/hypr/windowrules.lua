

hl.window_rule({
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

--# Alacritty
hl.window_rule({
    match = {
        class = "^(Alacritty)$",
    },
    float = true,
    size = "1200 750",
})
--# Thunar File Manager

hl.window_rule({
    match = {
        class = "^(thunar)$",
    },
    float = true,
    size = "1000 750",
})

--# Bluetooth
hl.window_rule({
    match = {
        class = "^(.blueman-manager-wrapped)$",
    },
    float = true,
    size = "600 400",
})

--#windowrule = float,^(.blueman-manager-wrapped)$

--# Pavu Control
hl.window_rule({
    match = {
        class = "^(org.pulseaudio.pavucontrol)$",
        title = "^(Volume Control)$",
    },
    float = true,
    size = "700 400",
})

--# Steam Window Rules
hl.window_rule({
    match = {
        class = "^(steam)$",
        title = "^(Steam Settings)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(steam)$",
        title = "^(Friends List)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "^(steam)$",
        title = "^(Steam)$",
    },
    float = false,
    workspace = "2",
})

--#windowrulev2 = stayfocused,class:^(steam)$,title:^(Friends List)$
hl.window_rule({
    match = {
        class = "title:^(.*Steam.*)$",
    },
    workspace = "2 silent",
})

--#windowrulev2 = stayfocused,title:^()$,class:^(steam)$
--#windowrulev2 = minsize 1 1,title:^()$,class:^(steam)$

--# Fluxer
hl.window_rule({
    match = {
        class = "^(fluxer-canary)$",
    },
    workspace = "3",
    workspace = "3 silent",
    float = true,
    size = "1500 1000",
})

--# Spotify
hl.window_rule({
    match = {
        class = "^(Spotify)$",
    },
    float = true,
    size = "1200 900",
    workspace = "3 silent",
})

hl.window_rule({
    match = {
        class = "^(com.github.th_ch.youtube_music)$",
    },
    float = true,
    size = "1100 700",
    workspace = "3 silent",
})


--# Cool Retro Term
hl.window_rule({
    match = {
        class = "^(cool-retro-term.)$",
    },
    animation = "popin 75%",
})


--# Kdenlive
--#windowrulev2 = fullscreen, class:^(org.kde.kdenlive)$


