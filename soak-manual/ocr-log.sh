#! /bin/bash
export PATH="/home/ubuntu/bin:/home/ubuntu/.local/bin:/usr/local/jdk1.8.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"

#Array of Chainlink pods
pods=$(kubectl get pods -A | grep chainlink | awk '{print $2}')

#Pods namespaces
namespaces=$(kubectl get namespace -A | grep chainlink | awk '{print $1}')

for namespace in $namespaces; do
    #Check if directory for ocr-log exists and create it if necessary
    [ ! -d "~/$namespace" ] && mkdir -p "$HOME/$namespace"

    #Create folder for all nodes logs in ocr directory
    for pod in ${pods[@]}; do
        [ ! -d "~/$namespace/$pod" ] && mkdir -p "$HOME/$namespace/$pod"
    done

    for pod in ${pods[@]}; do
        echo "$HOME/$namespace/$pod"
    done

    #Loop through pods and log warnings and errors to files
    for pod in ${pods[@]}; do
        WARN=$(kubectl logs -n $namespace $pod | grep "\[WARN\]")
        ERROR=$(kubectl logs -n $namespace $pod | grep "\[ERROR\]")
        LOG=$(kubectl logs -n $namespace $pod)
        TIME=$(date +%F-%T)

        if [[ $LOG ]]; then
           printf "$LOG" > ~/$namespace/$pod/$TIME.log
        fi

        if [[ $ERROR ]]; then
           printf "$ERROR" > ~/$namespace/$pod/error_$TIME.log
        fi

        if [[ $ERROR ]]; then
           printf "$WARN" > ~/$namespace/$pod/warn_$TIME.log
        fi
    done
done
