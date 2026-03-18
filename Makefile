DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell bin/is-supported bin/is-macos macos $(shell bin/is-supported bin/is-ubuntu ubuntu linux))
ifeq ($(OS),macos)
HOME_BREW_PREFIX := /opt/homebrew
else
HOME_BREW_PREFIX := /home/linuxbrew/.linuxbrew
endif
PATH := $(HOME_BREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(PATH)

all: $(OS)

macos: brew-formulae brew-cask vscode brew-mas

ubuntu: brew-formulae

brew:
	is-executable $(HOME_BREW_PREFIX)/bin/brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash \
	&& $(HOME_BREW_PREFIX)/bin/brew --version \
	&& grep -qxF 'eval "$$($(HOME_BREW_PREFIX)/bin/brew shellenv)"' ~/.bashrc \
	|| echo "\n"'eval "$$($(HOME_BREW_PREFIX)/bin/brew shellenv)"' >> ~/.bashrc \

brew-formulae: brew
	$(HOME_BREW_PREFIX)/bin/brew bundle --verbose --file install/Brewfile

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
	$(HOME_BREW_PREFIX)/bin/brew bundle --verbose --file install/Masfile
endif
else
brew-mas: brew-formulae
	@echo "Skipping brew-mas on $(OS)"
endif

brew-cask: brew
	$(HOME_BREW_PREFIX)/bin/brew bundle --verbose --file install/Caskfile

vscode: brew-cask
	cat install/vscode/list-extensions | xargs -L 1 -E 'EOF' $(HOME_BREW_PREFIX)/bin/code --install-extension

reset:
	test -z "$$($(HOME_BREW_PREFIX)/bin/brew list --formulae)" || $(HOME_BREW_PREFIX)/bin/brew uninstall --ignore-dependencies $$($(HOME_BREW_PREFIX)/bin/brew list --formulae)
	test -z "$$($(HOME_BREW_PREFIX)/bin/brew list --cask)"     || $(HOME_BREW_PREFIX)/bin/brew uninstall $$($(HOME_BREW_PREFIX)/bin/brew list --cask)
	$(HOME_BREW_PREFIX)/bin/brew cleanup --prune=all
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh | bash
