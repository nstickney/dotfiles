AddPackage ansible                   # Radically simple IT automation platform
AddPackage ansible-lint              # Checks playbooks for practices and behaviour that could potentially be improved.
AddPackage arduino                   # Arduino prototyping platform SDK
AddPackage cloc                      # Count lines of code
AddPackage docker                    # Pack, ship and run any application as a lightweight container
AddPackage pigz                      # docker opt dep
AddPackage --foreign eva             # simple calculator REPL, similar to bc(1)
AddPackage fd                        # Simple, fast and user-friendly alternative to find
AddPackage fzf                       # Command-line fuzzy finder
AddPackage git                       # the fast distributed version control system
AddPackage --foreign git-absorb      # git commit --fixup, but automatic
AddPackage git-filter-repo           # Quickly rewrite git repository history (filter-branch replacement)
AddPackage git-crypt                 # Transparent file encryption in Git
AddPackage hexyl                     # Colored command-line hex viewer
AddPackage hyperfine                 # A command-line benchmarking tool
AddPackage lldb                      # Next generation, high-performance debugger
AddPackage mercurial                 # A scalable distributed SCM tool
AddPackage namcap                    # A Pacman package analyzer
AddPackage nmap                      # Utility for network discovery and security auditing
AddPackage parallel                  # A shell tool for executing jobs in parallel
AddPackage perf                      # Linux kernel performance auditing tool
AddPackage ripgrep                   # A search tool that combines the usability of ag with the raw speed of grep
AddPackage rsync                     # A file transfer program to keep remote files in sync
AddPackage sshpass                   # Fool ssh into accepting an interactive password non-interactively
AddPackage strace                    # A diagnostic, debugging and instructional userspace tracer
AddPackage terraform                 # Tool for building, changing, and versioning infrastructure safely and efficiently
AddPackage tig                       # Text-mode interface for Git.
AddPackage tmux                      # A terminal multiplexer
AddPackage tokei                     # A blazingly fast CLOC (Count Lines Of Code) program
AddPackage tree                      # A directory listing program displaying a depth indented list of files
AddPackage valgrind                  # Tool to help find memory-management problems in programs
AddPackage vim                       # Vi Improved, a highly configurable, improved version of the vi text editor
AddPackage --foreign vim-ripgrep-git # Use RipGrep in Vim and display results in a quickfix list.
AddPackage vim-spell-en              # Language files for Vim spell checking
AddPackage watchexec                 # Executes commands in response to file modifications

# Debugging (and more!)
AddPackage gdb               # The GNU Debugger
AddPackage --foreign gef-git # Multi-Architecture GDB Enhanced Features for Exploiters & Reverse-Engineers
AddPackage python-keystone   # gef opt dep
AddPackage python-ropper     # gef opt dep
AddPackage peda              # Python Exploit Development Assistance for GDB
AddPackage pwndbg            # Makes debugging with GDB suck less

# Network Testing
AddPackage gnu-netcat # GNU rewrite of netcat, the network piping application
AddPackage ipguard    # arp<->ip relation checking tool
AddPackage vegeta     # HTTP load testing tool

# Programming Languages

### Shell (Ash, Bash, Dash)
AddPackage bash-bats            # Bash Automated Testing System
AddPackage bash-language-server # Bash language server implementation based on Tree Sitter and its grammar for Bash
AddPackage checkbashisms        # Debian script that checks for bashisms
AddPackage shellcheck           # Shell script analysis tool
AddPackage shfmt                # Format shell programs
AddPackage shellharden          # Bash linter and syntax highlighter

### C/C++
AddPackage clang      # C language family frontend for LLVM
AddPackage cppcheck   # A tool for static C/C++ code analysis
AddPackage flawfinder # Searches through source code for potential security flaws
AddPackage uncrustify # A source code beautifier

### Clojure
AddPackage clojure   # Lisp dialect for the JVM
AddPackage leiningen # Automate Clojure projects

### Docker
AddPackage --foreign hadolint-bin # Dockerfile linter, validate inline bash, written in Haskell

### English
AddPackage proselint # Linter for prose
# AddPackage --foreign vale-bin # A customizable, syntax-aware linter for prose

