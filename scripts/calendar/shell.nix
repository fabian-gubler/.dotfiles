{ pkgs ? import <nixpkgs> {} }:

pkgs.python3.withPackages(ps: with ps; [ arrow icalendar ])
