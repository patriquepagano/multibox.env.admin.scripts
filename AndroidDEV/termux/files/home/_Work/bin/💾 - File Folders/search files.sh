#!/system/bin/sh
clear
path="$( cd "${0%/*}" && pwd -P )"


# # Credenciais e chaves
# .git-credentials
# **/.git-credentials
# **/*.pem
# **/*.key
# **/*.p12
# **/*.pfx
# **/*.jks
# **/id_rsa
# **/id_ed25519
# **/known_hosts

# # Tokens e configs sensiveis
# **/.env
# **/.env.*
# **/secrets.*
# **/secret.*
# **/token.*
# **/credentials.*
# **/.netrc

base_path="/storage/DevMount"
find_results="$(
    busybox find "$base_path" -type f \( \
        -name ".git-credentials" -o \
        -name "*.pem" -o \
        -name "*.key" -o \
        -name "*.p12" -o \
        -name "*.pfx" -o \
        -name "*.jks" -o \
        -name "id_rsa" -o \
        -name "id_ed25519" -o \
        -name "known_hosts" -o \
        -name ".env" -o \
        -name ".env.*" -o \
        -name "secrets.*" -o \
        -name "secret.*" -o \
        -name "token.*" -o \
        -name "credentials.*" -o \
        -name ".netrc" \
    \) 2>/dev/null
)"

if [ -n "$find_results" ]; then
    {
        echo "Arquivos encontrados em $base_path:"
        echo "$find_results"
    } | tee "$path/search log results.log"
else
    echo "Nenhum arquivo encontrado em $base_path." | tee "$path/search log results.log"
fi



if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi
