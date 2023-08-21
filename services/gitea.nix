{ config, pkgs, ... }:
{
  
  services.gitea = {
    enable = true;
    appName = "TheCollab Gitea server"; # Give the site a name
};
  users.groups.storage.members = [ "gitea" ];
}
  