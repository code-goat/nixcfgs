{ config, pkgs, lib, ... }:

{

services.nextcloud = {                
  enable = true;                   
  package = pkgs.nextcloud26;
  extraApps = {
    inherit (pkgs.nextcloud26Packages.apps)
      news
      contacts
      calendar
      tasks
    ;
  };
  extraAppsEnable = true;
};
}