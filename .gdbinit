# https://infosecwriteups.com/pwndbg-gef-peda-one-for-all-and-all-for-one-714d71bf36b8

define init-gef
source /usr/share/gef/gef.py
end
document init-gef
Initializes GEF (GDB Enhanced Features)
end

define init-peda
source /usr/share/peda/peda.py
end
document init-peda
Initializes the PEDA (Python Exploit Development Assistant for GDB) framework
end

define init-pwndbg
source /usr/share/pwndbg/gdbinit.py
end
document init-pwndbg
Initializes PwnDBG
end
