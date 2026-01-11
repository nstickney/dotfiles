-- Set audio output priority: Bluetooth headset/headphones > Bluetooth speakers > HDMI > others
-- Higher priority.session values are preferred

-- Bluetooth headsets and headphones (highest priority)
headset_rule = {
  matches = {
    {
      { "device.bus", "equals", "bluetooth" },
      { "device.form_factor", "matches", "head*" },
    },
  },
  apply_properties = {
    ["priority.driver"] = 3000,
    ["priority.session"] = 3000,
  },
}

-- Bluetooth speakers (second priority)
bluetooth_speaker_rule = {
  matches = {
    {
      { "device.bus", "equals", "bluetooth" },
      { "device.form_factor", "equals", "speaker" },
    },
  },
  apply_properties = {
    ["priority.driver"] = 2500,
    ["priority.session"] = 2500,
  },
}

-- HDMI output (third priority)
hdmi_rule = {
  matches = {
    {
      { "node.name", "matches", "*hdmi*" },
    },
  },
  apply_properties = {
    ["priority.driver"] = 2000,
    ["priority.session"] = 2000,
  },
}

-- Apply all rules
table.insert(alsa_monitor.rules, headset_rule)
table.insert(alsa_monitor.rules, bluetooth_speaker_rule)
table.insert(alsa_monitor.rules, hdmi_rule)
