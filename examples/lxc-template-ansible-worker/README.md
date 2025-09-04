
# About this example...

This is a little bit different - it creates a very generic container template ready to be used as an Ansible worker host.

What it does is the following:

 - installs SSHD
 - sets up a user within the container so Ansible don't have to log in as root
 - enables public key based auth for the given user and adds it as a sudoer

Yes, pretty much that's it. It will create a fairly small template. After you've built your template and used it to launch
an LXC container, you can use Ansible to run stuff on it, like provision services, etc.
