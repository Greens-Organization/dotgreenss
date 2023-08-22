#!/bin/bash

# Inicia o TMUX e cria uma sessão chamada "Minecraft"
tmux new-session -d -s Minecraft

# Executa um comando na sessão "Minecraft" (substitua o comando pelo que você deseja executar)
tmux send-keys -t Minecraft 'cd ServerGreensCreate/' C-m

# Executa o comando para iniciar o servidor do game
tmux send-keys -t Minecraft './start-reboot.sh' C-m

# Anexa à sessão "Minecraft" para visualizá-la
tmux attach-session -t Minecraft

