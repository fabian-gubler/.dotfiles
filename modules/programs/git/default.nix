{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = "fabian.gubler@protonmail.com";
    userName = "Fabian Gubler";
    extraConfig = {
      core = {
        editor = "nvim";
      };
      color = {
        ui = true;
      };
      pull = {
        ff = "only";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

}
