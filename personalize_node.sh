#!/bin/bash

[[ -z $NODE ]] && echo 'Missing $NODE' && exit 1;

tar -C ~ --exclude='.git' -czvf - .bash_aliases .vimrc .vim .gitconfig | ssh $NODE "cat > p.tgz" 
ssh $NODE 'tar xzf p.tgz'
ssh $NODE 'sudo tar -C /root -xzf p.tgz'
ssh $NODE 'echo ". ~/.bash_aliases" >> ~/.bashrc'
ssh $NODE 'echo ". ~/.bash_aliases" | sudo tee -a /root/.bashrc'
