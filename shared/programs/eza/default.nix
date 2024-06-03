{
  programs.eza = {
    enable = true;

    # 'ls': Basic file listing
    # 'll': Detailed file listing
    # 'la': List all files, including hidden
    # 'lt': Display directory tree
    # 'lla': Detailed list, all files

    extraOptions = [
      "--group-directories-first"
    ];
  };
}
