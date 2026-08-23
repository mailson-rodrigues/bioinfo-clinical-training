#!/bin/bash

# Script de auto-commit para o projeto bioinfo_estudo
# Verifica mudanças e envia para o GitHub automaticamente

PROJETO_DIR="$HOME/projetos/bioinfo_estudo"
LOG_FILE="$HOME/projetos/bioinfo_estudo/docs/auto_commit_log.txt"

cd "$PROJETO_DIR" || exit 1

# Verifica se há mudanças (arquivos novos, modificados ou removidos)
if [[ -n $(git status --porcelain) ]]; then
    DATA_HORA=$(date "+%Y-%m-%d %H:%M:%S")

    git add .
    git commit -m "Atualização automática: $DATA_HORA"
    git push origin main

    echo "[$DATA_HORA] Commit e push realizados com sucesso." >> "$LOG_FILE"
else
    DATA_HORA=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$DATA_HORA] Nenhuma mudança detectada, nada a enviar." >> "$LOG_FILE"
fi
