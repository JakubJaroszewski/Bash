#!/bin/bash

echo "Liczba argumentow: $#"
echo "Drugi argument: $2"
echo "zmienne srodowskowe"
printenv | grep $USER
