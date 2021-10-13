#! /bin/bash
#Author: Oluwafemi Alofe<oluwafemi.alofe@altoros.com>
#Orgnisation: Altoros

#Array of chainlink pods
pods=$(kubectl get pods -A | grep chainlink | awk '{print $2}')

#namespace of pods
namespace=($(kubectl get pods -A | grep chainlink | awk '{print $1}')[0])

#Check if directory for ocr-log exist
[ ! -d "~/$namespace" ] && mkdir -p "$HOME/$namespace"

#Create folder for all nodes logs in ocr directory
for pod in ${pods[@]}; do
    [ ! -d "~/$namespace/$pod" ] && mkdir -p "$HOME/$namespace/$pod"
done

for pod in ${pods[@]}; do
    echo "$HOME/$namespace/$pod"
done

#Loop through pods and log warning and error to file
for pod in ${pods[@]}; do
    #WARN=$(kubectl logs pod/$pod -n $namespace -c node | grep "\[WARN\]")
    #ERROR=$(kubectl logs pod/$pod -n $namespace -c node | grep "\[ERROR\]")
    LOG=$(kubectl logs pod/$pod -n $namespace -c node)
    TIME=$(date +%F-%T)
    
    if [[ $LOG ]]; then
        echo $LOG > ~/$namespace/$pod/$TIME.log
    fi
    
    # if [[ $ERROR ]]; then
    #  echo $ERROR > ~/$namespace/$pod/error_$TIME.log
    # fi
    
done