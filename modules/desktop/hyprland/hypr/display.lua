  --###############
  --## MONITORS ###
  --###############

  -- Primary Monitor
  --monitor=DP-1,2560x1440@480, 2560x0, 1.066667, vrr, 0

hl.monitor({
    output = "DP-1",
    mode = "highrr",
    position = "2560x0",
    scale = "1.233333",
    --vrr = 1
    --bitdepth = 10,
    --cm = "hdr",
    sdrbrightness = 1.3,
    sdrsaturation = 1.1,
    sdr_min_luminance = 0.005,
    sdr_max_luminance = 335,
})

  -- Second Monitor
hl.monitor({
    output = "HDMI-A-1",
    mode = "1600x900@60",
    position = "auto",
    scale = "auto",
})

  -- unscale XWayland

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
    render = {
        --cm_fs_passthrough=2
        --cm_sdr_eotf = 1
        --cm_auto_hdr=1
        --cm_enabled=true
    },
})

