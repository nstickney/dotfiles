AddPackage aha             # Ansi HTML Adapter: convert ANSI escape sequences to HTML.
AddPackage asciinema       # Record and share terminal sessions
AddPackage bash-completion # Programmable completion for the bash shell
AddPackage bat             # Cat clone with syntax highlighting and git integration
AddPackage colordiff       # A Perl script wrapper for 'diff' that produces the same output but with pretty 'syntax' highlighting
AddPackage dos2unix        # Text file format converter
AddPackage eva             # simple calculator REPL, similar to bc(1)
AddPackage eza             # ls replacement
AddPackage fd              # Simple, fast and user-friendly alternative to find
AddPackage fzf             # Command-line fuzzy finder
AddPackage git             # the fast distributed version control system
AddPackage git-absorb      # git commit --fixup, but automatic
AddPackage git-crypt       # Transparent file encryption in Git
AddPackage git-filter-repo # Quickly rewrite git repository history (filter-branch replacement)
AddPackage git-lfs         # Git extension for versioning large files
AddPackage hexyl           # Colored command-line hex viewer
AddPackage hq              # HTML processor inspired by jq
AddPackage htop            # Interactive process viewer
AddPackage jq              # Command-line JSON processor
AddPackage lesspipe        # an input filter for the pager less
AddPackage lsof            # Lists open files for running Unix processes
AddPackage man-db          # A utility for reading man pages
AddPackage man-pages       # Linux man pages
AddPackage mlocate         # Merging locate/updatedb implementation
AddPackage ncdu            # Disk usage analyzer with an ncurses interface
AddPackage parallel        # A shell tool for executing jobs in parallel
AddPackage pandoc-cli      # Conversion between document formats
AddPackage qrencode        # C library for encoding data in a QR Code symbol.
AddPackage ripgrep         # A search tool that combines the usability of ag with the raw speed of grep
AddPackage rmlint          # Tool to remove duplicates and other lint, being much faster than fdupes
AddPackage rsync           # A fast and versatile file copying tool for remote and local files
AddPackage tmux            # A terminal multiplexer
AddPackage tree            # A directory listing program displaying a depth indented list of files
AddPackage watchexec       # Executes commands in response to file modifications

# $EDITOR
AddPackage vim                        # Vi Improved, a highly configurable, improved version of the vi text editor
AddPackage vim-ale                    # Asynchronous Lint Engine with Language Server Protocol (LSP) support
AddPackage vim-ansible                # A vim plugin for syntax highlighting Ansible's common filetypes
AddPackage --foreign vim-pkgbuild-git # Vim plugin to edit PKGBUILD files
AddPackage vim-spell-en               # Language files for Vim spell checking
AddPackage vim-editorconfig           # EditorConfig plugin for Vim

## ALE: https://github.com/dense-analysis/ale/blob/master/supported-tools.md
AddPackage ansible-lint           # Checks playbooks for practices and behaviour that could potentially be improved.
AddPackage autopep8               # A tool that automatically formats Python code to conform to the PEP 8 style guide
AddPackage --foreign checkmake    # Experimental linter/analyzer for makefiles
AddPackage clang                  # C language family frontend for LLVM
AddPackage cppcheck               # A tool for static C/C++ code analysis
AddPackage flawfinder             # Searches through source code for potential security flaws
AddPackage --foreign gitlint      # Git commit message linter
AddPackage gopls                  # Language server for Go programming language
AddPackage --foreign hadolint-bin # Dockerfile linter, validate inline bash, written in Haskell
AddPackage --foreign metals       # Language Server For Scala
AddPackage perl-tidy              # Parses and beautifies perl source
# AddPackage --foreign proselint           # Linter for prose
AddPackage python-black              # Uncompromising Python code formatter
AddPackage python-isort              # A Python utility / library to sort Python imports.
AddPackage python-lsp-server         # Fork of the python-language-server project, maintained by the Spyder IDE team and the community
AddPackage --foreign ruby-sqlint     # Simple SQL linter supporting ANSI and PostgreSQL syntaxes
AddPackage rust-analyzer             # Experimental Rust compiler front-end for IDEs
AddPackage --foreign scalafmt        # code formatter for the Scala programming language
AddPackage shellcheck                # Shell script analysis tool
AddPackage shfmt                     # Format shell programs
AddPackage --foreign sqlfmt-bin      # Experimental SQL formatter with width-aware output.
AddPackage texlab                    # A cross-platform implementation of the Language Server Protocol for LaTeX.
AddPackage --foreign vim-ripgrep-git # Use RipGrep in Vim and display results in a quickfix list.
AddPackage uncrustify                # A source code beautifier
AddPackage vint                      # Lint tool for Vim script Language
AddPackage yamllint                  # Linter for YAML files

