# NOTES:

# Create your own custom feed: 
# - Feedity (https://feedity.com/)
# - FetchRSS (https://fetchrss.com/)
# - FiveFilters' Feed Creator (https://createfeed.fivefilters.org/)

# Use a change detection service:
# - Visualping (https://visualping.io/)
# - Distill.io (https://distill.io/)
# - ChangeTower (https://changetower.com/)

let
  youtubeFeeds = import ./youtube.nix;
  blogFeeds = import ./blogs.nix;
  podcastFeeds = import ./podcasts.nix;
in
{

  programs.newsboat = {
    enable = true;

    urls = builtins.concatLists [ youtubeFeeds blogFeeds podcastFeeds ];

    autoReload = false;
    browser = "firefox";
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

  };
}

