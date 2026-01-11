-- Auto-switch to newly connected Bluetooth audio devices
-- This ensures when you connect headphones/speakers, they become the active output

bluez_monitor.properties = {
  -- Auto-switch to Bluetooth devices when they connect
  ["bluez5.autoswitch-profile"] = true,

  -- Enable headset head unit (HSP/HFP) support
  ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]",

  -- Hardware volume control
  ["bluez5.enable-hw-volume"] = true,

  -- High quality audio codecs
  ["bluez5.enable-sbc-xq"] = true,
  ["bluez5.enable-msbc"] = true,
}
