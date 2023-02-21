{

  programs.neomutt = {
    enable = true;
    sort = "reverse-date";
    vimKeys = true;
    sidebar = {
      width = 20;
      enable = true;
    };
    macros = [

    ];
    extraConfig = ''
		source ~/.config/mutt/variables| # pipe indicates executable
      mailboxes "=INBOX" "=Drafts" "=Spam" "=Trash" "=Sent" "=Archive"

                  		'';
    settings = {
      query_command = "khard email --parsable --search-in-source-files '%s'";
      from = "$my_mail";
      sendmail = "msmtp -a $my_mail";
      folder = "~/Mail";
      spoolfile = "+INBOX";
      postponed = "+Drafts";
      trash = "+Trash";
      record = "+Sent";
      # smtp_url = "smtp://$my_mail:$my_pass@localhost:1025";
      # smtp_authenticators = "gssapi:login";
    };
  };
}
