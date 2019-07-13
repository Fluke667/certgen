#!/bin/sh

set -eu
mkdir -p /etc/ssh/keys


            # Neuen RSA-Key erzeugen - Achtung, dieser ändert sich mit jedem neuen Container
            ssh-keygen -f $SSH_PRIV_KEY_RSA -N '' -t rsa > /dev/null 2>&1
            echo "***** PLEASE SET SSH_PRIV_KEY_RSA VARIABLE TO: *****"
            cat /etc/ssh/keys/ssh_host_rsa_key
            echo "*****************************************************"
            chown root.root /etc/ssh/keys/ssh_host_rsa_key
            chmod 600 /etc/ssh/keys/ssh_host_rsa_key

            # Neuen DSA-Key erzeugen - Achtung, dieser ändert sich mit jedem neuen Container
            ssh-keygen -f /etc/ssh/keys/ssh_host_dsa_key -N '' -t dsa > /dev/null 2>&1
            echo "***** PLEASE SET SSH_PRIV_KEY_DSA VARIABLE TO: *****"
            cat /etc/ssh/keys/ssh_host_dsa_key
            echo "*****************************************************"
            chown root.root /etc/ssh/keys/ssh_host_dsa_key
            chmod 600 /etc/ssh/keys/ssh_host_dsa_key

            # Neuen ED25519-Key erzeugen - Achtung, dieser ändert sich mit jedem neuen Container
            ssh-keygen -f /etc/ssh/keys/ssh_host_ed25519_key -N '' -t ed25519 > /dev/null 2>&1
            echo "***** PLEASE SET SSH_PRIV_KEY_ED25519 VARIABLE TO: *****"
            cat /etc/ssh/keys/ssh_host_ed25519_key
            echo "*********************************************************"

            chown root.root /etc/ssh/keys/ssh_host_ed25519_key
            chmod 600 /etc/ssh/keys/ssh_host_ed25519_key


            # Neuen ECDSA-Key erzeugen - Achtung, dieser ändert sich mit jedem neuen Container
            ssh-keygen -f /etc/ssh/keys/ssh_host_ecdsa_key -N '' -t ecdsa > /dev/null 2>&1
            echo "***** PLEASE SET SSH_PRIV_KEY_ECDSA VARIABLE TO: *****"
            cat /etc/ssh/keys/ssh_host_ecdsa_key
            echo "*****************************************************"

            chown root.root /etc/ssh/keys/ssh_host_ecdsa_key
            chmod 600 /etc/ssh/keys/ssh_host_ecdsa_key

ssh-keygen -N "$SSH_ROOT_PASSWORD"
mkdir -p /etc/ssh/keys/authorized_keys
# Add Public Keys to root account
if [ -n "$SSH_KEYS_ROOT_CRT" ]; then
		echo "$SSH_KEYS_ROOT_CRT" > /etc/ssh/keys/authorized_keys/root
fi

#prepare run dir
if [ ! -d "/var/run/sshd" ]; then
	mkdir -p /var/run/sshd
fi

exec "$@"
