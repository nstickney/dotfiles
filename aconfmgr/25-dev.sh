# Basic tools
AddPackage bat # Cat clone with syntax highlighting and git integration
AddPackage cloc # Count lines of code
AddPackage code # The Open Source build of Visual Studio Code (vscode) editor
AddPackage ctags # Generates an index file of language objects found in source files
AddPackage fd # Simple, fast and user-friendly alternative to find
AddPackage fzf # Command-line fuzzy finder
AddPackage gdb # The GNU Debugger
AddPackage git # the fast distributed version control system
AddPackage git-crypt # Transparent file encryption in Git
AddPackage --foreign gotop-bin # A terminal based graphical activity monitor inspired by gtop and vtop
AddPackage --foreign lf # A terminal file manager inspred by ranger written in Go
AddPackage nmap # Utility for network discovery and security auditing
AddPackage parallel # A shell tool for executing jobs in parallel
AddPackage peda # Python Exploit Development Assistance for GDB
AddPackage ripgrep # A search tool that combines the usability of ag with the raw speed of grep
AddPackage rsync # A file transfer program to keep remote files in sync
AddPackage tig # Text-mode interface for Git.
AddPackage tmux # A terminal multiplexer
AddPackage tree # A directory listing program displaying a depth indented list of files
AddPackage vim # Vi Improved, a highly configurable, improved version of the vi text editor
AddPackage vim-spell-en # Language files for Vim spell checking
AddPackage vis # modern, legacy free, simple yet efficient vim-like editor

# Remote admin
if [ "$USER" == 'stick' ]; then
	AddPackage hyperfine # A command-line benchmarking tool
	AddPackage namcap # A Pacman package analyzer
	AddPackage sshpass # Fool ssh into accepting an interactive password non-interactively
	AddPackage terraform # Tool for building, changing, and versioning infrastructure safely and efficiently
	AddPackage valgrind # Tool to help find memory-management problems in programs

	# Network Testing
	AddPackage gnu-netcat # GNU rewrite of netcat, the network piping application
	AddPackage ipguard # arp<->ip relation checking tool
	AddPackage vegeta # HTTP load testing tool

	# Programming Languages

	### Bash
	AddPackage bash-bats # Bash Automated Testing System
	AddPackage checkbashisms # Debian script that checks for bashisms
	AddPackage shellcheck # Shell script analysis tool
	AddPackage shellharden # Bash linter and syntax highlighter

	### C/C++
	AddPackage cmake # A cross-platform open-source make system
	AddPackage cppcheck # A tool for static C/C++ code analysis
	AddPackage flawfinder # Searches through source code for potential security flaws

	### Go
	AddPackage delve # A debugger for the Go programming language.
	AddPackage go # Core compiler tools for the Go programming language

	### Java
	AddPackage maven # Java project management and project comprehension tool
	AddPackage vim-jad # Automatically decompile Java class files and display Java code

	### Javascript
	AddPackage npm # A package manager for javascript
	AddPackage eslint # An AST-based pattern checker for JavaScript

	### HTML/CSS
	AddPackage tidy # A tool to tidy down your HTML code to a clean style

	### Multi-language
	AddPackage astyle # A free, fast and small automatic formatter for C, C++, C#, and Java source code.
	AddPackage meson # High productivity build system
	AddPackage prettier # An opinionated code formatter for JS, JSON, CSS, YAML and much more

	### Perl
	AddPackage perl-tidy # Parses and beautifies perl source

	### Python
	AddPackage autopep8 # A tool that automatically formats Python code to conform to the PEP 8 style guide
	AddPackage flake8 # The modular source code checker: pep8, pyflakes and co
	AddPackage python-pip # The PyPA recommended tool for installing Python packages
	AddPackage python-pycodestyle # Python style guide checker
	AddPackage python-pytest # Simple powerful testing with Python
	AddPackage tk # A windowing toolkit for use with tcl (python turtles)
	AddPackage vim-jedi # Vim plugin for jedi, an awesome Python autocompletion
	AddPackage yapf # Python style guide checker

	### Rust
	AddPackage rust # Systems programming language focused on safety, speed and concurrency

	### Scala
	AddPackage sbt # The interactive build tool

	### Vimscript
	AddPackage vint # Lint tool for Vim script Language
fi
