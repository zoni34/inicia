#!/bin/bash

apt install -y gnupg software-properties-common curl git awscli mosquitto-clients jq rt5-clients pipx msmtp msmtp-mta mailutils libaio1 unzip ksh vim wget doas
useradd -m -s /bin/bash zoni
curl -fsSL https://apt.releases.hashicorp.com/gpg |  gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" |  tee /etc/apt/sources.list.d/hashicorp.list
apt update
apt install -y terraform

install -d -o zoni -g zoni /home/zoni/terraform
install -d -o zoni -g zoni /home/zoni/.cert

echo -n | openssl s_client -connect rt.ral.tirea.es:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > rt_cert.pem
mv rt_cert.pem /usr/local/share/ca-certificates/rt_cert.crt
update-ca-certificates

#cat << 'EOF' > /etc/doas.conf
#permit nopass zoni as root
#EOF
#chmod 600 /etc/doas.conf
#chown root:root /etc/doas.conf

echo "Hecho. Reinicia o cierra sesión para aplicar completamente. y configura rt /etc/request-tracker5/rt.conf aws y git clone git@github.com:zoni34/enciende.git y terraform output api_key_value"
