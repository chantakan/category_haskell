#!/bin/bash

read -p "Enter username: " usn
while grep -q $usn ./Dockerfile ./create.sh
do
        echo "This userneme is not available."
        read -p "Enter username: " usn
done

read -p "Enter password: " pwad

while echo $pwad | grep -q $usn || grep -q $pwad ./Dockerfile ./create.sh
do
        echo "This password is not available."
        read -p "Enter password: " pwad
done

read -p "Enter the password again: " passagain

while [ "$passagain" != "$pwad" ]
do
        echo "Passwords do not match"
        read -p "Enter password: " pwad

        while echo $pwad | grep -q $usn || grep -q $pwad ./Dockerfile ./create.sh
        do
                echo "This password is not available."
                read -p "Enter password: " pwad
        done
        read -p "Enter the password again: " passagain
done


sed -i -e s/USN/$usn/g ./Dockerfile
sed -i -e s/PWAD/$pwad/g ./Dockerfile


sed -i -e s/USN/$usn/ ./reset.sh
sed -i -e s/PWAD/$pwad/ ./reset.sh

sed -i -e s/USN/$usn/g ./create.sh
sed -i -e s/PWAD/$pwad/g ./create.sh
