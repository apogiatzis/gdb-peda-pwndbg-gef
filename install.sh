#!/bin/sh

echo "[+] Checking for required dependencies..."
if command -v git >/dev/null 2>&1 ; then
    echo "[-] Git found!"
else
    echo "[-] Git not found! Aborting..."
    echo "[-] Please install git and try again."
fi

if [ -f ~/.gdbinit ] || [ -h ~/.gdbinit ]; then
    echo "backing up gdbinit file"
    cp ~/.gdbinit ~/.gdbinit.back_up
fi


echo "[+] Downloading PEDA..."
git clone https://github.com/longld/peda.git $PWD/peda


echo "[+] Downloading Pwndbg..."
git clone https://github.com/pwndbg/pwndbg.git $PWD/pwndbg
sh $PWD/pwndbg/setup.sh


echo "[+] Downloading GEF..."
git clone https://github.com/hugsy/gef.git $PWD/gef


echo "[+] Setting .gdbinit..."
cp gdbinit ~/.gdbinit

{
  echo "[+] Creating files..."
    sudo cp gdb-peda /usr/bin/gdb-peda &&\
    sudo cp gdb-pwndbg /usr/bin/gdb-pwndbg &&\
    sudo cp gdb-gef /usr/bin/gdb-gef
} || {
  echo "[-] Permission denied"
    exit
}

{
  echo "[+] Setting permissions..."
    sudo chmod +x /usr/bin/gdb-*
} || {
  echo "[-] Permission denied"
    exit
}

echo "[+] Done"
