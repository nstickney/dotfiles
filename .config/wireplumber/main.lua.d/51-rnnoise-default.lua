-- Set the RNNoise filtered microphone as the default audio source
rule = {
  matches = {
    {
      { "node.name", "equals", "rnnoise_source" },
    },
  },
  apply_properties = {
    ["device.description"] = "Noise Canceling Microphone",
    ["priority.session"] = 1000,
  },
}

table.insert(alsa_monitor.rules, rule)
