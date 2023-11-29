#!/bin/bash

if [ -z "${nproc_value+x}" ] && [ -z "${half_nproc+x}" ]; then
    nproc_value=$(nproc)

    if [ "$nproc_value" -eq 1 ]; then
        half_nproc=1
    else
        half_nproc=$((nproc_value / 2))
    fi

    echo "export nproc_value=$nproc_value" >> ~/.zshrc
    echo "export half_nproc=$half_nproc" >> ~/.zshrc

    source ~/.bashrc
fi