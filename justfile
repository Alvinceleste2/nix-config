# Default recipe to display help information
[private]
default:
  just --list

# Update commonly changing flakes and prep for a build
[private]
rebuild-pre:
  git add --intent-to-add .
  echo "rebuild-pre"

# Run post-build checks
[private]
rebuild-post:
  echo "rebuild-post"

# Rebuild specified host
rebuild HOST=`hostname`: rebuild-pre && rebuild-post
  sudo nixos-rebuild switch --flake .#{{ HOST }}

# Run a flake check on the config
check HOST=`hostname` ARGS="":
    NIXPKGS_ALLOW_UNFREE=1 REPO_PATH=$(pwd) nix flake check \
        --impure \
        --keep-going \
        --show-trace \
        {{ ARGS }}

# Update all flake inputs
update:
  nix flake update

# Show git differences ignoring the flake.lock file
diff:
  git diff ':!flake.lock'
