# install Suricata

# Step 1 – Install Required Dependencies
add-apt-repository ppa:oisf/suricata-stable
apt-get update

# Step 2 – Install Suricata

# get last version
apt-get install suricata -y

# Step 3 – Configure Suricata

# download rules
cd /tmp/ && curl -LO https://rules.emergingthreats.net/open/suricata-6.0.8/emerging.rules.tar.gz
sudo tar -xvzf emerging.rules.tar.gz && sudo mv rules/*.rules /etc/suricata/rules/
sudo chmod 640 /etc/suricata/rules/*.rules

# update rules

apt install -y python3-pip
pip install --upgrade suricata-update
suricata-update

# configurar interface o nome da interface
ifconfig | ip a

Procure os campos abaixo no arquivo /etc/suricata/suricata.yaml e altere 

      HOME_NET: "<UBUNTU_IP>"
      EXTERNAL_NET: "any"

      default-rule-path: /etc/suricata/rules
      rule-files:
      - "*.rules"

      # Global stats configuration
      stats:
      enabled: no

      # Linux high speed capture support
      af-packet:
        - interface: INTERFACE 

systemctl restart suricata

#  Testar configuração

suricata -T -c /etc/suricata/suricata.yaml -v

suricata -c /etc/suricata/suricata.yaml -i interface

# validar funcionamento

tail -f /var/log/suricata.log
tail -f /var/log/suricata/fast.log
