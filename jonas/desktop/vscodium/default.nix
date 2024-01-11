{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    package = pkgs.vscodium;

    userSettings = {
      files = {
        trimFinalNewlines = true;
        insertFinalNewline = true;
        trimTrailingWhitespace = true;
      };

      workbench = {
        startupEditor = "None";
      };

      editor = {
        mouseWheelZoom = true;
        formatOnSave = true;
      };

      extensions = {
        autoCheckUpdates = false;
        autoUpdate = false;
      };

      telemetry.telemetryLevel = "off";
      redhat.telemetry.enabled = false;
      gitlens.telemetry.enabled = false;

      "[yaml]".editor.defaultFormatter = "redhat.vscode-yaml";

      vim = {
        enableNeovim = true;
        useSystemClipboard = true;
        neovimPath = "${pkgs.neovim}/bin/nvim";
        ignorecase = true;
        hlsearch = true;
        useCtrlKeys = false;
      };

      terraform.languageServer.path = "${pkgs.terraform-ls}/bin/terraform-ls";
      "[terraform]" = {
        editor = {
          defaultFormatter = "hashicorp.terraform";
          formatOnSave = false;
          codeActionsOnSave = {
            "source.formatAll.terraform" = true;
          };
        };
      };

      ansible = {
        ansible.path = "${pkgs.ansible}/bin/ansible";
        python.interpreterPath = "${pkgs.python3}/bin";
      };
    };

    keybindings = with builtins; fromJSON (
      readFile ./keybindings.json
    );

    mutableExtensionsDir = false;

    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace (
      builtins.fromJSON (
        builtins.readFile ./extensions.json
      )
    );
  };
}
