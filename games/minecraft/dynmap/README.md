# Dynmap Configuração

## Instalando e configurando o NGINX

Primeiro instale o NGINX:

```bash
sudo apt install nginx
```

Se tudo correu tudo bem durante a instação, vamos agora executar alguns comandos que mostra na wiki do dynmap:

**Para mais informações consulte a [wiki do dynmap](https://github.com/webbukkit/dynmap/wiki/%5BTutorial%5D-Setting-up-a-standalone-web-server-with-MySQL-SQLite/#general-setup-with-the-nginx-web-server)**

1. `sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/dynmap`

2. `sudo rm /etc/nginx/sites-enabled/default`

3. `sudo service nginx restart`

Agora vamos precisar alterar o arquivo de configuração do NGINX conforme mostra a wiki do dynmap.
Primeiro vamos abrir o arquivo:

```bash
sudo vi /etc/nginx/sites-available/dynmap
```

OBS: O nosso arquivo de configuração do nginx já utilizando o SSL com o certbot configurado. Dito isso, adicione o seguinte

```nginx
server {
    # Domain name
    server_name hostname.grngroup.net;

    # SSL configuration
		listen 8443 ssl http2;
		listen [::]:8443 ssl http2;
    ssl_certificate "/etc/letsencrypt/live/hostname.grngroup.net/fullchain.pem";
    ssl_certificate_key "/etc/letsencrypt/live/hostname.grngroup.net/privkey.pem";

    # Root directory and logs
    root /path/to/dynmap/;
    index index.html;
    access_log /var/log/nginx/hostname.grngroup.net-access_log;
    error_log /var/log/nginx/hostname.grngroup.net-error_log;

    # Location blocks
    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_index index.php;
        fastcgi_pass unix:/var/run/php/php7.x-fpm.sock; # Garanta substituir 7.x com a versão atual do seu PHP.
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include /etc/nginx/fastcgi_params;
    }
}

# Optional block for port 20054
server {
    listen 20054 default_server;
    listen [::]:20054 default_server;
    server_name hostname.grngroup.net;
    return 404;
}
```

Depois execute este comando para criar atalho para o `sites-enables`:

```bash
ln -s /etc/nginx/sites-available/dynmap /etc/nginx/sites-enabled/dynmap
```

Depois este, e verifique se consta algum erro:

```bash
sudo nginx -t
```

Lembre-se de alterar o caminho do web do dynmap `root /home/someuser/minecraft/servers/creative/plugins/dynmap/web;` para caminho aonda está salvo seu dynmap/web. E também alterar o dominio `map.seudominio.com` para o seu.

/home/canary/dynmap

Agora reinicie o NGINX:

```bash
sudo service nginx restart
```

Tente acessar o ip e porta escolhida no seu navegador:
`http://192.168.0.100`
Possivelmente, ainda não funcionou.

Vamos agora para possiveis solução.

Consulte o log de erro primeiramente:

```bash
sudo cat /var/log/nginx/error.log
```

### Erro de permissão

Execute este comando, alterando o `path` pelo caminho da pasta onde está o web do dynmap.
Para saber o `path` da pasta, acesse a pasta e digite:

```bash
pwd
```

Vai retornar o caminho, substiua no comando abaixo:

```bash
sudo chown -R :www-data path
```

### Erro com [PHP FPM](https://www.php.net/manual/pt_BR/install.fpm.php)

Não sei exatamente o que é isto, porém é necessário para rodar o dynmap web.
Verifique se existe o mesmo instalado no seu servidor, caso não tenha instale usando este comando:

```
sudo apt-get install php7.4-fpm
```

**Lembres de alterar a versão 7.4 para versão que aparece no seu log de erro**

### Erro com [MySql](https://www.php.net/manual/pt_BR/book.mysqli.php)

Este erro pelas minhas pesquisa é pela falta do programa que faz a conexão com banco MySql e o PHP, para isso execute o comando a seguir:

```bash
sudo apt-get install php7.4-mysqli
```

**Lembres de alterar a versão 7.4 para versão que aparece no seu log de erro**

### Erro com PORTA de conexão [UFW Firewall]()

Normalmente é devido que NGINX está funcionando na porta 443 ou 80, que é padrão, para funcionar basta habilitar a porta desejada:

```bash
sudo ufw allow 20054/tcp
```

Caso o `ufw` não esteja habilitado no seu servidor para verificar execute:

```bash
sudo ufw status
```

Caso o retorno for inative pode ativar o mesmo utilizando:

```bash
sudo ufw sites-enabled
```

**ATENÇÃO: Pode ser sua conexão SSH cai, pois é necessário habilitar a mesma novamente com o comando abaixo e também habilitar demais outras portas que estava utilizando no servidor.**

**Lembre-se de desativar as portas padrão do NGINX**
Liste todos as portas do `ufw`:

```bash
sudo ufw status numbered
```

Depois de localizazr as portas com comentário `Nginx` e desativar a mesma:

```bash
sudo ufw delete id
```

Altera o `id` do comando acima pela porta do Nginx aberta, rode primeiramente para HTTP e depois para HTTPS, e depois verifique se as portas foram fechadas.

```bash
sudo ufw status
```
