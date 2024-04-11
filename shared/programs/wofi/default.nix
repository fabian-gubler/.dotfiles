{
    programs.wofi = {
      enable = true;
      settings = {
        show = "drun";
        columns = 1;
        width = "50%";
        no_action = true;
        allow_images = true;
        ensensitive = true;
        image_size = 40;
      };
      style = ''
        @define-color background rgba(28, 32, 35, 0.60);
        @define-color foreground rgb(220, 220, 220);
        @define-color outline rgba(255, 255, 255, 0.15);
        @define-color accent rgba(0, 85, 119, 1.0);
        @define-color textbox rgba(255, 255, 255, 0.05);
        @define-color highlight rgba(0, 85, 119, 0.6);

        * {
            all:unset;
        }

        window {
            background-color: @background;
            /* border-radius: 10px; */
            /* border: 1px solid @outline; */
            font-family: Terminess Nerd Font;
            font-weight: 200;
        }

        #outer-box {
            /* padding: 2em; */
        }

        #input {
            padding:0.5em .5em;
            /* margin: 0em .25em; */
            font-size:1.2em;
            background-color: @background;
            border: 1px solid transparent;
            box-shadow: inset 0 -.15rem @accent;
            transition: background-color .30s ease-in-out;
        }

        #input image {
            margin-right:-1em;
            color:transparent;
        }

        #input:focus {
            background:@background;
            border: 1px solid @outline;
        }

        #scroll {
            margin-top: 0.5em;
        }

        #entry {
            border: 1px solid transparent;
            padding:.25em;
            margin: .25rem;
            font-weight: normal;
            box-shadow: inset 0rem 0px rgba(0, 0, 0, 0);
            transition: box-shadow .30s ease-in-out, background-color .30s ease-in-out;
        }

        #entry image {
            margin-right: .5em;
        }

        #entry:selected {
            background-color: @highlight;
            border: 1px solid @highlight;
            box-shadow: inset .2rem 0px @accent;
        }

      '';
    };
}
