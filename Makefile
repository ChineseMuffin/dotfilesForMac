DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
HOME_BREW_PREFIX := /home/linuxbrew/.linuxbrew
PATH := $(HOME_BREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(PATH)
OS := $(shell bin/is-supported bin/is-macos macos $(shell bin/is-supported bin/is-ubuntu ubuntu linux))

all: $(OS)

macos: brew-formulae brew-cask vscode

ubuntu: brew-formulae

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash \
	&& brew --version \
	&& grep -qxF 'eval "$$($(HOME_BREW_PREFIX)/bin/brew shellenv)"' ~/.bashrc \
	|| echo "\n"'eval "$$($(HOME_BREW_PREFIX)/bin/brew shellenv)"' >> ~/.bashrc \

brew-formulae: brew
	brew bundle --verbose --file install/Brewfile

# `mas` (Mac App Store) is macOS-only and should not run on Ubuntu or in CI.
# GitHub Actions sets CI=true, so we treat that as a signal to skip.
.PHONY: brew-mas
ifeq ($(OS),macos)
ifneq ($(CI),)
brew-mas: brew-formulae
	@echo "Skipping brew-mas in CI environment"
else
brew-mas: brew-formulae
	@echo "Running brew-mas (macOS only)"
	brew bundle --verbose --file install/Masfile
endif
else
brew-mas: brew-formulae
	@echo "Skipping brew-mas on $(OS)"
endif

brew-cask: brew
	brew bundle --verbose --file install/Caskfile

vscode: brew-cask
	cat install/vscode/list-extensions | xargs -L 1 -E 'EOF' code --install-extension

reset:
	test -z "$$(brew list --formulae)" || brew uninstall --ignore-dependencies $$(brew list --formulae)
	test -z "$$(brew list --cask)"     || brew uninstall $$(brew list --cask)
	brew cleanup --prune=all
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh | bash
