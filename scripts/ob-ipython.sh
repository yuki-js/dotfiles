#!/usr/bin/env bash

SSH_HOST=ubuntu
REMOTE_KERNEL_FILE=/tmp/kernel-remote.json
REMOTE_KERNEL_FILE_IN_LOCAL=/tmp/kernel.json
LOCAL_KERNEL_FILE=/tmp/kernel-ssh.json

ssh $SSH_HOST /home/yjsnpi/miniconda3/envs/dev/bin/ipython kernel -f $REMOTE_KERNEL_FILE 2>&1 &
scp $SSH_HOST:$REMOTE_KERNEL_FILE $REMOTE_KERNEL_FILE_IN_LOCAL

jupyter console --existing $REMOTE_KERNEL_FILE_IN_LOCAL --ssh $SSH_HOST --simple-prompt --no-confirm-exit
