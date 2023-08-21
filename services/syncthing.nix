# Syncthing Declarative Configuration
  services = {
    syncthing = {
      enable = true;
      user = "r0b0ty";
      dataDir = "/home/r0b0ty/Syncthing"; # Defined but not used, by design
      configDir = "/home/r0b0ty/.config/syncthing";
      openDefaultPorts = true;
      guiAddress = "127.0.0.1:8384";
      settings = {
        overrideDevices = true;
        overrideFolders = true;
        devices = {
          "truenas" = { id = "<super long one>"; };
        };
        extraOptions = {
          defaults = {
            ignores = [ "(?d).DS_Store" "(?i)*.swp" "(?i)*.bak" "(?i)*.*_bak" "(?i)*.bkp" "(?i)*.???_"];
          };
        };
		< CUT ALL MY FOLDER OPTIONS >
