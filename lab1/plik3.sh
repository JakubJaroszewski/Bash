#!/bin/bash


if test -e ~/.xsession-errors
then
 echo "istnieje"
else
 echo "nie istnieje"
fi

 zm=$(ls -l ./ | wc -l)
 zm1=$(ls -l ${HOME} | wc -l)
if [ $zm -eq $zm1 ] 
then
 echo "taka sama"
else
 echo "rozna"
fi 
