{ pkgs, ... }:

{

  programs.khard.enable = true;

  accounts.contact.accounts.main = {


    khard.enable = true;

    local = {
      fileExt = ".vcf";
      type = "filesystem";
      path = "$HOME/nextcloud/.contacts/";
    };

    remote = {
      type = "carddav";
      url = "https://220624z6bmfrl5nztze.nextcloud.hosting.zone/login";
      userName = "fabian.gubler@proton.me";
      passwordCommand = [
        "${pkgs.rbw}/bin/rbw"
        "get"
        "hosting"
      ];
    };
  };

}
