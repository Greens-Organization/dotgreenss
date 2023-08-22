const { exec } = require('child_process');

// Comando que deseja executar
const command = './script.sh';

// Função para executar o comando
function executeScript(command) {
  // Executa o comando no shell
  const childProcess = exec(command);

  // Imprime a saída do script
  childProcess.stdout.on('data', (data) => {
    console.log(`Saída: ${data}`);
  });

  // Imprime a saída de erro do script, caso ocorra
  childProcess.stderr.on('data', (data) => {
    console.error(`Erro: ${data}`);
  });

  // Captura o evento de finalização do script
  childProcess.on('close', (code) => {
    console.log(`Script finalizado com código de saída ${code}`);
  });
}

// Executa o script
executeScript(command);
