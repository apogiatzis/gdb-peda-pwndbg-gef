#!/bin/sh

echo "[+] Checking for required dependencies..."
if command -v git >/dev/null 2>&1 ; then
    echo "[-] Git found!"
else
    echo "[-] Git not found! Aborting..."
    echo "[-] Please install git and try again."
fi

rm ~/.gdbinit

echo "[+] Downloading PEDA..."
git clone https://github.com/longld/peda.git ~/peda

echo "[+] Downloading Pwndbg..."
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh
cd ..
mv pwndbg ~/pwndbg-src 
echo "source ~/pwndbg-src/gdbinit.py" > ~/.gdbinit_pwndbg

echo "[+] Downloading GEF..."
wget -q -O ~/.gdbinit-gef.py https://github.com/hugsy/gef/raw/master/gef.py
echo source ~/.gdbinit-gef.py >> ~/.gdbinit

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
