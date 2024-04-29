{ config, lib, pkgs, ... }:
{
  programs.git = {
    enable = true;

    userName  = "salverius-tech";
    userEmail = "salverius-tech@users.noreply.github.com";

    aliases = {
      ci      = "commit -m";
      co      = "checkout";
      s       = "status -s";
      cb      = "checkout -b";
      ca      = "!git add -A . && git status -s && git commit -m";
      br      = "branch";
      unstage = "reset .";
      db      = "!git branch -D $1 && git push --delete origin $1";
      dlb     = "!git branch -D $1";
      drb     = "!git remote prune origin && git push --delete origin  $1";
      aa      = "!git add -A . && git status -s";
      pushall = "!git push --all; git push --tags";
      ct      = "!git checkout -b $1 && git push --set-upstream origin $1";
      ls      = "!git --no-pager log -10 --date=short --pretty='%C(yellow)%h%Creset - %C(yellow)%an%Creset %C(white)%ad%Creset%C(yellow)%d%Creset %Cgreen%s%Creset'";
      ll      = "!git log --date=short --pretty='%C(yellow)%h%Creset - %C(yellow)%an%Creset %C(white)%ad%Creset%C(yellow)%d%Creset %Cgreen%s%Creset'";
      lg      = "log --graph --abbrev-commit --date=relative --pretty='%C(yellow)%h%Creset - %C(yellow)%an%Creset%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset'";
      lf      = "show --pretty=\"format:\" --name-only";
      wtf     = "reflog";
      rs      = "remote show origin";
    };

    extraConfig = {
      branch = {
        autoSetupRebase = always;
      };
      color = {
        ui = "auto";
      };
      core = {
        excludesfile = "~/.gitignore_global";
      };
      diff = {
        tool = "vimdiff";
        mnemonicprefix = true;
      };
      fetch = {
        prune = true;
      };
      include = {
        path = "~/.gitconfig.local";
      };
      merge = {
        tool = "splice";
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      rerere = {
        enabled = true;
      };

  };
}

[credential]
	helper = "!f() { /home/anvil/.vscode-server/bin/b7886d7461186a5eac768481578c1d7ca80e2d21/node /tmp/vscode-remote-containers-94558b03-c51d-42f9-84e0-6a417caaddc6.js git-credential-helper $*; }; f"
