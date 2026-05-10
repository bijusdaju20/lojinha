#!/bin/bash

set -e

VERSION_FILE="VERSION"
CHANGELOG_FILE="CHANGELOG.md"

# Função para exibir o uso correto do script
usage() {
  echo "Uso: $0 <major|minor|patch>"
  exit 1
}

# Verifica se o argumento foi fornecido
if [ -z "$1" ]; then
  usage
fi

VERSION_TYPE=$1

# Lê a versão atual
CURRENT_VERSION=$(cat $VERSION_FILE)

# Divide a versão em partes
MAJOR=$(echo $CURRENT_VERSION | cut -d. -f1)
MINOR=$(echo $CURRENT_VERSION | cut -d. -f2)
PATCH=$(echo $CURRENT_VERSION | cut -d. -f3)

# Incrementa a versão
case $VERSION_TYPE in
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  patch)
    PATCH=$((PATCH + 1))
    ;;
  *)
    usage
    ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"

echo "Versão atual: $CURRENT_VERSION"
echo "Nova versão: $NEW_VERSION"

# Atualiza o arquivo VERSION
echo $NEW_VERSION > $VERSION_FILE

# Atualiza o CHANGELOG.md
# Move o conteúdo de 'Unreleased' para a nova versão
sed -i "/## \[Unreleased\]/a\n## \[${NEW_VERSION}\] - $(date +%Y-%m-%d)" $CHANGELOG_FILE

# Adiciona os arquivos ao Git
git add $VERSION_FILE $CHANGELOG_FILE

# Cria o commit de release
git commit -m "Release v${NEW_VERSION}"

# Cria a tag de versão
git tag -a "v${NEW_VERSION}" -m "Release v${NEW_VERSION}"

echo "Release v${NEW_VERSION} criado com sucesso!"
