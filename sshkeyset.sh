#!/bin/bash
if [ ! -d "~/.ssh" ]; then
  mkdir ~/.ssh
fi
#change this to your sshkey
echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChhxYKROMK4+QujOPIrzTnqOQqHfgIMiyQJ6PevvDSr7HwhWIm0mmPDJmo6p4XIYJavvfd/Si3AUrnxWY02rTI7XKzd0R6UWDasPhCxnvMD1fHUkM8p5caKUSvPz559pCoxXOyIPv7jkJKCMKttZ5dXP2HAxnZHO8wz0YzayWkh1KQy4+oxVZEcv0l5LB5Z2VmXEpKSAaiow5nMdt+MSNjOgapSaq98v/T7b4eFr3f4ZK9YyvnNrGNCcDcxGKAHqxgYZF5uVxg3CRpTbPQ5+UoaaKzGQwC1Z7o5iPcw4StFdcvr3yKbB3U/AFk75Obuv9O/vVaKnAHZJzGGFOIFLvf >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
if [ ! -f "~/.ssh/authorized_keys" ]; then
  sudo systemctl restart sshd
  echo 'All done'
fi
