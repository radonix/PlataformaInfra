#!/usr/bin/env bash
set -euo pipefail


# Exemplo de uso:
# ./deploy-ec2.sh ec2-user@1.2.3.4 /home/ec2-user/plataforma-infra


REMOTE=$1
REMOTE_DIR=${2:-~/plataforma-infra}


ssh $REMOTE "mkdir -p $REMOTE_DIR"


# copia o docker-compose e o .env (assumindo que você rodou este script na raiz do repo infra)
scp docker-compose.yml $REMOTE:$REMOTE_DIR/
scp .env $REMOTE:$REMOTE_DIR/ || true


ssh $REMOTE "cd $REMOTE_DIR && docker compose pull || true && docker compose up -d --build"


echo "Deploy triggered on $REMOTE:$REMOTE_DIR"