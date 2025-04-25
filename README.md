## Local Build Environment 

I use a `just` wrapper around the official ZMK Devcontainer to build locally. Most of this was cribbed from [urob/zmk-config](https://github.com/urob/zmk-config) but I modified it to use the devcontainer rather than manange the entire stack like he does.

### Setup

Follow the [ZMK docs](https://zmk.dev/docs/development/local-toolchain/setup/container) and the "Dev Container CLI" option to set up the local environment. You will need to create Docker volume mounts for `zmk-config` and `zmk-modules` as is described in the ZMK docs. 

You will also need to clone any modules your config uses into the `zmk-modules` mount.

Make sure you have [devcontainers-cli](https://github.com/devcontainers/cli) and `brew install just python-yq`

Finally, the first line of the `justfile` must point to your local instance of the zmk repo.

### Building

The `justfile` will parse `build.yaml` and can build anything listed in there.

`just up` starts the container. `just list` will show everything available, and `just build {{slug}}` will build anything from `just list` that matches the given argument.

Examples:

* `just build cradio` will build firmwares for `cradio_dongle`, `cradio_left`, and `cradio_right`
* `just build cradio_dongle` will only build `cradio_dongle`