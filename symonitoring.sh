#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


check_and_install_gnuplot() {
    if ! command -v gnuplot &> /dev/null
    then
        echo -e "${BLUE}Gnuplot is not installed. Installing gnuplot...${NC}"
        sudo apt update && sudo apt install -y gnuplot
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Gnuplot installed successfully.${NC}"
        else
            echo -e "${RED}Failed to install gnuplot. Please install it manually.${NC}"
            exit 1
        fi
    else
        echo -e "${GREEN}Gnuplot is already installed.${NC}"
    fi
}


check_nvidia_smi() {
    if ! command -v nvidia-smi &> /dev/null
    then
        echo -e "${RED}nvidia-smi could not be found. Please install NVIDIA drivers.${NC}"
        exit 1
    fi
}


read -p "Enter the duration to monitor (in seconds): " duration
read -p "Enter the reporting interval (in seconds): " interval
read -p "Enter the CPU usage threshold (in percentage): " cpu_threshold
read -p "Enter the GPU usage threshold (in percentage): " gpu_threshold
read -p "Enter the output file to save results: " output_file
read -p "Enter the directory to save graphs: " graph_dir


check_and_install_gnuplot
check_nvidia_smi

echo -e "${BLUE}Monitoring CPU and GPU usage for $duration seconds...${NC}"


monitor_usage() {
    end_time=$((SECONDS + duration))

    echo "Time,CPU Usage (%),GPU Usage (%)" > $output_file

    while [ $SECONDS -lt $end_time ]; do
        sleep $interval

        
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | \
                    sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
                    awk '{print 100 - $1}')

       
        gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

        echo -e "${GREEN}Report at $(date +'%Y-%m-%d %H:%M:%S')${NC}"
        echo -e "${GREEN}CPU Usage: $cpu_usage%${NC}"
        echo -e "${GREEN}GPU Usage: $gpu_usage%${NC}"

        if (( $(echo "$cpu_usage > $cpu_threshold" | bc -l) )); then
            echo -e "${RED}Warning: CPU usage exceeded the threshold of $cpu_threshold%${NC}"
        fi

        if (( $(echo "$gpu_usage > $gpu_threshold" | bc -l) )); then
            echo -e "${RED}Warning: GPU usage exceeded the threshold of $gpu_threshold%${NC}"
        fi

        echo "$(date +'%Y-%m-%d %H:%M:%S'),$cpu_usage,$gpu_usage" >> $output_file
    done

    echo -e "${BLUE}Monitoring completed. Results saved to $output_file${NC}"
}


generate_graphs() {
    echo -e "${BLUE}Generating graphs from the results...${NC}"

    mkdir -p $graph_dir
    timestamp=$(date +'%Y%m%d%H%M%S')

    gnuplot -e "set datafile separator ','; set terminal png; set output '$graph_dir/cpu_usage_$timestamp.png'; set title 'CPU Usage'; set xlabel 'Time'; set ylabel 'Usage (%)'; set xdata time; set timefmt '%Y-%m-%d %H:%M:%S'; set format x '%H:%M:%S'; plot '$output_file' using 1:2 with lines title 'CPU Usage'"

    gnuplot -e "set datafile separator ','; set terminal png; set output '$graph_dir/gpu_usage_$timestamp.png'; set title 'GPU Usage'; set xlabel 'Time'; set ylabel 'Usage (%)'; set xdata time; set timefmt '%Y-%m-%d %H:%M:%S'; set format x '%H:%M:%S'; plot '$output_file' using 1:3 with lines title 'GPU Usage'"

    echo -e "${BLUE}Graphs saved to $graph_dir${NC}"
}


while true; do
    echo -e "${BLUE} CPU and GPU Usage Monitor Menu:${NC}"
    echo "1. Monitor CPU and GPU Usage"
    echo "2. Generate Graphs"
    echo "3. Exit"
    read -p "Select an option [1-3]: " option

    case $option in
        1) monitor_usage ;;
        2) generate_graphs ;;
        3) break ;;
        *) echo -e "${RED}Invalid option. Please select a number between 1 and 3.${NC}" ;;
    esac
done