# Archives
AddPackage arj        # Free and portable clone of the ARJ archiver
AddPackage cabextract # A program to extract Microsoft cabinet (.CAB) files
AddPackage cpio       # A tool to copy files into or out of a cpio or tar archive
AddPackage lhasa      # Free LZH/LHA archive tool
AddPackage lrzip      # Multi-threaded compression with rzip/lzma, lzo, and zpaq
AddPackage pax        # Portable Archive Interchange - the POSIX standard archive tool for cpio and tar formats
AddPackage p7zip      # Command-line file archiver with high compression ratio
AddPackage rpmextract # Script to convert or extract RPM archives (contains rpm2cpio)
AddPackage sharutils  # Makes so-called shell archives out of many files
AddPackage unace      # An extraction tool for the proprietary ace archive format
AddPackage unrar      # The RAR uncompression program
AddPackage unzip      # For extracting and viewing files in .zip archives
AddPackage zip        # Compressor/archiver for creating and modifying zipfiles

# Benchmarking
AddPackage hyperfine # A command-line benchmarking tool
AddPackage perf      # Linux kernel performance auditing tool
AddPackage valgrind  # Tool to help find memory-management problems in programs
AddPackage vegeta    # HTTP load testing tool

# Debugging, reverse engineering, and binary exploitation
AddPackage checksec               # Tool designed to test which standard Linux OS and PaX security features are being used
AddPackage gdb                    # The GNU Debugger
AddPackage --foreign gef-git      # Multi-Architecture GDB Enhanced Features for Exploiters & Reverse-Engineers
AddPackage --foreign hexcurse-git # Versatile ncurses-based hex editor.
AddPackage python-keystone        # OPTIONAL DEPENDENCY (gef-git)
AddPackage lldb                   # Next generation, high-performance debugger
AddPackage metasploit             # Advanced open-source platform for developing, testing, and using exploit code
AddPackage mingw-w64-gcc          # Cross GCC for the MinGW-w64 cross-compiler
AddPackage peda                   # Python Exploit Development Assistance for GDB
AddPackage pwndbg                 # Makes debugging with GDB suck less
AddPackage ropper                 # Show information about binary files and find gadgets to build rop chains for different architectures
AddPackage radare2                # Open-source tools to disasm, debug, analyze and manipulate binary files
AddPackage ropgadget              # Search gadgets in binaries to facilitate ROP exploitation for several file formats and architectures
AddPackage strace                 # A diagnostic, debugging and instructional userspace tracer
AddPackage xortool                # Tool to analyze multi-byte XOR cipher

# Forensics
AddPackage binwalk                           # A tool for searching a given binary image for embedded files
AddPackage mtd-utils                         # OPTIONAL DEPENDENCY (binwalk)
AddPackage foremost                          # A console program to recover files based on their headers, footers, and internal data structures
AddPackage --foreign python-msoffcrypto-tool # A Python tool and library for decrypting encrypted MS Office files.
AddPackage --foreign scalpel-git             # Recover files based on their headers, footers and internal data structures. This program is based on Foremost.
AddPackage sleuthkit                         # File system and media management forensic analysis tools
AddPackage volatility3                       # Advanced memory forensics framework

# Games
AddPackage crawl-ncurses # Dungeon Crawl Stone Soup: open-source, single-player, role-playing roguelike game of exploration and treasure-hunting (ncurses version)

# Images
AddPackage gifsicle            # A powerful command-line program for creating, editing, manipulating and getting information about GIF images and animations
AddPackage jp2a                # A small utility for converting JPG images to ASCII
AddPackage jpegoptim           # Jpeg optimisation utility
AddPackage optipng             # Compresses PNG files to a smaller size, without losing any information.
AddPackage perl-image-exiftool # Reader and rewriter of EXIF informations that supports raw files
AddPackage --foreign pngcheck  # Verifies the integrity of PNG, JNG and MNG files by checking the CRCs and decompressing the image data
AddPackage svgcleaner          # An application that cleans svg images from unnecessary data in batch mode.

