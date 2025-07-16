#!/bin/bash

if [ -z "$1" ]; then
  echo "Uso: $0 nuevo_nombre_host"
  exit 1
fi

NUEVO_HOST="$1"

echo "Cambiando nombre de host a: $NUEVO_HOST"

# Cambiar con hostnamectl
hostnamectl set-hostname "$NUEVO_HOST"

# Actualizar /etc/hosts (línea 127.0.1.1)
sed -i "s/^127\.0\.1\.1\s\+.*/127.0.1.1\t$NUEVO_HOST/" /etc/hosts


apt install -y gnupg software-properties-common curl git awscli mosquitto-clients jq
curl -fsSL https://apt.releases.hashicorp.com/gpg |  gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" |  tee /etc/apt/sources.list.d/hashicorp.list
apt update
apt install -y terraform

install -d -o zoni -g zoni /home/zoni/terraform
install -d -o zoni -g zoni /home/zoni/.cert

echo "Hecho. Reinicia o cierra sesión para aplicar completamente."

