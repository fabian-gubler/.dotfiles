# NOTES:

# Create your own custom feed: 
# - Feedity (https://feedity.com/)
# - FetchRSS (https://fetchrss.com/)
# - FiveFilters' Feed Creator (https://createfeed.fivefilters.org/)

# Use a change detection service:
# - Visualping (https://visualping.io/)
# - Distill.io (https://distill.io/)
# - ChangeTower (https://changetower.com/)

{ config, pkgs, lib, ... }:
let
  ytUrl = "https://yewtu.be/feed/channel";
in
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

			cache-file /data/nextcloud/apps/newsboat/cache.db
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

      # Get channel_id -> Search Channel on Insidious 

      {
        # The Primeagen
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UC8ENHE5xdFSwx71u3fDH5Xw";
      }
      {
        # Good Work
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UC_-hYjoNe4PJNFa9iZ4lraA";
      }
      {
        # Coffeezilla
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UCFQMnBA3CS502aghlcr0_aw";
      }
      {
        # Aleksa Gordic
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UCj8shE7aIn4Yawwbo2FceCQ";
      }
      {
        # TJ Devries
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UCd3dNckv1Za2coSaHGHl5aA";
      }
      {
        # Wolfgangs Channel
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UCsnGwSIHyoYN0kiINAGUKxg";
      }
      {
        # Luke Smith
        tags = [ "youtube" "!" ];
        url = "${ytUrl}/UC2eYFnH61tmytImy1mTYvhA";
      }
      {
        # Ben Vallack
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UC4NNPgQ9sOkBjw6GlkgCylg";
      }
      {
        # Fireship
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UCsBjURrPoezykLs9EqgamOA";
      }
      {
        # Kurzgesagt
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UCsXVk37bltHxD1rDPwtNM8Q";
      }
      {
        # Cold Fusion
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UC4QZ_LsYcvcq7qOsOhpAX4A";
      }
      {
        # Lemmino
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UCRcgy6GzDeccI7dkbbBna3Q";
      }
      {
        # Storytellers
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UCbphDfwSJmxk1Ny_3Oicrng";
      }
      {
        # EmpLemon
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UC7Ucs42FZy3uYzjrqzOIHsw";
      }
      {
        # Big Boss
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UCYGDiVemmhY_Q1M-hKp4fvw";
      }
      {
        # Internet Historian
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UCR1D15p_vdP3HkrH8wgjQRw";
      }
      {
        # Incognito Mode
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UC8Q7XEy86Q7T-3kNpNjYgwA";
      }
      {
        # PewDiePie
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UC-lHJZR3Gqxm24_Vd_AJ5Yw";
      }
      {
        # Channel 5
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UC-AQKm7HUNMmxjdS371MSwg";
      }
      {
        # Chriminal Psychology
        tags = [ "!" "youtube" ];
        url = "${ytUrl}/UCYwVxWpjeKFWwu8TML-Te9A";
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
		  title = "Podcast: Luke Smith";
		  url = "https://notrelated.xyz/rss";
	  }
      {
        title = "Podcast: Andrew Huberman";
        url = "${ytUrl}/UC2D2CMWXMOVWx7giW1n3LIg";
      }
      {
        title = "Podcast: Naval Ravikant";
        url = "${ytUrl}/UCh_dVD10YuSghle8g6yjePg";
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
      {
        title = "Blog: Simon Späti";
        url = "https://sspaeti.com/index.xml";
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