### Git
AddPackage --foreign gitlint # Git commit message linter

### Go
AddPackage delve                   # A debugger for the Go programming language.
AddPackage go                      # Core compiler tools for the Go programming language
AddPackage gopls                   # Language server for Go programming language
AddPackage --foreign goimports-git # Tool to fix (add, remove) your Go imports automatically.

### Graphviz
AddPackage graphviz # Graph visualization software

### HTML
AddPackage hq # HTML processor inspired by jq

### Java
AddPackage maven   # Java project management and project comprehension tool
AddPackage vim-jad # Automatically decompile Java class files and display Java code

### Javascript
AddPackage eslint            # An AST-based pattern checker for JavaScript
AddPackage npm               # A package manager for javascript
AddPackage npm-check-updates # Find newer versions of dependencies than what your package.json or bower.json allows
AddPackage jq                # Command-line JSON processor

### LaTeX
AddPackage texlab # A cross-platform implementation of the Language Server Protocol for LaTeX.

### Make
AddPackage --foreign checkmake # Experimental linter/analyzer for makefiles

### Maths
AddPackage octave # A high-level language, primarily intended for numerical computations.

### Multi-language
AddPackage meson    # High productivity build system
AddPackage prettier # An opinionated code formatter for JS, JSON, CSS, YAML and much more

### Perl
AddPackage perl-tidy # Parses and beautifies perl source

### Python
AddPackage autopep8               # A tool that automatically formats Python code to conform to the PEP 8 style guide
AddPackage python-isort           # A Python utility / library to sort Python imports.
AddPackage python-language-server # An implementation of the Language Server Protocol for Python
AddPackage python-matplotlib      # A python plotting library, making publication quality plots
AddPackage python-pyls-black      # Black plugin for the Python Language Server
AddPackage python-pip             # The PyPA recommended tool for installing Python packages
# AddPackage --foreign python-pgzero # A zero-boilerplate 2D games framework
AddPackage python-pytest # Simple powerful testing with Python
# AddPackage tk # A windowing toolkit for use with tcl (python turtles)
# AddPackage --foreign zerynth-studio # A powerful IDE for embedded programming in Python that enables the IoT

### Rust
AddPackage rust-analyzer # Experimental Rust compiler front-end for IDEs
AddPackage rust-racer    # Code completion for Rust
AddPackage rustup        # The Rust toolchain installer

### SCAD
AddPackage openscad # The programmers solid 3D CAD modeller

### Scala
AddPackage --foreign metals   # Language Server For Scala
AddPackage sbt                # The interactive build tool
AddPackage scala              # A Java-interoperable language with object-oriented and functional features
AddPackage --foreign scalafmt # code formatter for the Scala programming language

### SQL
AddPackage --foreign ruby-sqlint # Simple SQL linter supporting ANSI and PostgreSQL syntaxes
AddPackage --foreign sqlfmt-bin  # Experimental SQL formatter with width-aware output.

### VHDL
AddPackage ghdl-gcc # VHDL simulator (GCC backend)

### Vimscript
AddPackage --foreign vim-language-server # Vim language server
AddPackage vint                          # Lint tool for Vim script Language

### YAML
AddPackage yamllint # Linter for YAML files

# Don't install these in WSL
if grep -v -q microsoft /proc/version; then
	AddPackage code # The Open Source build of Visual Studio Code (vscode) editor

	# QMK Requirements
	AddPackage base-devel
	AddPackage clang
	AddPackage diffutils
	AddPackage git
	AddPackage unzip
	AddPackage wget
	AddPackage zip
	AddPackage arm-none-eabi-binutils
	AddPackage arm-none-eabi-gcc
	AddPackage arm-none-eabi-newlib
	AddPackage avrdude
	AddPackage avr-gcc
	AddPackage avr-libc
	AddPackage dfu-programmer
	AddPackage dfu-util
	AddPackage python-appdirs
	AddPackage python-argcomplete
	AddPackage python-colorama
	AddPackage --foreign python-dotty-dict
	AddPackage python-hjson
	AddPackage python-jsonschema
	AddPackage python-milc
	AddPackage python-pygments
fi
