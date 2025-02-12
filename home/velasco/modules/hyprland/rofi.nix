{ lib, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    cycle = true;

    xoffset = 10;
    extraConfig = {
      show-icons = true;
    };

    plugins = with pkgs; [ rofi-calc rofi-emoji rofi-systemd ];

    theme = {
      "configuration" = {
        modi = "drun,run,window";
        show-icons = true;
        display-drun = " ";
        display-run = " ";
        display-filebrowser = " ";
        display-window = " ";
        drun-display-format = "{name}";
        window-format = "{w} · {c} · {t}";
      };

      "window" = {
        enabled = true;
        transparency = "real";
        location = "center";
        anchor = "center";
        fulscreen = false;
        width = 400;
        x-offset = 0;
        y-offset = 0;
        border-radius = 20;
        cursor = "default";
      };

      "mainbox" = {
        enabled = true;
        spacing = 0;
        orientation = "vertical";
        children = [ "inputbar" "listbox" ];
      };

      "filebrowser" = {
        enabled = true;
        directories-first = true;
        sortinng-method = "name";
      };

      "listbox" = {
        enabled = true;
        spacing = 20;
        padding = 20;
        orientation = "vertical";
        children = [ "message" "listview" "mode-switcher" ];
      };

      "inputbar" = {
        enabled = true;
        spacing = 10;
        padding = [ 100 40 ];
        background-color = "transparent";
        background-image = "url(~/Nixos/home/velasco/wallpaper.jpeg, width)";
        orientation = "horizontal";
        children = [ "textbox-prompt-colon" "entry" ];
      };

      "textbox-prompt-colon" = {
        enabled = true;
        expand = false;
        str = " ";
        padding = [ 12 15 ];
        border-radius = "100%";
      };

      "entry" = {
        enabled = true;
        expand = true;
        padding = [ 12 15 ];
        border-radius = "100%";
        cursor = "text";
        placeholder = "Search";
      };

      "mode-switcher" = {
        enabled = true;
        spacing = 10;
      };

      "button" = {
        padding = 12;
        border-radius = "100%";
        cursor = "pointer";
      };

      "listview" = {
        enabled = true;
        columns = 1;
        lines = 5;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;

        spacing = 10;
        cursor = "default";
      };

      "element" = {
        enabled = true;
        spacing = 10;
        padding = 12;
        border-radius = "100%";
        cursor = "pointer";
      };

      "element-icon" = {
        size = 32;
        cursor = "inherit";
      };

      "textbox" = {
        padding = 12;
        border-radius = "100%";
      };

      "error-message" = {
        padding = 15;
        border-radius = 0;
      };
    };
  };
}
