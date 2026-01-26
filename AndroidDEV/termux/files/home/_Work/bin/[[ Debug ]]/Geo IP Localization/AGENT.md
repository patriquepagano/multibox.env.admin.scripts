## Regras do Projeto
- Todo script criado deve comecar com:
```bash
#!/system/bin/sh
clear
path="$( cd "${0%/*}" && pwd -P )"
parent_path="$(dirname "$path")"
```
- Ambiente TVBOX limitado: apenas BusyBox e comandos basicos disponiveis para scripts.
- Scripts sao invocados por um launcher Linux que usa fzf.
- Nao adicionar `set -euo pipefail` nos scripts.
- Evitar usar `exit` nos scripts.
- Nao usar `read -p` ou `read -r -p` (BusyBox sh nao suporta); usar `printf` + `read`.
- Todo script criado deve terminar com (se nao estiver assim, padronize):

```bash
if [ ! "$1" == "skip" ]; then
    echo "Press any key to exit."
    read bah
fi

```
- Scripts de engine compartilhada nao devem incluir o prompt de `skip`; apenas os wrappers.
- Preferir `source` nas engines compartilhadas para herdar variaveis definidas nos wrappers.
- Nunca ler ou mexer fora do `cwd` do workspace.
- Nunca ler a pasta `.git`.
- Quando eu pedir um comando simples para debugar em terminal remoto, sempre envie os comandos em blocos de código (```bash ... ```), um comando por bloco, para facilitar copiar.
- Quando este arquivo `AGENT.md` estiver presente, nao acesse pastas acima dele, mesmo que o `cwd` permita. Fique sempre dentro da pasta onde ele se encontra.
