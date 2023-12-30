{ pkgs, ... }: {

  programs.lf = {
    enable = true;
    settings = {
      relativenumber = true;
      hidden = true;
      preview = false;
      ratios = "1";
      shell = "sh";
      shellopts = "-eu";
      ifs = "\n";
    };
    commands = {
      drag = "%dragon $fx";
      trash = "%trash-put $fx";
      aj = '' %lf -remote "send $id cd '$(autojump $1)'" '';
      zip = '' %zip -r "$f" "$f" '';
      tar = '' %tar cvf "$f.tar" "$f" '';
      open = ''
                ''${{
                  case $(file --mime-type "$(readlink -f $f)" -b) in
                    text/*) $EDITOR $fx;;
        			video/*) nohup mpv $fx &;;
                    *) for f in $fx; do xdg-open $f > /dev/null 2> /dev/null & done;;
                  esac
                }}
      '';
      extract = ''
         ''${{
            set -f
            case $f in
                *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar xjvf $f;;
                *.tar.gz|*.tgz) tar xzvf $f;;
                *.tar.xz|*.txz) tar xJvf $f;;
                *.tar.zst) tar --use-compress-program=unzstd -xvf $f;;
                *.zip) unzip $f;;
                *.rar) unrar x $f;;
                *.7z) 7z x $f;;

            esac
        }}
      '';
      fzf_jump = ''
        ''${{
            res="$(find . -maxdepth 1 | fzf --header='Jump to location' | sed 's/\\/\\\\/g;s/"/\\"/g')"
            if [ -d "$res" ]; then
                cmd="cd"
            else 
                cmd="select"
            fi
            lf -remote "send $id $cmd \"$res\""
        }}
      '';
    };
    keybindings = {
      "f" = ":fzf_jump";
      "j" = "push :aj<space>";
      "<enter>" = "open";
    };
  };
}
