#!/bin/bash

NFS_DIR="/var/nfs_dir"
HOSTFILE_PATH="$NFS_DIR/hostfile.txt"
INSTANCE_IP=$(hostname -I | awk '{print $1}')

# Verifica se o arquivo existe localmente, se não, cria
if [ ! -f "$HOSTFILE_PATH" ]; then
    echo "$INSTANCE_IP" > "$HOSTFILE_PATH"
fi

# Acrescenta o endereço IP ao arquivo no compartilhamento NFS
echo "$INSTANCE_IP" | sudo tee -a "$HOSTFILE_PATH" > /dev/null
