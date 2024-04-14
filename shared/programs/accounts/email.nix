{ pkgs, ... }:

{
  programs = {
    neomutt.enable = true;
    mbsync.enable = true;
    notmuch.enable = true;
  };

  accounts.email = {
    accounts.fastmail = {
      address = "gubler@fastmail.com";
      imap = {
        host = "imap.fastmail.com";
        port = 993;
        tls.enable = true;
      };
      neomutt = {
        enable = true;
        extraMailboxes = [ "Archive" "Sent" "Spam" "Trash" ];
        extraConfig = ''
          bind index,pager B sidebar-toggle-visible     # B - Toggle Sidebar
          bind index,pager \CP sidebar-prev             # Ctrl-Shift-P - Previous Mailbox
          bind index,pager \CN sidebar-next             # Ctrl-Shift-N - Next Mailbox
          bind index,pager \CO sidebar-open             # Ctrl-Shift-O - Open Highlighted Mailbox
        '';
      };
      notmuch.enable = true;
      mbsync = {
        enable = true;
        create = "imap";
        expunge = "both";
        extraConfig.local = {
          Path = "~/Maildir/fastmail/";
          Inbox = "~/Maildir/fastmail/Inbox/";
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
      primary = true;
      realName = "Fabian Gubler";
      smtp = {
        host = "smtp.fastmail.com";
        port = 465;
        tls.enable = true;
      };
      flavor = "fastmail.com";
      passwordCommand = "${pkgs.rbw}/bin/rbw get fastmail_mutt";
    };
  };
}
