AddPackage ansible                   # Radically simple IT automation platform
AddPackage ansible-lint              # Checks playbooks for practices and behaviour that could potentially be improved.
AddPackage arduino                   # Arduino prototyping platform SDK
AddPackage cloc                      # Count lines of code
AddPackage code                      # The Open Source build of Visual Studio Code (vscode) editor
AddPackage docker                    # Pack, ship and run any application as a lightweight container
AddPackage pigz                      # docker opt dep
AddPackage --foreign eva             # simple calculator REPL, similar to bc(1)
AddPackage fd                        # Simple, fast and user-friendly alternative to find
AddPackage fzf                       # Command-line fuzzy finder
AddPackage gdb                       # The GNU Debugger
AddPackage git                       # the fast distributed version control system
AddPackage git-crypt                 # Transparent file encryption in Git
AddPackage hexyl                     # Colored command-line hex viewer
AddPackage hyperfine                 # A command-line benchmarking tool
AddPackage namcap                    # A Pacman package analyzer
AddPackage nmap                      # Utility for network discovery and security auditing
AddPackage parallel                  # A shell tool for executing jobs in parallel
AddPackage peda                      # Python Exploit Development Assistance for GDB
AddPackage perf                      # Linux kernel performance auditing tool
AddPackage ripgrep                   # A search tool that combines the usability of ag with the raw speed of grep
AddPackage rsync                     # A file transfer program to keep remote files in sync
AddPackage sshpass                   # Fool ssh into accepting an interactive password non-interactively
AddPackage terraform                 # Tool for building, changing, and versioning infrastructure safely and efficiently
AddPackage tig                       # Text-mode interface for Git.
AddPackage tmux                      # A terminal multiplexer
AddPackage tree                      # A directory listing program displaying a depth indented list of files
AddPackage valgrind                  # Tool to help find memory-management problems in programs
AddPackage vim                       # Vi Improved, a highly configurable, improved version of the vi text editor
AddPackage --foreign vim-ripgrep-git # Use RipGrep in Vim and display results in a quickfix list.
AddPackage vim-spell-en              # Language files for Vim spell checking

# Network Testing
AddPackage gnu-netcat                  # GNU rewrite of netcat, the network piping application
AddPackage ipguard                     # arp<->ip relation checking tool
AddPackage --foreign python-locust-git # Scalable user load testing tool written in Python
AddPackage --foreign python-gevent-git # fix for locust + python 3.8
AddPackage vegeta                      # HTTP load testing tool

# Programming Languages

### Shell (Ash, Bash, Dash)
AddPackage bash-bats     # Bash Automated Testing System
AddPackage checkbashisms # Debian script that checks for bashisms
AddPackage shellcheck    # Shell script analysis tool
AddPackage shfmt         # Format shell programs
AddPackage shellharden   # Bash linter and syntax highlighter

### C/C++
AddPackage clang      # C language family frontend for LLVM
AddPackage cppcheck   # A tool for static C/C++ code analysis
AddPackage flawfinder # Searches through source code for potential security flaws
AddPackage uncrustify # A source code beautifier

### Docker
AddPackage --foreign hadolint-bin # Dockerfile linter, validate inline bash, written in Haskell

### English
AddPackage proselint # Linter for prose
# AddPackage --foreign vale-bin # A customizable, syntax-aware linter for prose

### Git
AddPackage --foreign gitlint # Git commit message linter

### Go
AddPackage delve                   # A debugger for the Go programming language.
AddPackage go-pie                  # Core compiler tools for the Go programming language (with PIE enabled by default)
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

### Multi-language
AddPackage meson    # High productivity build system
AddPackage prettier # An opinionated code formatter for JS, JSON, CSS, YAML and much more

### Perl
AddPackage perl-tidy # Parses and beautifies perl source

### Python
AddPackage autopep8     # A tool that automatically formats Python code to conform to the PEP 8 style guide
AddPackage python-black # Uncompromising Python code formatter
AddPackage python-isort # A Python utility / library to sort Python imports.
AddPackage python-jedi  # Awesome autocompletion for python
AddPackage python-pip   # The PyPA recommended tool for installing Python packages
# AddPackage --foreign python-pgzero # A zero-boilerplate 2D games framework
AddPackage python-pytest # Simple powerful testing with Python
# AddPackage tk # A windowing toolkit for use with tcl (python turtles)
# AddPackage --foreign zerynth-studio # A powerful IDE for embedded programming in Python that enables the IoT

### Rust
AddPackage rust       # Systems programming language focused on safety, speed and concurrency
AddPackage rust-racer # Code completion for Rust

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
AddPackage vint # Lint tool for Vim script Language

### YAML
AddPackage yamllint # Linter for YAML files
