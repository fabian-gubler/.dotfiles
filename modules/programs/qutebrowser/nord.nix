{ pkgs, config, inputs, ... }: {
  programs.qutebrowser.settings.colors = {
    completion = {
      fg = "#d8dee9";
      odd.bg = "#3b4252";
      even.bg = "#3b4252";
      category.fg = "#e5e9f0";
      category.bg = "#2e3440";
      category.border.top = "#2e3440";
      category.border.bottom = "#2e3440";
      item.selected.fg = "#eceff4";
      item.selected.bg = "#4c566a";
      item.selected.border.top = "#4c566a";
      item.selected.border.bottom = "#4c566a";
      match.fg = "#ebcb8b";
      scrollbar.fg = "#e5e9f0";
      scrollbar.bg = "#3b4252";
    };

    downloads = {
      bar.bg = "#2e3440";
      stop.bg = "#b48ead";
      system.bg = "none";
      error.fg = "#e5e9f0";
      error.bg = "#bf616a";
    };

    hints = {
      fg = "#E5E9F0";
      bg = "#2B5790";
      match.fg = "#EBCB8B";
    };

    keyhint = {
      fg = "#e5e9f0";
      suffix.fg = "#ebcb8b";
      bg = "#3b4252";
    };

    messages = {
      error.fg = "#e5e9f0";
      error.bg = "#bf616a";
      error.border = "#bf616a";
      warning.fg = "#e5e9f0";
      warning.bg = "#d08770";
      warning.border = "#d08770";
      info.fg = "#e5e9f0";
      info.bg = "#3b4252";
      info.border = "#3b4252";
    };

    prompts = {
      fg = "#e5e9f0";
      border = "1px solid #2e3440";
      bg = "#434c5e";
      selected.bg = "#4c566a";
    };

    statusbar = {
      normal.fg = "#e5e9f0";
      normal.bg = "#2e3440";
      insert.fg = "#3b4252";
      insert.bg = "#a3be8c";
      passthrough.fg = "#e5e9f0";
      passthrough.bg = "#5e81ac";
      private.fg = "#e5e9f0";
      private.bg = "#4c566a";
      command.fg = "#e5e9f0";
      command.bg = "#434c5e";
      command.private.fg = "#e5e9f0";
      command.private.bg = "#434c5e";
      caret.fg = "#e5e9f0";
      caret.bg = "#b48ead";
      caret.selection.fg = "#e5e9f0";
      caret.selection.bg = "#b48ead";
      progress.bg = "#e5e9f0";
      url.fg = "#e5e9f0";
      url.error.fg = "#bf616a";
      url.hover.fg = "#88c0d0";
      url.success.http.fg = "#e5e9f0";
      url.success.https.fg = "#a3be8c";
      url.warn.fg = "#d08770";
    };

    tabs = {
      bar.bg = "#4c566a";
      indicator.error = "#bf616a";
      indicator.system = "none";
      odd.fg = "#e5e9f0";
      odd.bg = "#4c566a";
      even.fg = "#e5e9f0";
      even.bg = "#4c566a";
      selected.odd.fg = "#e5e9f0";
      pinned.even.bg = "#4c566a";
      pinned.odd.bg = "#4c566a";
      selected.odd.bg = "#2e3440";
      selected.even.fg = "#e5e9f0";
      selected.even.bg = "#2e3440";
    };
  };
}
