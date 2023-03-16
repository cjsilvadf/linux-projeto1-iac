#!/bin/bash
#Script que cria estrutura de diretórios, usuários com senha, grupos, adiciona os usuários aos grupos, ajusta permissões.
# Função para criar os diretórios
cria_diretorio () {
    nome_diretorio=$1
    mkdir "$nome_diretorio"
    if [ $? -eq 0 ]; then
        echo "O diretório $nome_diretorio foi criado com sucesso."
    else
        echo "Ocorreu um erro ao criar o diretório $nome_diretorio."
    fi
}

# Nomes dos diretórios
cria_diretorio "/publico"
cria_diretorio "/adm"
cria_diretorio "/ven"
cria_diretorio "/sec"

# Função para criar usuário com senha criptografada
criar_usuario () {
    nome_usuario=$1
    senha_padrao="Senha123"
    senha_criptografada=$(openssl passwd -6 "$senha_padrao")
    useradd -m -s /bin/bash -p "$senha_criptografada" "$nome_usuario"
    if [ $? -eq 0 ]; then
        echo "O usuário $nome_usuario foi criado com sucesso."
        echo "A senha padrão para o usuário é: $senha_padrao"
    else
        echo "Ocorreu um erro ao criar o usuário $nome_usuario."
    fi
}

# Cria os usuários com as senhas criptografadas
criar_usuario carlos
criar_usuario maria
criar_usuario joao
#
criar_usuario debora
criar_usuario sebastiana
criar_usuario roberto
#
criar_usuario josefina
criar_usuario amanda
criar_usuario rogerio

# Função para criar grupo
cria_grupo () {
    nome_grupo=$1
    groupadd "$nome_grupo"
    if [ $? -eq 0 ]; then
        echo "O grupo $nome_grupo foi criado com sucesso."
    else
        echo "Ocorreu um erro ao criar o grupo $nome_grupo."
    fi
}

# Nomes dos grupos
cria_grupo "GRP_ADM"
cria_grupo "GRP_VEN"
cria_grupo "GRP_SEC"

# Adiciona usuários ao grupo GRP_ADM
usermod -a -G GRP_ADM carlos
usermod -a -G GRP_ADM maria
usermod -a -G GRP_ADM joao
echo "Os usuários carlos, maria e joao foram adicionados ao grupo GRP_ADM com sucesso."

# Adiciona usuários ao grupo GRP_VEN
usermod -a -G GRP_VEN debora
usermod -a -G GRP_VEN sebastiana
usermod -a -G GRP_VEN roberto
echo "Os usuários debora, sebastiana e roberto foram adicionados ao grupo GRP_VEN com sucesso."

# Adiciona usuários ao grupo GRP_VEN
usermod -a -G GRP_SEC josefina
usermod -a -G GRP_SEC amanda
usermod -a -G GRP_SEC rogerio
echo "Os usuários josefina, amanda e rogerio foram adicionados ao grupo GRP_SEC com sucesso."

echo "Aplicando as permissões dos diretórios"
chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 777 /publico
chmod 770 /adm
chmod 770 /ven
chmod 770 /sec

echo "FIM"