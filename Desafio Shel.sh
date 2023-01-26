#!/bin/bash

# Backup do banco de dados e da pasta raiz do NGinX
# rodando um laço para verificar se a hora atual já é meia noite, 
# se sim, faz o backup e após 60 segundos, roda o laço novamente, senão roda novamente.     
while true; do
  hoje=$(date +"%Y_%m_%d")
  hora_atual=$(date +"%H:%M")
  hora_para_backup="00:00"

  if [ "$hora_atual" == "$hora_para_backup" ]; then
    pg_dump -U postgres -F t nome_bd > /backups/nome_bd_$hoje.tar
    tar -zcf /backups/nginx_root_$hoje.tar.gz /usr/share/nginx/html
  fi
  # aguarda 60 segundos e executa o script novamente
  sleep 60
done

# Verifica se o serviço do postgres está rodando
pg_isready
if [ $? -ne 0 ]; then
    
  service postgresql start
fi
else
    O banco de dados está ligado!



# mudando para a pasta seu_diretorio/backups
# Apaga o quinto arquivo mais antigo da pasta de backups.
# lista os arquivos por data de modificação selecionando os últimos 5.
# pega o quinto arquivo e após isso ele apaga o mesmo.
cd seu_diretorio/backups 
rm $(ls -t ~/seu_diretorio/backup  |  tail -n 5 | head -n 1)



# Atualiza os pacotes do Ubuntu a flag "-y" é para rodar a aplicação sem autorização do usuário.
# sem a flag poderíamos criar uma condição para o usuário decidir se deseja ou não instalar a mesma.
apt-get update
apt-get upgrade -y

# Verifica se o Nginx está instalado
nginx -v
if [ $? -ne 0 ]; then
  apt-get install nginx -y
fi



