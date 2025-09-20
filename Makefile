DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
HOME_BREW_PREFIX := /home/linuxbrew/.linuxbrew
PATH := $(HOME_BREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(PATH)

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash \
	&& brew --version \
	&& grep -qxF 'eval "$$($(HOME_BREW_PREFIX)/bin/brew shellenv)"' ~/.bashrc \
	|| echo "\n"'eval "$$($(HOME_BREW_PREFIX)/bin/brew shellenv)"' >> ~/.bashrc \

brew-formulae: brew
	brew bundle --verbose --file install/Brewfile

brew-cask: brew
	brew bundle --verbose --file install/Caskfile

reset:
	test -z "$$(brew list --formulae)" || brew uninstall --ignore-dependencies $$(brew list --formulae)
	test -z "$$(brew list --cask)"     || brew uninstall $$(brew list --cask)
	brew cleanup --prune=all
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh | bash