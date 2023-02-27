{ config, pkgs, lib, ... }:
{

  programs.newsboat = {
    enable = true;
    autoReload = false;
    browser = "qutebrowser";
    maxItems = 1000;
    reloadThreads = 8;
    reloadTime = 2;

    extraConfig = ''
            	macro	  m		  set browser "setsid -f mpv --really-quiet --no-terminal" ; open-in-browser ; set browser pipe
            	unbind-key  RIGHT
            	unbind-key  LEFT
            	bind-key  RIGHT	  	open
            	bind-key  ENTER		open-in-browser 
            	bind-key  LEFT		quit

            	color     listnormal            white   default   dim
            	color     listnormal_unread     white   default 
            	color     listfocus             white   color67 
            	color     listfocus_unread      white   color67 
            	color     info                  white   color236

            	show-keymap-hint    no
            	show-title-bar      yes
            	show-read-feeds     yes
            	keep-articles-days  180
            	show-read-articles  no

      		datetime-format     "%d %B"
      		feedlist-format     "  %t %?d?- %-65d&? %> %U Available"
      		articlelist-format  "%?T?  %-30T ?%-70t %> %D "
    '';

    queries = {
      "Youtube Subscriptions" = "tags # \"youtube\"";
    };

    urls = [

      # Note: Feeds are fetched in order

      # Integrate Twitter or Reddit?
      # ML Accounts to follow: https://www.reddit.com/r/MachineLearning/comments/9kkoyb/d_some_of_the_best_ml_accounts_to_follow_on/

      # Potential:
      # https://jeremykun.com/feed/ # Math, ML, Programming
      # http://www.offconvex.org/feed.xml

      # Also check out: https://neptune.ai/blog/the-best-regularly-updated-machine-learning-blogs-or-resources

      ###################
      # YOUTUBE CHANNELS
      ###################

      # Ways to channel_id:
      # - Search Channel on Insidious 
      # - Google Channel (see link)

      {
        # The Primeagen
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC8ENHE5xdFSwx71u3fDH5Xw";
      }
      {
        # Aleksa Gordic
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCj8shE7aIn4Yawwbo2FceCQ";
      }
      {
        # TJ Devries
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCd3dNckv1Za2coSaHGHl5aA";
      }
      {
        # Wolfgangs Channel
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCsnGwSIHyoYN0kiINAGUKxg";
      }
      {
        # Luke Smith
        tags = [ "youtube" "!" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA";
      }
      {
        # Ben Vallack
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC4NNPgQ9sOkBjw6GlkgCylg";
      }
      {
        # Fireship
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCsBjURrPoezykLs9EqgamOA";
      }
      {
        # Kurzgesagt
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCsXVk37bltHxD1rDPwtNM8Q";
      }
      {
        # Cold Fusion
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC4QZ_LsYcvcq7qOsOhpAX4A";
      }
      {
        # Lemmino
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCRcgy6GzDeccI7dkbbBna3Q";
      }
      {
        # Storytellers
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCbphDfwSJmxk1Ny_3Oicrng";
      }
      {
        # EmpLemon
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC7Ucs42FZy3uYzjrqzOIHsw";
      }
      {
        # Big Boss
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCYGDiVemmhY_Q1M-hKp4fvw";
      }
      {
        # Internet Historian
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCR1D15p_vdP3HkrH8wgjQRw";
      }
      {
        # Incognito Mode
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC8Q7XEy86Q7T-3kNpNjYgwA";
      }
      {
        # PewDiePie
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC-lHJZR3Gqxm24_Vd_AJ5Yw";
      }
      {
        # Channel 5
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC-AQKm7HUNMmxjdS371MSwg";
      }
      {
        # Chriminal Psychology
        tags = [ "!" "youtube" ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCYwVxWpjeKFWwu8TML-Te9A";
      }

      ###################
      # PODCASTS
      ###################
      {
        title = "Podcast: Darknet Diaries";
        url = "https://feeds.megaphone.fm/darknetdiaries";
      }
      {
        title = "Podcast: Lex Fridman";
        url = "https://lexfridman.com/feed/podcast/";
      }
      {
        title = "Podcast: Andrew Huberman";
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC2D2CMWXMOVWx7giW1n3LIg";
      }
      {
        title = "Podcast: Naval Ravikant";
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCh_dVD10YuSghle8g6yjePg";
      }

      ###################
      # BLOGS
      ###################

      {
        title = "Blog: Drew DeVault";
        url = "https://drewdevault.com/blog/index.xml";
      }
      {
        title = "Blog: Luke Smith";
        url = "https://lukesmith.xyz/rss.xml";
      }
      {
        title = "Blog: Alexandru Burlacu";
        url = "https://alexandruburlacu.github.io/feed.xml";
      }
      {
        title = "Blog: Blub's Blog";
        url = "https://blubsblog.bearblog.dev/feed";
      }

      # Naval recommendations
      {
        title = "Blog: Melting Asphal";
        url = "https://meltingasphalt.com/feed";
      }
      {
        title = "Blog: Elad";
        url = "https://blog.eladgil.com/feed";
      }

    ];
  };
}

