# How to start
## Consolidated advice from multiple reddit posts:
(1) NixOS in a VM. (2) Make your custom config, 
	but don't use flakes since you're a beginner. 
	For learning the nix language, (3) use the tour of nix to learn the language.

Forget about flakes, overlays, home-manager for now. 
	Just set up a normal configuration.nix, and you're good to go. 
	You will eventually want overlays and stuff later on, so you learn about them afterwards. 
	My recommendation for now is to learn a bit of the nix language using the tour of nix 
	(get it by installing nix-tour or access https://nixcloud.io/tour), 
	until part 22 at most. Also chapter 5 of the nix manual https://nixos.org/manual/nix/stable/expressions/writing-nix-expressions.html

# Learning Path (Next steps)
## Learn Language
- [Why Functional Programming Language](https://blog.stimsina.com/post/functional-programming-is-the-future)
- [Zero to Nix](https://zero-to-nix.com/)
- [Nix Tour](https://nixcloud.io/tour/?id=1) // until part 22 at most
- [Nix Language Manual](https://nixos.org/manual/nix/stable/language/index.html#nix-language) // Chapter 5
- [Nix Language Commentary Video](https://yewtu.be/watch?v=cyPdh6gu2sw)
- [Nix Language Basics](https://nixos.org/guides/nix-language.html)

## Learn Nix Concepts + Setup Personal Config
Matthias
[3 hour Setup Guide](https://yewtu.be/watch?v=AGVXJ-TIv3Y)

Configurations
- [Matthias + Written Setup Guide](https://github.com/MatthiasBenaets/nixos-config)
- [reddit](https://github.com/rofrol/nixos-config)
- [swiss dude](https://github.com/infinisil/system)

Nix: Getting Started 
- [Nix Wiki](https://nixos.wiki/wiki/Main_Page)
- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [Nix Beginner Guide](https://tonyfinn.com/blog/nix-from-first-principles-flake-edition/)
- [Nix Opinionated Guide](https://nix.dev/)
- [Awesome Nix - Curated List](https://github.com/nix-community/awesome-nix)

NixOS
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Guide on Github](https://github.com/mikeroyal/NixOS-Guide#getting-started)

## Aside: Contributions (Personal Goals)
### Personal Packaging
Builds (based on priority): 
- typora (legacy 0.9.98 exists in NUR sepo)
- pdf-stapler,
- harsh
- zsa-wally (depends on udev-rules)
- fahrplan
- san francisco font

Overlays / Nix Files:
- spotify: share folder writeable
- rbw: configure email & lock_timeout configuration options

Package debugging:
- sioyek blur (hardware, dependency issue?)

### Personal Services
serivce.dunst {
	enable = true;
	dimensions = X:Y;
	font = "String";
	frame = "3";
	background = "String";
	foreground = "String";
};

# Additional Resources
General Guides
- [Nix Ecosystem](https://nixos.wiki/wiki/Nix_Ecosystem)
- [Why Nix](https://revelry.co/insights/development/nix-time/)
- [Nix Flakes](https://xeiaso.net/blog/nix-flakes-1-2022-02-21)
- [Deterministic](https://www.bekk.christmas/post/2021/13/deterministic-systems-with-nix)

Philosophy
- [I was wrong about nix](https://xeiaso.net/blog/i-was-wrong-about-nix-2020-02-10)
- [NixOS Sales Pitch](https://yewtu.be/watch?v=2L2qHfNnXB4)
- [The Curse of NixOS](https://blog.wesleyac.com/posts/the-curse-of-nixos)

Data Science
- [Workgroup](https://nixos.wiki/wiki/Workgroup:DataScience)

Misc
- Nix Foundation Youtube Channel [Channel](https://yewtu.be/channel/UC3vIimi9q4AT8EgxYp_dWIw)

# Community Links
- [Discourse](http://discourse.nixos.org/)
- Check out NixOS Subreddit
