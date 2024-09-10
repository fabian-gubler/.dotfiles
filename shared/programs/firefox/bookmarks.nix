{
  programs.firefox.profiles.default.bookmarks = [
    {
      name = "ChatGPT";
      url = "https://chat.openai.com/?model=gpt-4o";
    }
    {
      name = "Pipedrive";
      url = "https://fabiangubler.pipedrive.com";
    }
    {
      name = "Portal Azure";
      url = "https://portal.azure.com/#home";
    }
    {
      name = "Digital Nomad";
      toolbar = true;
      bookmarks = [
        {
          name = "Nomad List";
          url = "https://nomadlist.com";
        }
        {
          name = "Venture Cost";
          url = "https://venturecost.com/";
        }
      ];
    }
  ];
}
