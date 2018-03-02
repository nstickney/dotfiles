# shellcheck disable=SC2148
if [[ "$HOSTNAME" == "elisha" || \
      "$HOSTNAME" == "eli" || \
      "$HOSTNAME" == "eliab" || \
      "$HOSTNAME" == "elim" ]]
then
    ### Arch Linux Packages
    AddPackage --foreign pkgbuild-introspection # Tools for generating .SRCINFO files and PKGBUILD data extraction (mkaurball)

    ### C and C++
    AddPackage cppunit # A C++ unit testing framework
    # AddPackage eclipse-cpp # Highly extensible IDE (CPP variant)
    AddPackage gdb # The GNU Debugger
    AddPackage gtest # Google Test - C++ testing utility based on the xUnit framework (like JUnit)
    AddPackage --foreign lcov # front-end for GCC's coverage testing tool gcov

    ### Code Counting
    AddPackage cloc # Count lines of code
    AddPackage sloccount # Tools for counting physical source lines of code
    # AddPackage --foreign loc # Count lines of code quickly

    ### Diagramming
    # AddPackage --foreign visual-paradigm-community # UML design application
    # AddPackage --foreign yed # Very powerful graph editor written in java

    ### GeoTIFF
    # AddPackage --foreign qgis # Geographic Information System (GIS) that supports vector, raster & database formats

    ### Git
    #AddPackage --foreign git-aurcheck # a helper like namcap that checks and offers solutions for common problems in git submissions to the AUR
    AddPackage tig # Text-mode interface for Git.
    

    ### GPU Programming on NVIDIA
    # AddPackage cuda # NVIDIA's GPU programming toolkit
    # AddPackage opencl-nvidia # OpenCL implementation for NVIDIA

    ### Java
    AddPackage eclipse-jee # Highly extensible IDE (JEE variant)
    AddPackage jdk8-openjdk # OpenJDK Java 8 full runtime environment
    AddPackage --foreign intellij-idea-ultimate-edition # An intelligent IDE for Java, Groovy and other programming languages with advanced refactoring features intensely focused on developer productivity.
    AddPackage --foreign jmeter # A Java desktop application designed to load test functional behavior and measure performance
    AddPackage visualvm # Visual tool integrating several command-line JDK tools and lightweight profiling capabilities

    ### JavaScript
    AddPackage npm # A package manager for JavaScript
    # AddPackage --foreign visual-studio-code # Visual Studio Code

    ### Matlab / Octave
    AddPackage octave # A high-level language, primarily intended for numerical computations.
    AddPackage fig2dev # octave opt dep
    AddPackage --foreign epstool # octave opt dep
    AddPackage --foreign octave-statistics # Additional statistics functions for Octave.

    ### Network Testing
    AddPackage gnu-netcat # GNU rewrite of netcat, the network piping application
    AddPackage metasploit # Advanced open-source platform for developing, testing, and using exploit code
    AddPackage nmap # Utility for network discovery and security auditing
    AddPackage vulscan # A module which enhances nmap to a vulnerability scanner
    AddPackage wireshark-gtk # a free network protocol analyzer for Unix/Linux and Windows - GTK frontend
    AddPackage geoip-database-extra # wireshark-gtk opt dep

    # OpenVAS
    AddPackage greenbone-security-assistant # Greenbone Security Assistant (gsa) - OpenVAS web frontend
    AddPackage openvas-cli # The OpenVAS Command-Line Interface
    AddPackage openvas-libraries # The OpenVAS libraries
    AddPackage openvas-manager # A layer between the OpenVAS Scanner and various client applications
    AddPackage openvas-scanner # The OpenVAS scanning Daemon

    ### Python
    AddPackage python-pip # The PyPA recommended tool for installing Python packages
    # AddPackage spyder3 # Scientific PYthon Development EnviRonment providing MATLAB-like features for Python 3.x series.
    AddPackage python-numpy # spyder3 opt dep
    AddPackage python-scipy # spyder3 opt dep
    AddPackage python-h5py # spyder3 opt dep
    AddPackage python-matplotlib # spyder3 opt dep
    AddPackage python-pandas # spyder3 opt dep
    AddPackage python-sympy # spyder3 opt dep
    AddPackage pycharm-community-edition # Python IDE for Professional Developers
    # AddPackage --foreign pycharm-professional # Powerful Python and Django IDE. Professional edition.
    # AddPackage --foreign python-keras # Deep Learning library (convnets, recurrent neural networks, and more)
    # AddPackage python-scikit-learn # A set of python modules for machine learning and data mining
    # AddPackage --foreign python-theano # Definition and optimized evaluation of mathematical expressions on Numpy arrays.
    # AddPackage --foreign python-tifffile # Read and write image data from and to TIFF files

    ### Web
    AddPackage pgadmin4 # Comprehensive design and management interface for PostgreSQL
    AddPackage postgresql # Sophisticated object-relational DBMS
    # AddPackage --foreign wildfly # Wildfly Application Server

    ### Machine Installations
    AddPackage --foreign woeusb-git # A Linux program to create Windows USB stick installer from a real Windows DVD or an image
fi
