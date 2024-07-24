{ pkgs, config, lib, ... } :
let
  userFG = config.lib.stylix.colors.base07;
  userBG = config.lib.stylix.colors.base03;

  barBG = config.lib.stylix.colors.base02;

  pathFG = config.lib.stylix.colors.base0C;
  gitFG = config.lib.stylix.colors.base0B;
  langFG = config.lib.stylix.colors.base09;
  timeFG = config.lib.stylix.colors.base0D;

  separator = "[](bold fg:#${config.lib.stylix.colors.base03} bg:#${barBG})";
  language_style = "bold bg:#${barBG} fg:#${langFG}";
  language_format = "${separator}[ $symbol ($version) ]($style)";
in {
  programs.starship.enableZshIntegration = true;
  programs.starship.enable = true;
  programs.starship.settings = {
    format = lib.concatStrings [
      "[╭─](#${userBG})"
      "$os$username"
      "[](fg:#${userBG} bg:#${barBG})"
      "$directory"
      "$git_branch$git_status"
      "$c$golang$rust$python"
      "$docker_context"
      "$time"
      "[▓▒░ ](fg:#${userBG})\n"
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
      style = "bg:#${userBG}";
    };

    username = {
      show_always = true;
      style_user = "bg:#${userBG}";
      format = "[$user ](bold $style)";
      disabled = false;
    };

    directory = {
      style = "bg:#${barBG} fg:#${pathFG}";
    	format = "[ $path ](bold $style)";
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
      style = "fg:#${gitFG} bg:#${barBG}";
      symbol = "";
      format = "${separator}[ $symbol $branch ](bold $style)";
    };

    rust = {
      symbol = " ";
      style = language_style;
      format = language_format;
    };

    c = {
    	symbol = " ";
      style = language_style;
      format = language_format;
    };

    golang = {
      symbol = " ";
      style = language_style;
      format = language_format;
    };

    python = {
      symbol = " ";
      style = language_style;
      format = language_format;
    };

    time = {
      disabled = false;
      time_format = "%R"; # Hour:Minute Format
      format = "[](bold fg:#${barBG} bg:#${userBG})[  $time ](bold fg:#${timeFG} bg:#${userBG})";
    };

  };
}
