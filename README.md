# lxc-template-builder
A set of helper scripts / config files that can be used to build LXC container templates with HashiCorp Packer.

## Why did I make this?
For some reason this whole subject is not really documented, but here are the bits and pieces I collected and served as base of this repository:
 - https://github.com/hashicorp/packer-plugin-lxc - This is the original plugin for Packer - Sadly the documentation is vague and dated. 
 - https://github.com/hashicorp/packer-plugin-lxc/tree/main/docs - This is what supposed to be the "how to" - The examples mentioned won't even work on their own.
 - https://github.com/hashicorp/packer-plugin-lxc/issues/7 - This is a bug that prevents normal usage - the generated .tar.gz files won't be usable with Proxmox / LXC without a workaround. It hasn't been fixed since 2021 even though the plugin had releases since then.
 - https://developer.hashicorp.com/packer/integrations/hashicorp/lxc/latest/components/builder/lxc - Configuration parameters for the LXC builder. These should be used within the Packer configuration file (see examples/lxc-template-minecraft-java/build.pkr.hcl)

## So how does this repository help?
 - It contains a sample config file that actually works (Yes, I'm building a lot of different Minecraft servers using LXC, don't judge me! :) )
 - It has a nice wrapper script that helps kicking off the build.
 - The wrapper script has the workaround for the above mentioned bug, generating .tar.gz templates that actually work.
 - I've also added a script that installs the necessary dependencies.

### Added optional extras:
 - The install_with_extras.sh script installs a simple web server along with Packer, the LXC builder, etc. so you can plug the whole thing in a container or VM and have it serve the generated .tar.gz files as URLs for you, which can be directly used in Proxmox, like doing this:
![image](https://github.com/TheTinkerDad/lxc-template-builder/assets/6706631/b12471c7-a09d-468d-956a-d3904bb6d492)

and then this:

![image](https://github.com/TheTinkerDad/lxc-template-builder/assets/6706631/a1f8a608-096b-4841-904a-b293e1135597)

## Ok, how do I use this?
- Start a VM or an LXC container with at least 2 gigs of RAM (or more if you want to build some heavy containers, more later on this)
- Within the VM/container clone the Github repo
- Start `./install.sh` or `install_with_extras.sh` (currently these runs properly on Ubuntu/Debian only, but I'm planning to support other distros too) which will install the dependencies and in case of the latter, optional extras too.
- Check out the examples folder to see an example Packer config file, LXC config file and provisioning script. Try to build it with
  ```./build-container.sh examples/lxc-template-minecraft-java```
- If everything works well, it'll create a folder named lxc-template-minecraft-java-<date-and-time> in the current folder containing the .tar.gz file you need.
- To create your own config, copy the whole lxc-template-minecraft-java folder with another name (e.g. my-lxc-template), modify the provisioning script under the scripts folder according to what you want to install/configure in your template and the two config files if needed.
