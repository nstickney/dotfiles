-- Set priority for ALSA devices so USB microphones are preferred over webcams
rule = {
  matches = {
    {
      { "device.name", "matches", "alsa_card.usb-Blue_Microphones*" },
    },
  },
  apply_properties = {
    ["priority.driver"] = 2000,
    ["priority.session"] = 2000,
  },
}

table.insert(alsa_monitor.rules, rule)
