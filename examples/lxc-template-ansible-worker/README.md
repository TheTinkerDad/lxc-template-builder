
# About this example...

This is a little bit different - it creates a very generic container template ready to be used as an Ansible worker host.

What it does is the following:

 - installs SSHD
 - sets up a user within the container so Ansible don't have to log in as root
 - enables public key based auth for the given user and adds it as a sudoer

How to use?

Besides the normal usage (see the main README.md file), you'll need an SSH public key and private key pair. Ansible will use
the private key to log in and the public key will be added to the container template. I know, I know, but... it's only a public 
key and the container template will be yours and yours only unless you decide to share it with someone or the general public.

Assumming you'll want to try to test playbook provided under the *test* folder, you'll need to create and save your key the
below way:

 - To add the public key, put it into the ssh_keys folder inside a file named *ansible-key.pub* before building the container template.
 - Build the container template
 - Pull up a container using the freshly built template
 - Your private key should be in a file named ~/.ssh/ansible-key on the host you'll be running Ansible from
 - Now you can run the test playbook, e.g. *ansible-playbook -i inventory test-playbook.yml*

Yes, pretty much that's it. It will create a fairly small template. After you've built your template and used it to launch
an LXC container, you can use Ansible to run stuff on it, like provision services, etc.
