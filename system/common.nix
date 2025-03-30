{ inputs, pkgs, username, ... }: {
  users.users."${username}" = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keyFiles = [ inputs.github-keys.outPath ];
  };

  security.sudo.extraRules = [
    {
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
      users = [ username ];
    }
  ];
}
