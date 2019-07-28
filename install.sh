#!/bin/sh

echo "[+] Checking for required dependencies..."
if command -v git >/dev/null 2>&1 ; then
    echo "[-] Git found!"
else
    echo "[-] Git not found! Aborting..."
    echo "[-] Please install git and try again."
fi

echo "[+] Downloading PEDA..."
git clone https://github.com/longld/peda.git ~/peda

echo "[+] Downloading Pwndbg..."
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh
cd ..
rm -rf pwndbg

echo "[+] Downloading GEF..."
wget -q -O ~/.gdbinit-gef.py https://github.com/hugsy/gef/raw/master/gef.py
echo source ~/.gdbinit-gef.py >> ~/.gdbinit

echo "[+] Setting .gdbinit..."
cp gdbinit ~/.gdbinit

echo "[+] Creating files..."
cp gdb-peda /usr/bin/gdb-peda
cp gdb-pwndbg /usr/bin/gdb-pwndbg
cp gdb-gef /usr/bin/gdb-gef

echo "[+] Setting permissions..."
chmod +x /usr/bin/gdb-*

echo "[+] Done"
