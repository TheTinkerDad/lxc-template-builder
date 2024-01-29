# lxc-template-builder
A set of helper scripts / config files that can be used to build LXC container templates with HashiCorp Packer.

For some reason this whole subject is not really documented, but here are the bits and pieces I collected and served as base of this repository:
 - https://github.com/hashicorp/packer-plugin-lxc - This is the original plugin for Packer - Sadly the documentation is vague and dated. 
 - https://github.com/hashicorp/packer-plugin-lxc/tree/main/docs - This is what supposed to be the "how to" - The examples mentioned won't even work on their own.
 - https://github.com/hashicorp/packer-plugin-lxc/issues/7 - This is a bug that prevents normal usage - the generated .tar.gz files won't be usable with Proxmox / LXC without a workaround. It hasn't been fixed since 2021 even though the plugin had releases since then.

So how does this repository help?
 - It contains a sample config file that actually works (Yes, I'm building a lot of different Minecraft servers using LXC, don't judge me! :) )
 - It has a nice wrapper script that helps kicking off the build.
 - The wrapper script has the workaround for the above mentioned bug, generating .tar.gz templates that actually work.
 - I've also added a script that installs the necessary dependencies.

Added optional extras:
 - The install_with_extras.sh script installs a simple web server along with Packer, the LXC builder, etc. so you can plug the whole thing in a container or VM and have it serve the generated .tar.gz files as URLs for you, which can be directly used in Proxmox, like doing this:
![image](https://github.com/TheTinkerDad/lxc-template-builder/assets/6706631/b12471c7-a09d-468d-956a-d3904bb6d492)

and then this:

![image](https://github.com/TheTinkerDad/lxc-template-builder/assets/6706631/a1f8a608-096b-4841-904a-b293e1135597)

