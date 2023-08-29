# Configuração SSH

## Na sua maquina

Configurar o acesso SSH usando chaves é uma maneira segura de autenticar no
servidor sem a necessidade de uma senha. Aqui está um guia passo a passo sobre
como configurar a autenticação por chave SSH:

**Gere um par de chaves SSH**: Se você ainda não tiver um par de chaves SSH,
gere um usando o seguinte comando no computador cliente (não no servidor):

```bash
ssh-keygen
```

Isso criará duas chaves: uma chave privada (`~/.ssh/id_rsa`) e uma chave pública
(`~/.ssh/id_rsa.pub`).

**Copie a chave pública para o servidor**:

```bash
cat ~/.ssh/id_rsa.pub | ssh usuario@endereco_do_servidor "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

## No servidor

**Alterando as configurações do servidor SSH**: No servidor, vamos editar o
arquivo de configuração do ssh:

```bash
sudo nano /etc/ssh/sshd_config
```

No arquivo (`/etc/ssh/sshd_config`) você deve alterar essas opções, para exemplo
abaixo:

```shell
Port 30080 # É recomendado alterar a porta padrão de acesso SSH, mas lembre-se de anotar a mesma.

PubkeyAuthentication yes # Ativando o acesso por chave publica.
AuthorizedKeysFile .ssh/authorized_keys # Localização do arquivo de chaves (ATENÇÂO: NÃO altere está localização a menos que saiba o que está fazendo).

```

Após editar e salvar o arquivo, deve reiniciar o serviço SSH:

```bash
sudo systemctl restart sshd
```

**Teste a conexão**: Tente se conectar ao servidor SSH a partir do cliente. Se
tudo estiver configurado corretamente, você deve ser autenticado e conectado sem
a necessidade de inserir uma senha.

**Desativar a autenticação por senha**: Se você quiser aumentar a segurança e
permitir apenas a autenticação por chave, edite o arquivo `/etc/ssh/sshd_config`
no servidor e defina:

```shell
PasswordAuthentication no
```

Depois de fazer essa alteração, reinicie o serviço SSH:

```bash
sudo systemctl restart sshd
```

**Atenção**: Certifique-se de que a autenticação por chave está funcionando
corretamente antes de desativar a autenticação por senha. Caso contrário, você
pode ficar bloqueado fora do servidor.

E é isso! Agora você configurou o acesso SSH usando chaves em vez de senhas.
Isso não apenas melhora a segurança, mas também facilita o acesso sem a
necessidade de lembrar e digitar senhas.
