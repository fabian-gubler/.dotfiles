{ nixosConfig
, lib
, ...
}: {
  programs.firefox.profiles.default.bookmarks = [

    {
      name = "ChatGPT";
      url = "https://chat.openai.com/?model=gpt-4";
    }
  ];
}
