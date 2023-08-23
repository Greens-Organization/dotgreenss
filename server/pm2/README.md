# PM2

## Instalação

Primeiro vamos instalar o pm2, para isso use o comando:

```
npm install pm2 -g
```

Para verificar se foi instalado corretamente, podemos usar o comando:

```
pm2 --version
```

Se tiver retornado a versão corretamente, vamos configurar pm2 para iniciar
junto com sistema, para isso use o comando:

```
pm2 startup
```

Deve retornar uma mensagem, que é um comando basta executar o mesmo. No caso meu
caso retornou este comando abaxo, caso opite por usa-lo alterar "user" pelo nome
do seu usário:

```
sudo env PATH=$PATH:/home/user/.asdf/installs/nodejs/20.5.1/bin /home/user/.asdf/installs/nodejs/20.5.1/lib/node_modules/pm2/bin/pm2 startup systemd -u user --hp /home/user
```

## Configuração

Em construção...

## Uso

Para saber mais de como usar pm2 acesse sua documentação,
[clicando aqui](https://pm2.keymetrics.io/docs/usage/quick-start/).
