{ pkgs, config, ... }:
# TODO: Mail directory creation
let
  # TODO: Make pure (remove hardcoding)
  bridgePass = "${config.home.homeDirectory}/.dotfiles/modules/programs/mail/files/get-pass.sh";
in

{
  programs = {
    msmtp.enable = true;
    mbsync.enable = true;
  };

  accounts.email.accounts = {
    protonmail = {
      address = "fabian.gubler@protonmail.com";
      maildir = { path = "~/Mail/"; };
      folders = {
        inbox = "INBOX";
        drafts = "Drafts";
        sent = "Sent";
        trash = "Trash";

      };
      # neomutt = {
      #   enable = true;
      #   mailboxName = "INBOX";
      # };
      # smtp = {
      #   host = "smtp://fabian.gubler@protonmail.com:${bridgePass}";
      #   port = 1025;
      # };
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
          Path = "~/Mail/";
          Inbox = "~/Mail/INBOX/";
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
