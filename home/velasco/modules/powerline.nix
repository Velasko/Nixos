{ pkgs, config, lib, ... }:
let
  termBG = config.lib.stylix.colors.base00;
  userBG = config.lib.stylix.colors.base03;
  barBG = config.lib.stylix.colors.base02;

  userFG = config.lib.stylix.colors.base0B;
  pathFG = config.lib.stylix.colors.base0C;
  gitFG = config.lib.stylix.colors.base0B;
  gitStatusFG = config.lib.stylix.colors.base08;
  langFG = config.lib.stylix.colors.base09;
  jobsFG = config.lib.stylix.colors.base0A;
  timeFG = config.lib.stylix.colors.base0B;

  separator = "[](bold fg:#${config.lib.stylix.colors.base03} bg:#${barBG})";
  language_style = "bold bg:#${barBG} fg:#${langFG}";
  language_format = "${separator}[ $symbol ($version) ]($style)";
in
{
  programs.starship.enableZshIntegration = true;
  programs.starship.enable = true;
  programs.starship.settings = {
    format = lib.concatStrings [
      "[╭─](#${userBG})"
      "$os$username"
      "[](fg:#${userBG} bg:#${barBG})"
      "$directory"
      "$git_branch$git_status"
      "$c$golang$rust$python$helm"
      "$docker_context$kubernetes"
      "$jobs"
      "[▓▒░ ](fg:#${barBG})"
      "$fill"
      "$time"
      "[ ](fg:#${userBG} bg:#${termBG})\n"
      "[╰─ ](fg:#${userBG})"
    ];

    # right_format = "$time";

    character = {
      success_symbol = " [󱞩](bold green)";
      error_symbol = " [󱞩](bold red)";
    };

    os = {
      disabled = false;
      symbols.NixOS = "  ";
      style = "fg:#${userFG} bg:#${userBG}";
    };

    username = {
      show_always = true;
      style_user = "bold fg:#${userFG} bg:#${userBG}";
      format = "[$user ]($style)";
      disabled = false;
    };

    directory = {
      style = "bold bg:#${barBG} fg:#${pathFG}";
      format = "[ $path ]($style)";
      truncation_length = 3;
      # truncation_symbol = "…/";
      substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
      };
    };

    docker_context = {
      symbol = " ";
      format = "${separator}[ $symbol $context ]($style)";
    };

    git_branch = {
      style = "bold fg:#${gitFG} bg:#${barBG}";
      symbol = "";
      format = "${separator}[ $symbol $branch]($style)";
    };

    git_status = {
      ahead = "⇡\${count}";
      diverged = "⇕ ⇡ \${ahead_count} ⇣ \${behind_count}";
      behind = "⇣ \${count}";
      up_to_date = "✓ ";
      style = "bold fg:#${gitStatusFG} bg:#${barBG}";
      format = "[ $all_status$ahead_behind ]($style)";
    };

    rust = {
      symbol = "󱘗";
      style = language_style;
      format = language_format;
    };

    c = {
      symbol = "";
      style = language_style;
      format = language_format;
    };

    golang = {
      symbol = "󰟓 ";
      style = language_style;
      format = language_format;
    };

    python = {
      symbol = "󰌠";
      style = language_style;
      format = language_format;
    };

    helm = {
      style = language_style;
      format = language_format;
    };

    jobs = {
      symbol = "✦";
      style = "fg:#${jobsFG} bg:#${barBG}";
      format = "${separator}[ $symbol $number ]($style)";
    };

    time = {
      disabled = false;
      time_format = "%R"; # Hour:Minute Format
      format = "[](bold fg:#${termBG} bg:#${userBG})[  $time ](bold fg:#${timeFG} bg:#${userBG})";
    };

  };
}
