if ! DetectVM || DetectWSL; then # Install on workstations and WSL
	AddPackage pandoc               # Conversion between markup formats
	AddPackage pandoc-crossref      # Pandoc filter for cross-references
	AddPackage texlive-core         # TeX Live core distribution
	AddPackage texlive-fontsextra   # TeX Live - all sorts of extra fonts
	AddPackage texlive-latexextra   # TeX Live - Large collection of add-on packages for LaTeX
fi
