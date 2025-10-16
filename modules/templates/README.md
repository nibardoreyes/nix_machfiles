# Nix Project Template
## Setup
1. Copy the template `flake.nix` into your project folder.
2. Enter the development environment:

```bash
nix develop --command $SHELL #enter developer environemnt
nix flake update #update packages added or removed
nix develop --refresh #refresh after update
exit # exit developer environment
```
