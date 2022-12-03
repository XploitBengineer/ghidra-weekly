#!/bin/bash


build_ghidra()
{
    add-apt-repository ppa:openjdk-r/ppa
    add-apt-repository ppa:cwchien/gradle
    apt update
    apt install -y default-jre gradle-ppa # https://github.com/gradle/gradle/issues/773
    apt install openjdk-11-jdk
    apt install openjdk-11-jre
    
    git clone https://github.com/NationalSecurityAgency/ghidra.git
    cd ghidra
    gradle --init-script gradle/support/fetchDependencies.gradle init
    gradle buildGhidra

}

updated_last_day=$(curl -s https://api.github.com/repos/NationalSecurityAgency/ghidra/commits/master | jq -r "((now - (.commit.author.date | fromdateiso8601) )  / (60*60*24)  | trunc)")

if [ "$updated_last_day" -gt "0" ]
then
    build_ghidra
fi

