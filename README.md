# Lojinha de Bijuterias

Este repositório contém o código-fonte do site de bijuterias.

## Estrutura de Versionamento

Para manter o controle de todas as alterações, utilizamos o seguinte fluxo:

1. **Commits**: Todas as alterações devem ser enviadas com mensagens claras.
2. **CHANGELOG.md**: Todas as modificações notáveis devem ser descritas na seção `[Unreleased]`.
3. **Releases**: Para gerar uma nova versão, utilize o script `./release.sh`.

### Como fazer uma nova versão

Sempre que terminar um conjunto de alterações:

1. Adicione as descrições no `CHANGELOG.md` sob a seção `[Unreleased]`.
2. Execute o script de release:
   ```bash
   ./release.sh <patch|minor|major>
   ```
   - `patch`: Correções de bugs ou pequenas alterações.
   - `minor`: Novas funcionalidades.
   - `major`: Grandes mudanças estruturais.

3. Envie as alterações para o GitHub:
   ```bash
   git push origin main --tags
   ```
