#!/bin/bash

nix-store --gc
nix-collect-garbage --delete old
rm -rf ~/.cache/nix
