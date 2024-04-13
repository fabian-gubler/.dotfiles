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
            source $HOME/.dotfiles/shared/programs/mail/files/variables| # pipe indicates executable
      	  mailboxes "=INBOX" "=Drafts" "=Spam" "=Trash" "=Sent" "=Archive"

                            		'';
    settings = {
      query_command = "khard email --parsable --search-in-source-files '%s'";
      from = "$my_mail";
      sendmail = "msmtp -a $my_mail";
      folder = "~/Maildir";
      spoolfile = "+INBOX";
      smtp_url = "smtp://$my_mail:$my_pass@localhost:1025";
      smtp_pass = "this";
      smtp_authenticators = "gssapi:login";
    };
  };
}
