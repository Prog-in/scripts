#!/bin/bash

NFS_DIR="/var/nfs_dir"
HOSTFILE_PATH="$NFS_DIR/hostfile.txt"
INSTANCE_IP=$(ip addr show | grep -Eo 'inet (([0-9]{1,3}\.){3}[0-9]{1,3})' | grep -vE '127\.0\.0\.1|172\.[1-9]\.|10\.[0-9]\.|192\.168\.' | awk '{print $2}')

# Verifica se o arquivo existe localmente, se não, cria
if [ ! -f "$NFS_DIR/hostfile_local.txt" ]; then
    echo "$INSTANCE_IP" > "$NFS_DIR/hostfile_local.txt"
fi

# Acrescenta o endereço IP ao arquivo no compartilhamento NFS
echo "$INSTANCE_IP" | sudo tee -a "$HOSTFILE_PATH" > /dev/null
