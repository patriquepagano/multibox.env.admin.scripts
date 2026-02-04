#!/system/bin/sh
# Menu switch DNS - BusyBox / root limitado
# Compatível com Android TV boxes com BusyBox

path="$( cd "${0%/*}" && pwd -P )"

DNS_LIST="\
Google|8.8.8.8|8.8.4.4\
Cloudflare|1.1.1.1|1.0.0.1\
Quad9|9.9.9.9|149.112.112.112\
OpenDNS|208.67.222.222|208.67.220.220\
AdGuard|94.140.14.14|94.140.15.15\
"

show_current_dns() {
    echo "DNS atual:"
    getprop net.dns1 2>/dev/null || echo "(sem resposta)"
    getprop net.dns2 2>/dev/null || echo "(sem resposta)"
}

set_dns() {
    ip1="$1"; ip2="$2"
    echo "Definindo DNS: $ip1 $ip2"
    setprop net.dns1 "$ip1" 2>/dev/null
    setprop net.dns2 "$ip2" 2>/dev/null
    # Tentativa de limpar cache de resolver (melhor esforço)
    ndc resolver flushdefaultif 2>/dev/null || true
    ndc resolver flushif wlan0 2>/dev/null || true
    echo "Feito."
    show_current_dns
}

ping_avg() {
    ip="$1"
    # 3 pings, timeout por ping 1s (ajuste se necessário)
    out=$(ping -c 3 -W 1 "$ip" 2>&1)
    # extrair tempos das linhas com time=
    times=$(printf "%s\n" "$out" | awk -F"time=" '/time=/{split($2,a," "); print a[1]}')
    sum=0
    cnt=0
    for t in $times; do
        # remover 'ms' se presente
        t=${t%ms}
        # converter virgula a ponto
        t=${t//,/.}
        sum=$(awk "BEGIN{printf \"%.3f\", $sum + $t}")
        cnt=$((cnt+1))
    done
    if [ "$cnt" -eq 0 ]; then
        echo "-"  # não respondeu
        return
    fi
    avg=$(awk "BEGIN{printf \"%.3f\", $sum / $cnt}")
    echo "$avg"
}
# bench functionality removed — removed because it produced unreliable results on some devices
# Use the menu options to select DNS providers directly

menu() {
    while :; do
        echo "\n=== Menu DNS ==="
        show_current_dns
        echo "1) Google - 8.8.8.8 / 8.8.4.4"
        echo "2) Cloudflare - 1.1.1.1 / 1.0.0.1"
        echo "3) Quad9 - 9.9.9.9 / 149.112.112.112"
        echo "4) OpenDNS - 208.67.222.222 / 208.67.220.220"
        echo "5) AdGuard - 94.140.14.14 / 94.140.15.15"
        echo "6) Mostrar DNS atual"
        echo "7) Sair"
        echo -n "Escolha uma opção [1-7]: "
        read opt
        case "$opt" in
            1) set_dns 8.8.8.8 8.8.4.4 ;;
            2) set_dns 1.1.1.1 1.0.0.1 ;;
            3) set_dns 9.9.9.9 149.112.112.112 ;;
            4) set_dns 208.67.222.222 208.67.220.220 ;;
            5) set_dns 94.140.14.14 94.140.15.15 ;;
            6) show_current_dns ;;
            7) break ;;
            *) echo "Opção inválida." ;;
        esac
    done
}

# bench mode removed

# Executar menu interativo
menu

if [ ! "$1" = "skip" ]; then
    echo "Press any key to exit."
    read bah
fi



