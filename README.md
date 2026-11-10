# dotfiles

My dotfiles

## How to setup

### Prerequisites

Install Xcode Command Line Tools:

```bash
xcode-select --install
```

### Install Nix

Install Nix using the [NixOS community installer](https://github.com/NixOS/nix-installer) (Flakes enabled by default):

```bash
curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install
```

> [!NOTE]
> This repository manages Nix with nix-darwin (`nix.enable = true`), so do not install Determinate Nix.

On a work machine behind TLS inspection, see [Work machine behind TLS inspection](#work-machine-behind-tls-inspection) instead.

### Clone this repository

```bash
git clone https://github.com/candy12t/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Customize host configuration

Hosts are defined in `hosts/default.nix`. The attribute name is the configuration name (`.#MacBookAir`, `.#work`):

```nix
# hosts/work.nix
rec {
  username = "takumi.kanada";  # result of: whoami
  system = "aarch64-darwin";   # "aarch64-darwin" for Apple Silicon, "x86_64-darwin" for Intel
  homeDir = "/Users/${username}";
  profile = "work";            # loads darwin/profiles/work.nix and home/profiles/work.nix
}
```

### Machine-local settings (not committed)

Values that must not be public (work email, org names, internal env vars, shell functions) go into local files.
Copy the templates in `examples/` and fill them in:

- `~/.zshrc.local` — sourced at the end of `.zshrc`
- `~/.config/git/local.gitconfig` — included at the end of the git config

### Work machine behind TLS inspection

The work profile trusts the Cato Networks root CA (`certs/`) via `security.pki`, which also passes the bundle to
the Nix daemon through `NIX_SSL_CERT_FILE`. Until the first switch, however, Nix does not know the CA, so bootstrap
a fresh work machine as follows (connected to Cato).

1. Check that MDM has installed the CA in the system keychain. If it is missing, install it first per company
   instructions; otherwise `curl` / `git` / Homebrew fail.

   ```bash
   security find-certificate -c "Cato Networks Root CA" /Library/Keychains/System.keychain
   ```

2. Install Xcode Command Line Tools, clone this repository, and check that `whoami` matches `username` in
   `hosts/work.nix`.

3. Install [Homebrew](https://brew.sh) (nix-darwin's homebrew module does not install Homebrew itself).

4. Install Nix with a CA bundle that includes the Cato CA. `--ssl-cert-file` replaces the default bundle, so
   combine it with the macOS bundle rather than passing the Cato CA alone.

   ```bash
   sudo mkdir -p /etc/nix
   sudo sh -c 'cat /etc/ssl/cert.pem ~/dotfiles/certs/CatoNetworksTrustedRootCA.pem > /etc/nix/bootstrap-ca.pem'
   curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --ssl-cert-file /etc/nix/bootstrap-ca.pem
   ```

   Open a new shell and check that `nix run nixpkgs#hello` works.

5. Run the first switch:

   ```bash
   cd ~/dotfiles
   sudo nix run nix-darwin -- switch --flake .#work
   ```

   If it aborts with "Unexpected files in /etc" (e.g. `/etc/nix/nix.conf` written by the installer), rename them to
   `*.before-nix-darwin` as instructed and run it again.

6. After the switch, the daemon uses `/etc/ssl/certs/ca-certificates.crt` (which includes the Cato CA), so remove
   the bootstrap bundle:

   ```bash
   sudo rm /etc/nix/bootstrap-ca.pem
   ```

7. Create the [machine-local settings](#machine-local-settings-not-committed), register an SSH key with GitHub,
   and restart the shell.


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
