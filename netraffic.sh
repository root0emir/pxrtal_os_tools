#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

read -p "Enter the network interface to monitor (e.g., eth0): " interface
read -p "Enter the duration to monitor (in seconds): " duration
read -p "Enter the threshold for data transfer (in KB): " threshold
read -p "Enter the reporting interval (in seconds): " interval
read -p "Enter the output file to save results: " output_file
read -p "Enter the directory to save graphs: " graph_dir

monitor_traffic() {
    echo -e "${BLUE}Monitoring network traffic on interface $interface for $duration seconds...${NC}"

    end_time=$((SECONDS + duration))
    rx_initial=$(cat /sys/class/net/$interface/statistics/rx_bytes)
    tx_initial=$(cat /sys/class/net/$interface/statistics/tx_bytes)

    while [ $SECONDS -lt $end_time ]; do
        sleep $interval

        rx_current=$(cat /sys/class/net/$interface/statistics/rx_bytes)
        tx_current=$(cat /sys/class/net/$interface/statistics/tx_bytes)

        rx_delta=$((rx_current - rx_initial))
        tx_delta=$((tx_current - tx_initial))

        rx_kb=$((rx_delta / 1024))
        tx_kb=$((tx_delta / 1024))
        total_kb=$((rx_kb + tx_kb))

        echo -e "${GREEN}Report at $(date +'%Y-%m-%d %H:%M:%S')${NC}"
        echo -e "${GREEN}Received: $rx_kb KB${NC}"
        echo -e "${GREEN}Transmitted: $tx_kb KB${NC}"
        echo -e "${GREEN}Total: $total_kb KB${NC}"

        if [ $total_kb -gt $threshold ]; then
            echo -e "${RED}Warning: Data transfer exceeded the threshold of $threshold KB${NC}"
        fi

        echo "Report at $(date +'%Y-%m-%d %H:%M:%S')" >> $output_file
        echo "Received: $rx_kb KB" >> $output_file
        echo "Transmitted: $tx_kb KB" >> $output_file
        echo "Total: $total_kb KB" >> $output_file

        if [ $total_kb -gt $threshold ]; then
            echo "Warning: Data transfer exceeded the threshold of $threshold KB" >> $output_file
        fi

        rx_initial=$rx_current
        tx_initial=$tx_current
    done

    echo -e "${BLUE}Monitoring completed. Results saved to $output_file${NC}"
}


monitor_protocol_traffic() {
    echo -e "${BLUE}Monitoring TCP and UDP traffic on interface $interface for $duration seconds...${NC}"

    end_time=$((SECONDS + duration))

    while [ $SECONDS -lt $end_time ]; do
        sleep 1
        tcp_traffic=$(sudo netstat -i $interface -p TCP | tail -n 1 | awk '{print $4, $8}')
        udp_traffic=$(sudo netstat -i $interface -p UDP | tail -n 1 | awk '{print $4, $8}')

        echo -e "${GREEN}TCP Traffic: $tcp_traffic${NC}"
        echo -e "${GREEN}UDP Traffic: $udp_traffic${NC}"

        echo "TCP Traffic: $tcp_traffic" >> $output_file
        echo "UDP Traffic: $udp_traffic" >> $output_file
    done

    echo -e "${BLUE}Monitoring completed. Results saved to $output_file${NC}"
}


generate_graphs() {
    echo -e "${BLUE}Generating graphs from the results...${NC}"

    mkdir -p $graph_dir
    timestamp=$(date +'%Y%m%d%H%M%S')

    gnuplot -e "set terminal png; set output '$graph_dir/traffic_$timestamp.png'; set title 'Network Traffic'; set xlabel 'Time'; set ylabel 'KB'; plot '$output_file' using 2:5 with lines title 'Received', '$output_file' using 2:6 with lines title 'Transmitted', '$output_file' using 2:7 with lines title 'Total'"

    echo -e "${BLUE}Graphs saved to $graph_dir${NC}"
}


while true; do
    echo -e "${BLUE}Network Traffic Monitor Menu:${NC}"
    echo "1. Monitor Network Traffic"
    echo "2. Monitor TCP and UDP Traffic"
    echo "3. Generate Graphs"
    echo "4. Exit"
    read -p "Select an option [1-4]: " option

    case $option in
        1) monitor_traffic ;;
        2) monitor_protocol_traffic ;;
        3) generate_graphs ;;
        4) break ;;
        *) echo -e "${RED}Invalid option. Please select a number between 1 and 4.${NC}" ;;
    esac
done