# Messaging
AddPackage aerc                    # Email Client for your Terminal
AddPackage w3m                     # OPTIONAL DEPENDENCY (aerc)
AddPackage --foreign hydroxide-git # A third-party, open-source ProtonMail CardDAV, IMAP and SMTP bridge
AddPackage irssi                   # Modular text mode IRC client with Perl scripting
# AddPackage --foreign python-cleantoots # Cleanup your toot history

# Network
AddPackage aria2              # Download utility that supports HTTP(S), FTP, BitTorrent, and Metalink
AddPackage bmon               # Portable bandwidth monitor and rate estimator
AddPackage dog                # Command-line DNS client like dig
AddPackage --foreign gmni-git # A Gemini client
AddPackage inetutils          # A collection of common network programs
AddPackage iperf3             # TCP, UDP, and SCTP network bandwidth measurement tool
AddPackage ipguard            # ipguard - arp<->ip relation checking tool
AddPackage masscan            # TCP port scanner, spews SYN packets asynchronously, scanning entire Internet in under 5 minutes
AddPackage mtr                # Combines the functionality of traceroute and ping into one tool (CLI version)
AddPackage ncrack             # High-speed network authentication cracking tool
AddPackage --foreign nessus   # Nessus vulnerability scanner
AddPackage netsniff-ng        # High performance Linux network sniffer for packet inspection
AddPackage ngrep              # A grep-like utility that allows you to search for network packets on an interface.
AddPackage nikto              # A web server scanner which performs comprehensive tests against web servers for multiple items
AddPackage nmap               # Utility for network discovery and security auditing
AddPackage openbsd-netcat     # TCP/IP swiss army knife. OpenBSD variant.
AddPackage p0f                # Purely passive TCP/IP traffic fingerprinting tool
AddPackage proxychains-ng     # A hook preloader that allows to redirect TCP traffic of existing dynamically linked programs through one or more SOCKS or HTTP proxies
CopyFile /etc/proxychains.conf
AddPackage scapy         # Powerful interactive packet manipulation program written in Python (tools)
AddPackage sniffglue     # Secure multithreaded packet sniffer
AddPackage speedtest-cli # Command line interface for testing internet bandwidth using speedtest.net
AddPackage sqlmap        # Automatic SQL injection and database takeover tool
AddPackage tcpdump       # Powerful command-line packet analyzer
AddPackage traceroute    # Tracks the route taken by packets over an IP network
AddPackage vulscan       # A module which enhances nmap to a vulnerability scanner
AddPackage wireshark-cli # Network traffic and protocol analyzer/sniffer - CLI tools and data files
AddPackage wget          # Network utility to retrieve files from the Web
AddPackage whois         # Intelligent WHOIS client
AddPackage youtube-dl    # A command-line program to download videos from YouTube.com and a few more sites

# Programming
AddPackage cloc  # Count lines of code
AddPackage meson # High productivity build system
AddPackage tokei # A blazingly fast CLOC (Count Lines Of Code) program

## Bash
AddPackage checkbashisms # Debian script that checks for bashisms

## Clojure
AddPackage clojure   # Lisp dialect for the JVM
AddPackage leiningen # Automate Clojure projects

## DOT
AddPackage graphviz # Graph visualization software

## Go
AddPackage delve    # A debugger for the Go programming language.
AddPackage go       # Core compiler tools for the Go programming language
AddPackage go-tools # Developer tools for the Go programming language

## Java
AddPackage maven   # Java project management and project comprehension tool
AddPackage vim-jad # Automatically decompile Java class files and display Java code

## Javascript
AddPackage npm # A package manager for javascript

## Octave
AddPackage octave # A high-level language, primarily intended for numerical computations.

## Python
AddPackage python-matplotlib # A python plotting library, making publication quality plots

## Rust
AddPackage rustup # The Rust toolchain installer

## Scala
AddPackage coursier        #  	Pure Scala Artifact Fetching
AddPackage sbt             # The interactive build tool
AddPackage --foreign scala # A Java-interoperable language with object-oriented and functional features

# Security
if ! DetectWSL; then
	AddPackage john                # John the Ripper password cracker
	AddPackage lynis               # Security and system auditing tool to harden Unix/Linux systems
	AddPackage rkhunter            # Checks machines for the presence of rootkits and other unwanted tools.
	AddPackage --foreign wordlists # Download a great set of wordlists. In /usr/share/wordlists
fi

# System monitoring

# Web browsers
AddPackage amfora # Terminal browser for the Gemini protocol
AddPackage lynx   # A text browser for the World Wide Web
