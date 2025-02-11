{ config
, pkgs
, ...
}:
let
  color = config.lib.stylix.colors;
in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    settings = [
      {
        layer = "top";
        position = "top";
        exclusive = true;
        fixed-center = true;
        gtk-layer-shell = true;
        spacing = 0;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = [
          "image"
          "hyprland/workspaces"
          "idle_inhibitor"
          "hyprland/window"
        ];
        modules-right = [
          "group/network-modules"
          "group/wireplumber-modules"
          "group/backlight-modules"
          "group/battery-modules"
          "tray"
          "clock"
          "group/powermenu"
        ];

        "image" = {
          path = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          size = 24;
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "{id}";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };

        "hyprland/window" = {
          format = "{title}";
          icon = true;
          icon-size = 24;
          separate-outputs = true;
        };

        "group/network-modules" = {
          modules = [
            "network#icon"
            "network#address"
          ];
          orientation = "inherit";
        };
        "network#icon" = {
          format-disconnected = "󰤮 ";
          format-ethernet = "󰈀 ";
          format-wifi = "󰤨 ";
          tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-ethernet = "Ethernet: {ifname}\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };
        "network#address" = {
          format-disconnected = "Disconnected";
          format-ethernet = "{ipaddr}/{cidr}";
          format-wifi = "{essid}";
          tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-ethernet = "Ethernet: {ifname}\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
          tooltip-format-disconnected = "Disconnected";
        };

        "group/wireplumber-modules" = {
          modules = [
            "wireplumber#icon"
            "wireplumber#volume"
          ];
          orientation = "inherit";
        };
        "wireplumber#icon" = {
          format = "{icon}";
          format-muted = "󰖁";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle &> /dev/null";
          on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 1%+ &> /dev/null";
          on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 1%- &> /dev/null";
          tooltip-format = "Volume: {volume}%";
        };
        "wireplumber#volume" = {
          format = "{volume}%";
          tooltip-format = "Volume: {volume}%";
        };

        "group/backlight-modules" = {
          modules = [
            "backlight#icon"
            "backlight#percent"
          ];
          orientation = "inherit";
        };
        "backlight#icon" = {
          format = "{icon}";
          format-icons = [
            "󰃞 "
            "󰃟 "
            "󰃠 "
          ];
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 1%+ &> /dev/null";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 1%- &> /dev/null";
          on-click-right = "${pkgs.systemd}/bin/systemctl is-active hyprsunset --user --quiet && ${pkgs.systemd}/bin/systemctl --user stop hyprsunset --quiet || ${pkgs.systemd}/bin/systemctl --user start hyprsunset";
          tooltip-format = "Backlight: {percent}%";
        };
        "backlight#percent" = {
          format = "{percent}%";
          tooltip-format = "Backlight: {percent}%";
        };

        "group/battery-modules" = {
          modules = [
            "battery#icon"
            "battery#capacity"
          ];
          orientation = "inherit";
        };
        "battery#icon" = {
          format = "{icon}";
          format-charging = "󱐋";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format-plugged = "󰚥";
          states = {
            warning = 30;
            critical = 15;
          };
          tooltip-format = "{timeTo}, {capacity}%";
        };
        "battery#capacity" = {
          format = "{capacity}%";
          tooltip-format = "{timeTo}, {capacity}%";
        };

        tray = {
          icon-size = 24;
          spacing = 10;
          show-passive-items = true;
        };

        clock = {
          actions = {
            on-scroll-down = "shift_down";
            on-scroll-up = "shift_up";
          };
          calendar = {
            format = {
              days = "<span color='#${color.base03}'><b>{}</b></span>";
              months = "<span color='#${color.base07}'><b>{}</b></span>";
              today = "<span color='#${color.base07}'><b><u>{}</u></b></span>";
              weekdays = "<span color='#${color.base0B}'><b>{}</b></span>";
            };
            mode = "month";
            on-scroll = 1;
          };
          format = " {:%a, %b %d %R} ";
          format-alt = " {:%Y/%m/%d %R} ";
          tooltip-format = "{calendar}";
        };

        "group/powermenu" = {
          drawer = {
            children-class = "powermenu-child";
            transition-duration = 300;
            transition-left-to-right = false;
          };
          modules = [
            "custom/power"
            "custom/lock"
            "custom/suspend"
            "custom/exit"
            "custom/reboot"
          ];
          orientation = "inherit";
        };
        "custom/power" = {
          format = "󰐥";
          on-click = "${pkgs.systemd}/bin/systemctl poweroff";
          tooltip = false;
        };
        "custom/lock" = {
          format = "󰌾";
          on-click = "${pkgs.systemd}/bin/loginctl lock-session";
          tooltip = false;
        };
        "custom/suspend" = {
          format = "󰤄";
          on-click = "${pkgs.systemd}/bin/systemctl suspend";
          tooltip = false;
        };
        "custom/exit" = {
          format = "󰍃";
          on-click = "${pkgs.systemd}/bin/loginctl terminate-user $USER";
          tooltip = false;
        };
        "custom/reboot" = {
          format = "󰜉";
          on-click = "${pkgs.systemd}/bin/systemctl reboot";
          tooltip = false;
        };
      }
    ];

    style = ''
      /* Global */
      * {
        all: unset;
        font-family: "Inconsolata Nerd Font", sans-serif;
        font-size: 11pt;
        font-weight: 500;
      }

      /* Menu */
      menu {
        background: #${color.base00};
        border-radius: 12px;
      }

      menu separator {
        background: #${color.base02};
      }

      menu menuitem {
        background: transparent;
        padding: 0.5rem;
        transition: 300ms linear;
      }

      menu menuitem:hover {
        background: lighter(#${color.base02});
      }

      menu menuitem:first-child {
        border-radius: 12px 12px 0 0;
      }

      menu menuitem:last-child {
        border-radius: 0 0 12px 12px;
      }

      menu menuitem:only-child {
        border-radius: 12px;
      }

      /* Tooltip */
      tooltip {
        background: #${color.base00};
        border-radius: 12px;
      }

      tooltip label {
        margin: 0.5rem;
      }

      /* Waybar */
      window#waybar {
        background: #${color.base00};
      }

      .modules-left {
        padding-left: 0.25rem;
      }

      .modules-right {
        padding-right: 0.25rem;
      }

      /* Modules */
      #workspaces,
      #workspaces button,
      #idle_inhibitor,
      #network-modules,
      #wireplumber-modules,
      #backlight-modules,
      #battery-modules,
      #tray,
      #clock,
      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        background: #${color.base02};
        border-radius: 8px;
        margin: 0.5rem 0.25rem;
        transition: 300ms linear;
      }

      #image,
      #window,
      #network.address,
      #wireplumber.volume,
      #backlight.percent,
      #battery.capacity,
      #tray,
      #clock {
        padding: 0.25rem 0.75rem;
      }

      #idle_inhibitor,
      #network.icon,
      #wireplumber.icon,
      #backlight.icon,
      #battery.icon,
      #custom-exit,
      #custom-lock,
      #custom-suspend,
      #custom-reboot,
      #custom-power {
        background: #${color.base0B};
        color: #${color.base02};
        border-radius: 8px;
        font-size: 13pt;
        padding: 0.25rem;
        min-width: 1.5rem;
        transition: 300ms linear;
      }

      /* Workspaces */
      #workspaces button {
        margin: 0;
        padding: 0.25rem;
        min-width: 1.5rem;
      }

      #workspaces button label {
        color: #${color.base07};
      }

      #workspaces button.empty label {
        color: #${color.base03};
      }

      #workspaces button.urgent label,
      #workspaces button.active label {
        color: #${color.base02};
      }

      #workspaces button.urgent {
        background: #${color.base07};
      }

      #workspaces button.active {
        background: #${color.base0B};
      }

      /* Idle Inhibitor */
      #idle_inhibitor {
        background: #${color.base02};
        color: #${color.base0B};
      }

      #idle_inhibitor.deactivated {
        color: #${color.base03};
      }

      /* Systray */
      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background: #${color.base07};
      }

      /* Hover effects */
      #workspaces button:hover,
      #idle_inhibitor:hover,
      #idle_inhibitor.deactivated:hover,
      #clock:hover {
        background: lighter(#${color.base02});
      }

      #workspaces button.urgent:hover {
        background: lighter(#${color.base07});
      }

      #workspaces button.active:hover,
      #network.icon:hover,
      #wireplumber.icon:hover,
      #custom-exit:hover,
      #custom-lock:hover,
      #custom-suspend:hover,
      #custom-reboot:hover,
      #custom-power:hover {
        background: lighter(#${color.base0B});
      }

      #workspaces button.urgent:hover label,
      #workspaces button.active:hover label,
      #network.icon:hover label,
      #wireplumber.icon:hover label,
      #custom-exit:hover label,
      #custom-lock:hover label,
      #custom-suspend:hover label,
      #custom-reboot:hover label,
      #custom-power:hover label {
        color: lighter(#${color.base02});
      }

      #workspaces button:hover label {
        color: lighter(#${color.base0A});
      }

      #workspaces button.empty:hover label {
        color: lighter(#${color.base03});
      }

      #idle_inhibitor:hover {
        color: lighter(#${color.base0B});
      }

      #idle_inhibitor.deactivated:hover {
        color: lighter(#${color.base03});
      }
    '';
  };
}

