{
  programs = {
    msmtp.enable = true;
    mbsync.enable = true;
  };

  accounts.email.accounts = {
    protonmail = {
      imap = {
        host = "127.0.0.1";
        port = 1143;
      };
      primary = true;
      userName = "fabian.gubler@protonmail.com";
      passwordCommand = "rbw get bridge";
      mbsync = {
        enable = true;
        create = "imap";
        expunge = "both";
        extraConfig.account = {
          Host = "127.0.0.1";
          Port = "1143";
          PassCmd = "rbw get bridge";
          SSLType = "STARTTLS";
          CertificateFile = "~/.config/protonmail/bridge/cert.pem";
        };
        extraConfig.local = {
          Path = "~/.mail/";
          Inbox = "~/.mail/INBOX/";
        };
        extraConfig.remote = {
          Account = "protonmail";
        };
        groups.protonmail.channels = {
          inbox.extraConfig = {
            Far = ":protonmail-remote:";
            Near = ":protonmail-local:";
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
