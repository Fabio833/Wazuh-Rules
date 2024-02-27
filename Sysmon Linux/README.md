#Github : https://github.com/Sysinternals/SysmonForLinux
#Install: https://github.com/Sysinternals/SysmonForLinux/blob/main/INSTALL.md

#instalação 
- Copiar o script para o servidor que vai ser instalador
- executar o comando 
    chmod +x install_sysmonforlinux.sh
- executar o script de instalação 
    ./install_sysmonforlinux.sh
- Validar instalação 
    sudo tail -f /var/log/syslog ou tail -f /var/log/syslog | sudo /opt/sysmon/sysmonLogView
- baixar arquivo de configuração na pasta /opt/sysmon/config.xml
- executar o comando de acordo com a regra baixada
    sysmon -c <nome.xml>
    
Problemas encontrados:

- arquivo de log /var/log/syslog não existe
    Executar o comando para reinstalar o componente de log do linux apt-get install --reinstall rsyslog