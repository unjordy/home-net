# home-net

This is the complete set of tools and configurations I use to reproducibly
deploy a set of [NixOS](https://nixos.org/nixos/) via
[krops](https://cgit.krebsco.de/krops/about/) on my home network. A Nix
evaluator (package manager) is required to make use of this repo, and
[lorri](https://github.com/nix-community/lorri) is highly recommended to make
using these tools feel more natural.
[sops-nix](https://github.com/Mic92/sops-nix) is used to manage various secrets.

The hosts included in this repo are:

- `fb`, a general-purpose server connected to a 3D printer. Hosts Octoprint.
- `car`, a [ROCK64](https://www.pine64.org/devices/single-board-computers/rock64/) embedded ARM board wired directly into the downstairs thermostat. Hosts an [Infinitive](https://github.com/acd/infinitive) server to allow HVAC control via wifi.
- `cadr`, a [ROCK64](https://www.pine64.org/devices/single-board-computers/rock64/) embedded ARM board wired directly into the upstairs thermostat. Identical to `car` in every way but hostname.

Each host can be deployed via the command `deploy-<hostname>`. All hosts can be deployed at the same time with `deploy-all`.
