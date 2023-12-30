{

# TODO: Mail directory creation

  programs = {
    msmtp.enable = true;
    mbsync.enable = true;
    notmuch = {
      enable = true;
    };
  };

  accounts.email.accounts = {
    fastmail = {
      address = "gubler@fastmail.com";
      notmuch.enable = true;
      maildir = { path = "~/mail/"; };
      realName = "Gubler";
      primary = true;
      folders = {
        inbox = "INBOX";
        drafts = "Drafts";
        sent = "Sent";
        trash = "Trash";
      };
      userName = "gubler@fastmail.com";
      passwordCommand = "rbw get fastmail_mutt";
      imap = {
        host = "imap.fastmail.com";
        port = 993;
      };
      astroid = {
        enable = true;
        sendMailCommand = "msmtpq --read-envelope-from --read-recipients";
        # extraConfig = {
        #   astroid.notmuch.db = "~/mail";
        # };
      };
      thunderbird = {
        enable = true;
        # perIdentitySettings = id: {
        #   "mail.identity.id_${id}.protectSubject" = false;
        # };
      };
      mbsync = {
        enable = true;
        create = "imap";
        expunge = "both";
        extraConfig.local = {
          Path = "~/Maildir/";
          Inbox = "~/Maildir/INBOX/";
        };
        groups.fastmail.channels = {
          inbox.extraConfig = {
            Far = ":fastmail-remote:";
            Near = ":fastmail-local:";
            Patterns = "*";
            Create = "Both";
            Expunge = "Both";
            SyncState = "*";
          };
        };
      };
    };
  };
}
