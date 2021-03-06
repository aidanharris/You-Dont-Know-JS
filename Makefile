current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_path := $(shell dirname $(mkfile_path))
.PHONY: clean setup build
all: clean setup build
build:
	cd "$(mkfile_path)/build"; \
		$(mkfile_path)/makeEbook.sh "$$(pwd)"
setup:
	cd $(mkfile_path); \
	mkdir "$(mkfile_path)/build"; \
	cp -R "$(mkfile_path)/You-Dont-Know-JS"/* "$(mkfile_path)/build/"; \
	mkdir "$(mkfile_path)/build/epubs"; \
	find "$(mkfile_path)/build" -name "*.md" -not -path "*/README.md" -exec $(mkfile_path)/fixImages.py {} \; -execdir sh -c '$(mkfile_path)/makeMetadata.py "$$(pwd)" "$$(pwd)"' \;
	find "$(mkfile_path)/build" -name "README.md" -delete;
clean:
	rm -rf "$(mkfile_path)/build"
