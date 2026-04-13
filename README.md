# dotfiles

My dotfiles

## How to setup

### Prerequisites

Install Xcode Command Line Tools:

```bash
xcode-select --install
```

### Install Nix

Install Nix using the [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer) (Flakes enabled by default):

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Clone this repository

```bash
git clone https://github.com/candy12t/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Customize host configuration

Edit `hosts/default.nix` to match your machine:

```nix
{
  hostname = "MacBookAir";     # result of: scutil --get LocalHostName
  username = "candy12t";       # result of: whoami
  system = "aarch64-darwin";   # "aarch64-darwin" for Apple Silicon, "x86_64-darwin" for Intel
  homeDir = "/Users/candy12t"; # result of: echo $HOME
}
```


### Apply configuration

On first run (when nix-darwin is not yet installed):

```bash
nix run nix-darwin -- switch --flake .#MacBookAir
```

After nix-darwin is installed:

```bash
darwin-rebuild switch --flake .#MacBookAir
```

Restart your shell after the first setup.

## Commands

### Update

Update all flake inputs (updates `flake.lock`):

```bash
nix flake update
```

Update a specific input only (e.g. `llm-agents`):

```bash
nix flake update llm-agents
```

### Build

Build without applying to the system:

```bash
darwin-rebuild build --flake .#MacBookAir
```
