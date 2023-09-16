# Foundry

Recomendamos primerariamente a seguir a própria documentação.

[Clique Aqui](https://foundryvtt.wiki/en/setup/linux-installation)

1. Primeiro crie a VM com base em uma das configurações de servidor como recomendamos na doc de server.
2. Crie o user `foundry` e depois instale o `node`, `pm2`, `candy` e `wget`.
3. Depois crie um pasta para `foundryVtt` e baixa o repositório do mesmo.
```bash
mkdir ~/foundry
wget --output-document ~/foundry/foundryvtt.zip "<download url>"
```
4. Adicionando usuário:
```bash
mkdir -p ~/foundryuserdata
```
5. Agora rode o node para teste, lembre-se de `<user>`.
```bash
cd ~
node foundry/resources/app/main.js --dataPath=/home/<user>/foundryuserdata
```
6. Após verificar que está tudo certo, incio o mesmo pm2 usando este comando:
```bash
pm2 start "node /home/<user>/foundry/resources/app/main.js --dataPath=/home/<user>/foundryuserdata" --name foundry
pm2 save
pm2 list
```
7. Agora vamos editar o candy(usado para proxy reverso), edite o arquivo:
```bash
sudo vim /etc/caddy/Caddyfile
```
Agora se o arquivo:
```bash
# This replaces the existing content in /etc/caddy/Caddyfile

# A CONFIG SECTION FOR YOUR IP AND HOSTNAME

{
    default_sni your.internal.ip.address
}

your.internal.ip.address {
    # PROXY ALL REQUEST TO PORT 30000
    tls internal
    reverse_proxy localhost:30000
    encode zstd gzip
}

your.hostname.com {
    # PROXY ALL REQUEST TO PORT 30000
    reverse_proxy localhost:30000
    encode zstd gzip
}

# Refer to the Caddy docs for more information:
# https://caddyserver.com/docs/caddyfile
```
8. Rode os comandos, para reiniciar o serviço:
```bash
sudo service caddy restart
```
9. Agora vamos editar o arquivo de configuração do foundry:
```bash
vim ~/foundryuserdata/Config/options.json
```
edite o mesmo:
```json
...
"proxyPort": 443,
...
"proxySSL": true,
...
"hostname": "<your.domain.name>",
...
```
10. Agora reiniciei o serviço do foundry
```bash
pm2 restart foundry
```