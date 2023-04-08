#!/bin/bash

sed -i -e s/USN/USN/g ./Dockerfile
sed -i -e s/PWAD/PWAD/g ./Dockerfile

sed -i -e s/USN/USN/ ./create.sh
sed -i -e s/PWAD/PWAD/ ./create.sh

sed -i -e s/USN/USN/ ./reset.sh
sed -i -e s/PWAD/PWAD/ ./reset.sh

