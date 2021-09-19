{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    elixir
    cmake
  ];

  MIX_ENV = "dev";
}
