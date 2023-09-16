# Servidor
OS: RedHat / RockyLinux


## Atualizar sistema
```bash
sudo dnf update -y
```

## Adicionando usuário
__Lembre-se de alterar o `username` para o nome do seu usuário.__
Para adicionar o usuário:
```bash
adduser username
```
Adicionando uma senha para o usuário:
```bash
passwd username
```
Adicionando permissão de sudo
```bash
usermod -aG wheel username
```

**Alterar de usuário**
```bash
su - username 
```


## Instalando o node
Seguir o passo a passo
```bash
sudo yum install https://rpm.nodesource.com/pub_20.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1
```



### Resolução de problemas

**Erro GPG**
Caso der erro de chave GPG, como este:
```bash
Total                                                                                                                               32 MB/s |  36 MB     00:01
Node.js Packages for Linux RPM based distros - x86_64                                                                              1.6 MB/s | 1.7 kB     00:00
Importing GPG key 0x9B1BE0B4:
 Userid     : "NSolid <nsolid-gpg@nodesource.com>"
 Fingerprint: 6F71 F525 2828 41EE DAF8 51B4 2F59 B5F9 9B1B E0B4
 From       : /etc/pki/rpm-gpg/NODESOURCE-NSOLID-GPG-SIGNING-KEY-EL
warning: Signature not supported. Hash algorithm SHA1 not available.
Key import failed (code 2). Failing package is: nodejs-2:20.6.1-1nodesource.x86_64
 GPG Keys are configured as: file:///etc/pki/rpm-gpg/NODESOURCE-NSOLID-GPG-SIGNING-KEY-EL
The downloaded packages were saved in cache until the next successful transaction.
You can remove cached packages by executing 'yum clean packages'.
Error: GPG check FAILED
```

Depois acesse:
```bash
sudo vim /etc/yum.repos.d/nodesource*.repo
```
Localize a linha `gpgcheck=1` e mude para `gpgcheck=0`.

Depois atualize os pacotes:
```bash
sudo dnf update -y
```


