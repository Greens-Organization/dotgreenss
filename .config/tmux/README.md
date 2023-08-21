# Tmux Config (Greens)

## Explicando cada Configuração

WIP

## Folha de Dicas

Todas as informações aqui foram retiradas daqui: https://tmuxcheatsheet.com/

### Sessões

**Começar uma nova sessão**:

```
$ tmux
```

```
$ tmux new
```

```
$ tmux new-session
```

```
:new
```

`Ctrl + B s`

**Começar uma nova sessão nomeada**

```
$ tmux new -s mysession
```

```
:new -s mysession
```

**Matar/Deletar uma sessão**

```
$ tmux kill-ses -t -mysession
```

```
$ tmux kill-session -t mysession
```

**Matar/Deletar todas as sessões, exceto a atual**

```
$ tmux kill-session -a
```

**Matar/Deletar todas as sessões, exceto _mysession_**

```
$ tmux kill-sessions -a -t mysession
```

**Renomear a sessão**

`Ctrl + b $`

**Desanexar da sessão**

`Ctrl + b d`

**Desanexar outros clientes na sessão (maximizar a janela desanexando outros clientes)**

```
: attach -d
```

**Mostrar todas as sessões**

```
$ tmux ls
```

```
$ tmux list-sessions
```

`Ctrl + b s`

**Anexar a última sessão**

```
$ tmux a
```

```
$ tmux at
```

```
$ tmux attach
```

```
$ tmux attach-session
```

**Anexar a uma sessão com o nome _mysession_**

```
$ tmux a -t mysession
```

```
$ tmux at -t mysession
```

```
$ tmux attach -t mysession
```

```
$ tmux attach-session -t mysession
```

**Pré-visualização da Sessão e da Janela**

`Ctrl + b w`

**Move para a sessão anterior**

`Ctrl + b (`

**Move para a próxima sessão**

`Ctrl + b )`

### Janelas

**iniciar uma nova sessão com o nome mysession e janela mywindow**

```
$ tmux new -s mysession -n mywindow
```

**Cria uma janela**
`Ctrl + b c`

**Renomea a janela atual**

`Ctrl + b ,`

**Fecha a janela atual**

`Ctrl + b &`

**Lista as janelas**

`Ctrl + b w`

**Vai para a janela anterior**

`Ctrl + b p`

**Vai para a próxima janela**

`Ctrl + b n`

**Troca/seleciona a janela pelo número**

`Ctrl + b 0...9`

**Alterna para a última janela ativa**

`Ctrl + b l`

**Reordene as janelas, troque a janela número 2(src) pela 1(dst)**

```
: swap-window -s 2 -t 1
```

**Move a janela atual para a esquerda uma posição**

```
: swap-window -t -1
```

### Painéis

**Alterna para o último painel ativo**

`Ctrl + b ;`

**Painel dividido com o layout horizontal**

`Ctrl + b %`

**Painel dividido com o layout vertical**

`Ctrl + b "`

**Move o painel atual para a esquerda**

`Ctrl + b {`

**Move o painel atual para a direita**

`Ctrl + b }`

**Troca entre paines pela setas**

`Ctrl + b ➡️`
`Ctrl + b ⬅️`
`Ctrl + b ⬇️`
`Ctrl + b ⬆️`

**Alterna entre os painéis de sincronização (envia comando para todos os painéis)**

```
: setw synchronize-panes
```

**Alterna entre layouts dos painéis**

`Ctrl + b spacebar`

**Vai para o próximo painel**

`Ctrl + b o`

**Mostra o número de painéis**

`Ctrl + b q`

**Muda/seleciona pelo número do painel**

`Ctrl + b q 0..9`

**Coloca em foco/zoom um painel**

`Ctrl + b z`

**Converte o painel para uma janela**

`Ctrl + b !`

**Redimensione a altura atual do painel (segurar a segunda tecla é opcional)**

`Ctrl + b ⬆️`
`Ctrl + b Ctrl + ⬆️`
`Ctrl + b ⬇️`
`Ctrl + b Ctrl + ⬇️`

**Redimensione a largura atual do painel (segurar a seconda tecla é opcional)**

`Ctrl + b ➡️`
`Ctrl + b Ctrl + ➡️`
`Ctrl + b ⬅️`
`Ctrl + b Ctrl + ⬅️`

**Fecha o painel atual**

`Ctrl + b x`

### Modo cópia

**Usa o modo vi no buffer**

```
: setw -g mode-keys vi
```

**Entra no modo de cópia**

`Ctrl + b [`

**Entra no modo de cópia e role uma página para cima**

`Ctrl + b PgUp`

**Modo de saída**

`q`

**Vai para o topo da linha**

`g`

**Vai para embaixo da linha**

`Shift + g`

**Rola para cima**

`⬆️`

**Rola para baixo**

`⬇️`

**Move o cursor para esquerda**

`h`

**Move o cursor para baixo**

`j`

**Move o cursor para cima**

`k`

**Move o cursor para direita**

`l`

**Move o cursor para frente uma palavra por vez**

`w`

**Move o cursor para atrás uma palavra por vez**

`b`

**Pesquisar para frente**

`/`

**Pesquisar para trás**

`?`

**Próxima palavra correspondente à ocorrência**

`n`

**Palavra anterior correspondente à ocorrência**

`Shift + n`

**Começa a selecionar**

`Spacebar`

**Limpa a seleção**

`Esc`

**Cópia a seleção**

`Enter`

**Cole o contepudo do buffer_0**

`Ctrl + b ]`

**Exibir o conteúdo do buffer_0**

```
: show-buffer
```

**Cópia todo o conteúdo visível do painel para um buffer**

```
: capture-pane
```

**Mostra todos os buffers**

```
: list-buffers
```

**Mostra todos os buffers e colas selecionadas**

```
: choose-buffer
```

**Sava o conteúdo do buffer em um arquivo buf.txt**

```
: save-buffer buf.txt
```

**Deleta o buffer 1**

```
: delete-buffer -b 1
```

### Variados

**Entra no modo de comando**
`Ctrl + b :`

**Define uma OPÇÃO para todas as sessões**

```
: set -g OPTION
```

**Define uma OPÇÃO para todas as janelas**

```
: setw -g OPTION
```

**Habilita o modo mouse**

```
: set mouse on
```

### Comandos helps

**Lista todas as teclas de atalho**

```
$ tmux list-keys
```

```
: list-keys
```

`Ctrl + b ?`

**Mostra cada sessão, janela, painel, etc...**

```
$ tmux info
```
