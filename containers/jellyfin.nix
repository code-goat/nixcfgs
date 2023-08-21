{ config, pkgs, ... }:

{

  # Jellyfin
  virtualisation.oci-containers.containers."jellyfin" = {
    autoStart = true;
    image = "jellyfin/jellyfin";
    volumes = [
      "/home/common/Containers/Jellyfin/config:/config"
      "/home/common/Containers/Jellyfin/cache:/cache"
      "/home/common/Containers/Jellyfin/log:/log"
      "/run/media/common/Fern_Data/Media/Movies:/movies"
      "/run/media/common/Fern_Data/Media/TV:/tv"
    ];
    ports = [ "8096:8096" ];
    environment = {
      JELLYFIN_LOG_DIR = "/log";
    };
  };

}
