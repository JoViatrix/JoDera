hl.on("hyprland.start", function()
  hl.exec_cmd("regreet; hyprctl dispatch 'hl.dsp.exit()'")
end)