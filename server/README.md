# Servidor Greens

Por padrão vamos sempre usar o Debian Server para nosso servidor (No momento estamos trabalhando somente no debian 11 na data: 19 de Agosto de 2023). Porém, futuramente vamos migrar para as versões mais novas do Debian 12. Só usamos nesse periodo por conta da mudança de política do Debian 12. Que aceita depois de anos de funcionamento softwares proprietários diretamente no seu gerenciador de pacotes (apt).

Temos outras opções para criar nossos servidores, segue a lista:

- [Rocky Linux](https://rockylinux.org/download) (RHEL Based)
- [CentOS](https://www.centos.org/download/) (RHEL Based)
- [Ubuntu Server](https://ubuntu.com/download/server) (Debian Based)

Para fazer download do debian 12: https://www.debian.org/download

Após o download da ISO, coloque-o em um pendrive ou adicione diretamente no seu servidor e faça a instalação corretamente.

## 1. Atualize o sistema

No começo não vamos ter super usuários (sudoers), então por conta disso você primeiro precisa ir para root:

```
su
```

Ele vai pedir a senha do root diretamente e espero que você tenha ela salva para que possa entrar na root do sistema

Em seguida, atualize o sistema:

```
apt update && apt upgrade
```

## 2. Configure o PATH

Caso você tenha feita uma instalação limpa somente com os comandos utilitários e OpenSSH, vai precisar adicionar e configurar suas variáveis de ambiente, em específico o `$PATH`.

```bash
cat << 'EOF' > /home/user/.profile
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "/usr/local/sbin" ] ; then
  PATH="$PATH:usr/local/sbin"
fi

if [ -d "/usr/sbin" ] ; then
  PATH="$PATH:/usr/sbin"
fi

if [ -d "/sbin" ] ; then
  PATH="$PATH:/sbin"
fi

EOF
```

Não esqueça de substituir o `user` pelo seu usuário. Em seguida, reinicie o bash ou até mesmo o próprio `.profile`

```
. /home/user/.profile
```

OBS: Se você estiver fazendo isso em root, e voltar novamente para o usuário, vai precisar atualizar novamente o .profile.

```
. ~/.profile
```

## 3. Instale e configure o sudo

Instale o sudo com o seguinte comando:

```
apt install sudo -y
```

`-y`: é para instalar sem precisar pedir confirmação de instalação.

Em seguida, configure seu usuário para adicioná-lo ao grupo dos super usuários:

```
usermod -aG sudo user
```

Substituia o `user` pelo seu usuário.

Após isso, reinicie a máquina:

```
reboot
```

## 4. Instalando Pacotes Essenciais

1. Utilitários básicos

- **curl** e **wget**: ferramentas para baixar arquivos da web.
- **rsync**: Uma ferramenta de cópia de arquivos rápida e versátil.
- **tmux**: Permite múltiplas sessões de terminal dentro de uma única janela.

2. Segurança

- **fail2ban**: Protege contra ataques de força bruta.
- **ufw**: Ferramente de firewall para gerenciar o tráfego de rede.
- **unattended-upgrades**: instala atualizações de segurança automaticamente.

3. Monitoramento e Gerenciamento do Sistema

- **htop** ou **glances**: visualizadores de processos de monitoramento de sistema interativos aprimorados.
- **iotop**: monitora o uso de E/S.
- **nload** ou **iftop**: Monitore o tráfego de rede e o uso da largura de banda.
- **ncdu**: analisador de uso de disco com uma interface ncurses.

4. Rede

- **net-tools**: Contém ferramentas básicas de rede como ifconfig.
- **dnsutils**: contém ferramentas como dig para consultar servidores DNS.
- **traceroute**: Mostra o caminho da rede para um destino.
- **whois**: Consulta informações sobre um nome de domínio.

5. Editores de texto

- **neovim** ou **emacs**: a escolha está nas suas mãos. Ambos são poderosas ferramentas de edição

6. Sistema de arquivos e armazenamento

- **lvm2**: Ferramentas de Gerenciamento de Volume Lógico.
- **smartmontools**: Ferramentas para monitorar a integridade dos dispositivos de armazenamento.

7. Arquivamento e Compressão

- **zip**, **unzip**, **tar**, **gzip**, **bzip2**, **xz-utils**: Ferramentas para compactar e descompactar arquivos.

8. Gerenciamento de pacotes

- **aptitude**: Uma alternativa ao apt para gerenciamento de pacotes.
- **software-properties-common**: gerencia repositórios e adiciona PPAs.

9. Ferramentas de desenvolvimento (se você estiver fazendo algum tipo de desenvolvimento ou script):

- **build-essential**: Contém ferramentas essenciais para construir pacotes Debian.
- **git**: Sistema de controle de versão.

10. Diversos

- **locales**: gerencia as configurações de localização.
- **man-db** e **manpages**: Fornece as páginas de manual para comandos.

O comando a segui é são os pacotes que usamos geralmente, e é com base na nossa necessidades, existem muitos outros pacotes que você talvez precise ou talvez não, então recomenda-se ler sobre cada um deles e ver qual agrada melhor vocês e quais vão ser úteis para seus propósitos:

```
sudo apt install curl wget tmux htop neovim zip unzip build-essential git ufw fail2ban software-properties-common traceroute iftop
```

## 5. Configurando um gerenciador de linguagens de programação

Primeiro instale o [asdf](https://asdf-vm.com/)

No nosso caso, estamos usando o debian. Então garanta que tenha o `curl` e o `git` instalado, depois disso, siga as instruções que estão localizadas no site oficial do asdf.

Para esse exemplo, vamos instalar o [Java](https://www.java.com/en/) utilizando o asdf. Primeiro vamos instalar o plugin do java no asdf:

```
asdf plugin-add java https://github.com/halcyon/asdf-java.git
```

Agora, vamos escolher uma versão, vamos pegar a openjdk-17.0.1

```
asdf install java openjdk-17.0.1
```

Após isso, vamos disponibilizar globalmente essa versão no sistema:

```
asdf global java openjdk-17.0.1
```

Por fim, vamos adicionar a versão do JAVA_HOME, para isso, entre dentro da `~/.bashrc` e adicione no final da linha ou use esse comando:

```bash
echo ". ~/.asdf/plugins/java/set-java-home.bash" >> ~/.bashrc
```
