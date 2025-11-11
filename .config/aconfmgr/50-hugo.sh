if ! DetectVM; then                           # Don't install except on actual workstations
	AddPackage asciidoctor                       # An implementation of AsciiDoc in Ruby
	AddPackage hugo                              # Fast and Flexible Static Site Generator in Go
	AddPackage ruby-rouge                        # Pure-ruby code highlighter that is compatible with pygments
	# AddPackage --foreign ruby-asciidoctor-html5s # Semantic HTML5 converter (backend) for Asciidoctor
fi
