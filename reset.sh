#!/bin/bash

sed -i -e s/chan/USN/g ./Dockerfile
sed -i -e s/pass1/PWAD/g ./Dockerfile

sed -i -e s/chan/USN/ ./create.sh
sed -i -e s/pass1/PWAD/ ./create.sh

sed -i -e s/chan/USN/ ./reset.sh
sed -i -e s/pass1/PWAD/ ./reset.sh

