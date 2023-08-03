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
    fastmail = {
      address = "gubler@fastmail.com";
      maildir = { path = "~/mail/"; };
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
      thunderbird.enable = true;
      mbsync = {
        enable = true;
        create = "imap";
        expunge = "both";
        extraConfig.local = {
          Path = "~/mail/";
          Inbox = "~/mail/INBOX/";
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
