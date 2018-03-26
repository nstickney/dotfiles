# shellcheck disable=SC2148
if [[ "$HOSTNAME" == "elisha" || \
      "$HOSTNAME" == "eli" || \
      "$HOSTNAME" == "eliab" || \
      "$HOSTNAME" == "elim" ]]
then
    ### Arch Linux Packages
    AddPackage --foreign pkgbuild-introspection # Tools for generating .SRCINFO files and PKGBUILD data extraction (mkaurball)

    ### C and C++
    AddPackage cppcheck # A tool for static C/C++ code analysis
    AddPackage cppunit # A C++ unit testing framework
    # AddPackage eclipse-cpp # Highly extensible IDE (CPP variant)
    AddPackage gdb # The GNU Debugger
    AddPackage gtest # Google Test - C++ testing utility based on the xUnit framework (like JUnit)
    AddPackage splint # A tool for statically checking C programs for security vulnerabilities and coding mistakes
    AddPackage --foreign lcov # front-end for GCC's coverage testing tool gcov

    ### Code Counting
    AddPackage cloc # Count lines of code
    AddPackage sloccount # Tools for counting physical source lines of code
    # AddPackage --foreign loc # Count lines of code quickly

    ### Diagramming
    # AddPackage --foreign visual-paradigm-community # UML design application
    # AddPackage --foreign yed # Very powerful graph editor written in java

    ### Docker
    AddPackage docker # Pack, ship and run any application as a lightweight container
    AddPackage docker-compose # Fast, isolated development environments using Docker
    AddPackage docker-machine # Machine management for a container-centric world
    CopyFile /etc/docker/key.json 600
    CopyFile /etc/systemd/system/docker.service.d/override.conf
    SetFileProperty /etc/docker mode 700

    ### GeoTIFF
    # AddPackage --foreign qgis # Geographic Information System (GIS) that supports vector, raster & database formats

    ### Git
    #AddPackage --foreign git-aurcheck # a helper like namcap that checks and offers solutions for common problems in git submissions to the AUR
    AddPackage tig # Text-mode interface for Git.
    

    ### GPU Programming on NVIDIA
    # AddPackage cuda # NVIDIA's GPU programming toolkit
    # AddPackage opencl-nvidia # OpenCL implementation for NVIDIA

    ### HTML
    AddPackage --foreign htmlhint # tatic Code Analysis Tool for HTML, you can use it with IDE or in build system
    AddPackage tidy # A tool to tidy down your HTML code to a clean style

    ### Java
    # AddPackage eclipse-jee # Highly extensible IDE (JEE variant)
    AddPackage jdk8-openjdk # OpenJDK Java 8 full runtime environment
    # AddPackage --foreign checkstyle # A tool to help programmers write Java code that adheres to a coding standard
    # AddPackage --foreign google-java-format-git # Reformats Java source code to comply with Google Java Style
    AddPackage --foreign intellij-idea-ultimate-edition # An intelligent IDE for Java, Groovy and other programming languages with advanced refactoring features intensely focused on developer productivity.
    AddPackage --foreign jmeter # A Java desktop application designed to load test functional behavior and measure performance
	AddPackage maven # A Java project management and project comprehension tool
    AddPackage visualvm # Visual tool integrating several command-line JDK tools and lightweight profiling capabilities
	AddPackage --foreign wildfly # Wildfly Application Server

    ### JavaScript
    AddPackage eslint # An AST-based pattern checker for JavaScript
    AddPackage npm # A package manager for JavaScript
    AddPackage prettier # An opinionated code formatter for JavScript, ES2017, JSX, Flow, TypeScript, JSON, CSS, LESS, SCSS, GraphQL, Markdown
    # AddPackage --foreign visual-studio-code # Visual Studio Code

    ### Haskell (??)
    # AddPackage hlint # Source code suggestions

    ### Matlab / Octave
    AddPackage octave # A high-level language, primarily intended for numerical computations.
    AddPackage fig2dev # octave opt dep
    AddPackage --foreign epstool # octave opt dep
    AddPackage --foreign octave-statistics # Additional statistics functions for Octave.

    ### Network Testing
    AddPackage gnu-netcat # GNU rewrite of netcat, the network piping application
    AddPackage ipguard # arp<->ip relation checking tool
    AddPackage metasploit # Advanced open-source platform for developing, testing, and using exploit code
    AddPackage nmap # Utility for network discovery and security auditing
    AddPackage vulscan # A module which enhances nmap to a vulnerability scanner
    AddPackage wireshark-gtk # a free network protocol analyzer for Unix/Linux and Windows - GTK frontend
    AddPackage geoip-database-extra # wireshark-gtk opt dep

    ### OpenVAS
    AddPackage greenbone-security-assistant # Greenbone Security Assistant (gsa) - OpenVAS web frontend
    AddPackage openvas-cli # The OpenVAS Command-Line Interface
    AddPackage openvas-libraries # The OpenVAS libraries
    AddPackage openvas-manager # A layer between the OpenVAS Scanner and various client applications
    AddPackage openvas-scanner # The OpenVAS scanning Daemon

    ### Python
    AddPackage bandit # Python security linter from OpenStack Security
    AddPackage python-pip # The PyPA recommended tool for installing Python packages
    AddPackage python-pylint # Analyzes Python code looking for bugs and signs of poor quality
    # AddPackage spyder3 # Scientific PYthon Development EnviRonment providing MATLAB-like features for Python 3.x series.
    # AddPackage python-numpy # spyder3 opt dep
    # AddPackage python-scipy # spyder3 opt dep
    # AddPackage python-h5py # spyder3 opt dep
    # AddPackage python-matplotlib # spyder3 opt dep
    # AddPackage python-pandas # spyder3 opt dep
    # AddPackage python-sympy # spyder3 opt dep
    AddPackage pycharm-community-edition # Python IDE for Professional Developers
    # AddPackage --foreign pycharm-professional # Powerful Python and Django IDE. Professional edition.
    # AddPackage --foreign python-keras # Deep Learning library (convnets, recurrent neural networks, and more)
    # AddPackage python-scikit-learn # A set of python modules for machine learning and data mining
    # AddPackage --foreign python-theano # Definition and optimized evaluation of mathematical expressions on Numpy arrays.
    # AddPackage --foreign python-tifffile # Read and write image data from and to TIFF files

    ### SQL
	AddPackage mariadb-clients # MariaDB client tools
    # AddPackage pgadmin4 # Comprehensive design and management interface for PostgreSQL
    # AddPackage postgresql # Sophisticated object-relational DBMS

    ### YAML
    AddPackage --foreign yamllint # A linter for YAML files

    ### Machine Installations
    AddPackage --foreign woeusb-git # A Linux program to create Windows USB stick installer from a real Windows DVD or an image
fi
