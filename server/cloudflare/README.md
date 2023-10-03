# Dynamic DNS
## Como configurar DNS Dinamico com Cloudflare
Fizemos um API justamente para esta finalidade pode verificar mais sobre ela [aqui](https://github.com/Greens-Organization/rockhopper-dynamicdns).
Mas caso queria algo mais simples pode seguir o passos abaixos.

## Configurar shell script para alterar o DNS
Crie um arquivo com este conteudo abaixo para realizar o processo de mudança, lembre-se de alterar as credenciais para sua credenciais.
_Arquivo:_ `change-dns.sh`
```sh
#!/bin/bash

# Sua chave de API Cloudflare
CLOUDFLARE_API_KEY=""

# O ID da Zona Cloudflare (pode ser obtido através da API da Cloudflare)
ZONE_ID=""

# O ID do registro DNS que você deseja atualizar
RECORD_ID=""

# Seu e-mail associado à conta da Cloudflare
CLOUDFLARE_EMAIL=""

# Obtém o IP público atual
IP=$(curl -s http://ipinfo.io/ip)

# Atualiza o registro DNS
curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
     -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"example.com","content":"'"$IP"'","ttl":1,"proxied":false}'

```

### Configurando no crontab
Basta acessar as configurações do contab com este comando:
```bash
crontab  -e
```
E adicionar está linha ao arquivo cron:
```sh
0 * * * * /home/matheus/.myscripts/change-dns.sh
```

## Doc da API do Cloudflare:
https://developers.cloudflare.com/api/operations/dns-records-for-a-zone-update-dns-record


