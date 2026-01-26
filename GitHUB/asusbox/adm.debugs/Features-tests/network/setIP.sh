#!/system/bin/sh

while ! ping -c 1 -W 1 10.0.0.1; do
    echo "Waiting for network interface might be down..."
    sleep 1
done

# cria dois ips para interface.. e funciona muita bem!
ip address add 10.0.0.101 dev wlan0
ip addr show






# # travou ainda não sei pq
# ifconfig wlan0 10.0.0.101 netmask 255.0.0.0
# route add default gw 10.0.0.1 dev wlan0

# setprop net.eth0.dns1 8.8.8.8
# setprop net.eth0.dns2 4.4.4.4

# wlan0 UP 10.0.0.101 netmask 255.0.0.0






