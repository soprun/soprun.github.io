#######################################################################
# Define default values
#######################################################################

SHELL := /bin/bash
DIR := $(shell cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
# Self-Documented Makefile see https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
MAKEFILE_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT_REV := $(shell git rev-list --tags --max-count=1)
GIT_BRANCHES := $(shell git rev-list --branches --max-count=1)
GIT_TAG := $(shell git describe --tags ${REV})
GIT_SHORT_TAG := $(shell git rev-parse --short HEAD)

COLOR_RESET := \033[0m
COLOR_RED := \033[0;31m
COLOR_YELLOW := \033[0;33m
COLOR_GREEN := \033[0;32m
COLOR_BLUE := \033[0;34m

#######################################################################
# Load environment variables
#######################################################################

JEKYLL_ENV ?= production
JEKYLL_SAFE ?= true
JEKYLL_LOG_LEVEL ?= warn
JEKYLL_CMD := bundle exec jekyll

ifeq ($(shell ! test -f "$(DIR)/.env.local" && printf 'yes'),yes)
$(shell touch "$(DIR)/.env.local")
$(info $(shell printf "$(COLOR_YELLOW)Сreate new empty files $(COLOR_GREEN).env.local$(COLOR_RESET)\n"))
endif

-include .env
-include .env.local

#######################################################################
# Check environment variables
#######################################################################

ifeq ($(shell test -z "$(JEKYLL_ENV)" && printf 'yes'),yes)
placeholder := "$(COLOR_YELLOW)[WARNING]$(COLOR_RESET) %s"
message := "An error occurred while building the project, there is no environment variable"
$(error $(shell printf $(placeholder) $(message)))
endif

REQUIRED_ENVIRONMENT_VARIABLES := \
	JEKYLL_ENV \
	JEKYLL_SAFE \
	JEKYLL_STRICT_MODE

.PHONY: check-env
check-env: ## Project variables
	@for env_name in $(REQUIRED_ENVIRONMENT_VARIABLES); do \
		if test ! -n  $${env_name} ; then \
		  printf "$(COLOR_RED)[ERROR]$(COLOR_RESET) An error has occurred, the environment variable \"$(COLOR_BLUE)%s$(COLOR_RESET)\" is not set. ⚠️ ⚠️ \n" "$${env_name}" >&1; \
		  exit $? ; \
		fi \
	done

#######################################################################
# Targets
#######################################################################

# Self-Documented Makefile see https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.DEFAULT_GOAL := help

# Shortcut targets
.PHONY: default
default: build

.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: check
check: ## check
	bundle check
	#bundle exec jekyll build

.PHONY: clean
clean: ## Delete all the files created by the 'html' target
	@#jekyll clean
	@rm -rf .bundle
	@rm -rf _site
	@rm -rf vendor
	@bundle clean --force
	@#gem install bundler
	@$(JEKYLL_CMD) clean --force
	@clear -x

.PHONY: doctor
doctor: ##  Outputs any deprecation or configuration issues.
	@$(JEKYLL_CMD) doctor --trace --profile

#serve:
#	 Execute a script in the current bundl
#	bundle exec jekyll serve

# чтобы позволить jekyll выполнить свою работу и преобразовать файлы вашего сайта в настоящий html
# и отправить его на локальный хост для тестирования, вы запускаете это в каталоге своего сайта:

# make watch ARGS="--incremental --watch --profile --strict_front_matter --trace"
# make watch ARGS="--incremental --watch --profile --strict_front_matter --trace"
.PHONY: watch
watch: ## Build the html output files and additionally run a small webserver for local previews via ARGS="command --options"
	@#JEKYLL_LOG_LEVEL=debug
	@#JEKYLL_ENV=development
	@#kill $(pgrep jekyll)
	@#bundle exec jekyll serve --incremental --watch --profile --strict_front_matter --trace --open-url

	@echo -e "$(COLOR_YELLOW)[command]$(COLOR_GREEN) >> watching$(COLOR_RESET) ... ⏳\n"
	@echo -e "JEKYLL_ENV: $(COLOR_GREEN)$(JEKYLL_ENV)$(COLOR_RESET)"
	@echo -e "JEKYLL_STRICT_MODE: $(COLOR_GREEN)$(JEKYLL_STRICT_MODE)$(COLOR_RESET)"
	@echo -e ""
	@$(JEKYLL_CMD) serve --watch --profile --trace

.PHONY: kill
kill:
	kill $(pgrep jekyll)

# export FREEDESKTOP_MIME_TYPES_PATH=$HOME/freedesktop.org.xml

.PHONY: install
install: ## Install the gems specified by the Gemfile or Gemfile.lock
	@echo -e "$(COLOR_YELLOW)[command]$(COLOR_GREEN) >> Install dependencies$(COLOR_RESET) ... ⏳\n"
	@echo -e ""
	@#gem install jekyll
	@gem install bundler
	@bundle install --verbose
	@# bundle install -j8 > /dev/null || bundle install > /dev/null
	@make -s build

# bundle install -j8 --deployment
#[DEPRECATED] The `--deployment` flag is deprecated because it relies on being remembered across bundler invocations,
# which bundler will no longer do in future versions. Instead please use `bundle config set --local deployment 'true'`,
# and stop using this flag
# bundle config set --local deployment 'true'

.PHONY: update
update: ## Update dependencies to their latest versions
	@echo -e "$(COLOR_YELLOW)[command]$(COLOR_GREEN) >> Update dependencies$(COLOR_RESET) ... ⏳\n"
	@echo -e ""
	@gem update --system
	@bundle update --all -j8
	@bundle check
	@bundle outdated 2&>/dev/null
	@make -s build

.PHONY: release
release: ## release path/ruby/3.2.0/gems/jekyll-sitemap-1.4.0/script/release
	bundle exec rake release

.PHONY: fmt
fmt: ## Running Rubocop
	echo "Rubocop $(bundle exec rubocop --version)"
	bundle exec rubocop -S -D -E $@

	# https://github.com/rubocop/rubocop
	#	echo "Rubocop $(bundle exec rubocop --version)"
	#	bundle exec rubocop -D -E $@
	#	success=$?
	#	if ((success != 0)); then
	#		echo -e "\nTry running \`script/fmt -a\` to automatically fix errors"
	#	fi
  #	exit $success

.PHONY: fmt-auto-correct
fmt-auto-correct: ## Running Rubocop auto-correct all sorts of errors with
	bundle exec rubocop --safe-auto-correct

# https://github.com/jekyll/jekyll-mentions/blob/main/script/test
#test: ## test
#bundle exec rspec "$@"

.PHONY: check-html
check-html: ## Run HTMLProofer 📚
	@rake check --trace


# bundle exec rubocop -D --disable-pending-cops $@

#bundle exec rubocop -a --format progress
#bundle exec rspec

#test-htmlproofer-run: ## Run HTMLProofer 📚
## HTMLProofer is a set of tests to validate your HTML output.
# htmlproofer _site --check-html --allow-hash-href --empty-alt-ignore --disable-external
#bundle exec htmlproofer \
#		--checks ['Links', 'Images', 'Scripts'] \
# 		_site/

.PHONY: test-rake
test-rake:
	rake task

# https://github.com/GoogleChrome/lighthouse#using-the-node-cli
.PHONY: test-lighthouse
test-lighthouse: ## Run Lighthouse 💡
	@#lighthouse --output html --output-path ./report.html
	@#lighthouse http://example.com -G --output html --output-path ./report.html
	@mkdir -p ./report
	lighthouse http://127.0.0.1:4000 -GA --output html --output-path ./report/report.html
	open ./report/report.html

_build_command :=

## set print verbose output and show the full backtrace when an error occurs
ifeq ($(shell [ "$(JEKYLL_ENV)" == "development" ] && echo -n yes),yes)
	_build_command += --trace --profile --force_polling --verbose
endif

ifeq ($(shell [ "$(JEKYLL_ENV)" == "production" ] && echo -n yes),yes)
	_build_command += --quiet
endif

# set safe mode (defaults to false)
ifeq ($(shell [ "$(JEKYLL_SAFE)" == true ] && echo -n yes),yes)
	_build_command += --safe
endif

# make build ARGS="--incremental --profile"
# make build ARGS="--quiet"
.PHONY: build
build: ## Build the html output files via ARGS="command --options"
	@echo -e "$(COLOR_YELLOW)[command]$(COLOR_GREEN) >> building$(COLOR_RESET) ... ⏳\n"
	@echo -e "JEKYLL_ENV: $(COLOR_GREEN)$(JEKYLL_ENV)$(COLOR_RESET)"
	@echo -e "JEKYLL_STRICT_MODE: $(COLOR_GREEN)$(JEKYLL_STRICT_MODE)$(COLOR_RESET)"
	@echo -e ""
	@$(JEKYLL_CMD) build $(_build_command) $(ARGS)

## Build configurations in CloudFlare
# jekyll build --incremental --profile --verbose --trace

.PHONY: print-env
print-env: ## Print environment
	@echo -e "$(COLOR_YELLOW)Base environment:\n$(COLOR_RESET)"
	@echo -e "DIR: $(COLOR_GREEN)$(DIR)$(COLOR_RESET)"
	@echo -e "MAKEFILE_DIR: $(COLOR_GREEN)$(MAKEFILE_DIR)$(COLOR_RESET)"
	@echo -e "$(COLOR_YELLOW)\nGit environment:\n$(COLOR_RESET)"
	@echo -e "GIT_REV: $(COLOR_GREEN)$(GIT_REV)$(COLOR_RESET)"
	@echo -e "GIT_TAG: $(COLOR_GREEN)$(GIT_TAG)$(COLOR_RESET)"
	@echo -e "GIT_SHORT_TAG: $(COLOR_GREEN)$(GIT_SHORT_TAG)$(COLOR_RESET)"
	@echo -e "$(COLOR_YELLOW)\nJekyll environment:\n$(COLOR_RESET)"
	@echo -e "SITE_URL: $(COLOR_GREEN)$(SITE_URL)$(COLOR_RESET)"
	@echo -e "RELEASE_VERSION: $(COLOR_GREEN)$(RELEASE_VERSION)$(COLOR_RESET)"
	@echo -e "JEKYLL_ENV: $(COLOR_GREEN)$(JEKYLL_ENV)$(COLOR_RESET)"
	@echo -e "JEKYLL_STRICT_MODE: $(COLOR_GREEN)$(JEKYLL_STRICT_MODE)$(COLOR_RESET)"
	@echo -e "JEKYLL_SAFE: $(COLOR_GREEN)$(JEKYLL_SAFE)$(COLOR_RESET)"
	@echo -e "JEKYLL_LOG_LEVEL: $(COLOR_GREEN)$(JEKYLL_LOG_LEVEL)$(COLOR_RESET)"
	@echo -e "CF_PAGES_URL: $(COLOR_GREEN)$(CF_PAGES_URL)$(COLOR_RESET)"
	@echo -e "CF_PAGES_COMMIT_SHA: $(COLOR_GREEN)$(CF_PAGES_COMMIT_SHA)$(COLOR_RESET)"

.PHONY: build-production
build-production: print-env ## Build your site for {production} ...
	@#JEKYLL_ENV=production; bundle exec jekyll build --safe --incremental --profile --trace --verbose
	@JEKYLL_ENV=production && bundle exec jekyll build --incremental --profile --trace --verbose
	@#JEKYLL_ENV=production bundle exec jekyll build --incremental --profile --trace --verbose

.PHONY: build-preview
build-preview: clean ## Build your site for {preview} ...
	@echo "Building {preview} ..."
	JEKYLL_ENV=preview && bundle exec jekyll build --incremental --profile --trace

# ps aux | grep jekyll

# https://developers.cloudflare.com/workers/cli-wrangler/commands/#generate
# wrangler



#build-prod: clean
#	JEKYLL_ENV=production bundle exec jekyll build --profile --trace --verbose
#
#env-pull:
#	vercel env pull

# Deployed to production

#deploy-dev:
#  – Deploy with Environment Variables
#    $ vercel -e NODE_ENV=production -e SECRET=@mysql-secret
#    $ vercel -e JEKYLL_ENV=production -e SECRET=@mysql-secret
#vercel --env JEKYLL_ENV=development

#deploy-prod:
#vercel --prod


# https://dlaa.me/markdownlint/
# https://github.com/DavidAnson/markdownlint


#markdownlint: ##  MarkdownLint Command Line Interface
#	@docker run -it --rm -v $(PWD):/md peterdavehello/markdownlint:0.22.0 markdownlint .
#
#markdownlint-fix: ##  MarkdownLint Command Line Interface: fix basic errors (does not work with STDIN)
#	@docker run -it --rm -v $(PWD):/md peterdavehello/markdownlint:0.22.0 markdownlint --fix .
#
#sarda:
#	CLOUDFLARE_ACCOUNT_ID=04fcec9f6b5313d8cd9feb20456640de npx wrangler pages publish <directory>
#
#deployment: ## Publish a directory of static assets as a new deployment. This will automatically pull in git information if available.
#	CLOUDFLARE_ACCOUNT_ID=04fcec9f6b5313d8cd9feb20456640de npx wrangler pages publish <directory>


# To start developing your Worker, run `npm start`
# To publish your Worker to the Internet, run `npm run deploy`


TESTS = markdownlint.test

all-tests := $(addsuffix .test, $(basename $(wildcard *.test)))

#.PHONY clean
#.PHONY test $(TESTS)
#test: $(TESTS)
test: $(all-tests)
	@echo $(MAKEFILE_DIR)
	@echo $(all-tests)
	@echo $(OBJS)

%.test : %.test-in %.test-cmp $(BC)
	@$(BC) <$< 2>&1 | diff -q $(word 2, $?) - >/dev/null || \
	(echo "Test $@ failed" && exit 1)

deploy: ## Run deployment
	platformio run -t upload

# `make lint LINT_SRC=lib/speeder/speeder.cpp.`
lint: ## Run all lint
	@#oclint $(LINT_SRC) -- $(CPP_FLAGS) $(INCLUDES)
	make -s markdownlint-fix
	make -s test-htmlproofer
	make -s test-lighthouse

all: test ## RUN all tests
	@echo "Success, all tests passed."

print: $(wildcard *) ## Print out file information about every .c file
	@clear -x
	@ls -lAFG $?

start: ## 💻 Develop your full-stack Pages application locally
	wrangler pages dev static -k KV
	wrangler pages dev --live-reload
	wrangler pages dev --live-reload .



#smimesign --list-keys

#  soprun.github.io git:(dev) ✗ smimesign --list-keys
#       ID: a192c8b1cfae3e3222d1576314d823e3e47387c9
#      S/N: 65e5c40518de4d1a44932c5fb400ecc1
#Algorithm: SHA256-RSA
# Validity: 2023-05-12 15:24:31 +0000 UTC - 2024-05-12 15:24:30 +0000 UTC
#   Issuer: CN=Actalis Client Authentication CA G3,O=Actalis S.p.A.,L=Ponte San Pietro,ST=Bergamo,C=IT
#  Subject: CN=mail@soprun.com
#   Emails: mail@soprun.com, mail@soprun.com
#
#       ID: 5b2e3f4424b375ac893d2f4a343aab4fd46e205c
#      S/N: 55821be72dea3d69294e7ee7434ca173
#Algorithm: SHA256-RSA
# Validity: 2023-05-12 16:24:56 +0000 UTC - 2024-05-12 16:24:55 +0000 UTC
#   Issuer: CN=Actalis Client Authentication CA G3,O=Actalis S.p.A.,L=Ponte San Pietro,ST=Bergamo,C=IT
#  Subject: CN=job@soprun.com
#   Emails: job@soprun.com, job@soprun.com


#gpg --with-keygrip --list-secret-keys $@ | grep Keygrip | awk '{print $3}'
#gpg --list-secret-keys | egrep 'mail@soprun.com' | grep -B 1 digitalSignature | awk '/ID/ {print $2}'

#gpg --list-keys --keyid-format=long


# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key#telling-git-about-your-x509-key

#smimesign --list-keys



#lsof -nP -iTCP:8788 -sTCP:LISTEN
#kill 66016


# Sentry CLI
# https://docs.sentry.io/product/releases/associate-commits/?original_referrer=https%3A%2F%2Fblog.sentry.io%2F

#SENTRY_AUTH_TOKEN=
#SENTRY_ORG=soprun
#SENTRY_PROJECT=soprun

#releases:
#		VERSION=$(sentry-cli releases propose-version)
#
#		# Create a release
#		sentry-cli releases new -p project1 -p project2 $VERSION
#
#		# Associate commits with the release
#		sentry-cli releases set-commits --auto $VERSION

#https://docs.sentry.io/platforms/javascript/sourcemaps/uploading/cli/
#sourcemaps:
	#sentry-cli sourcemaps upload --release=<release_name> /path/to/directory



#KV_NAMESPACE=soprun
#
#wrangler kv:namespace create $KV_NAMESPACE
#
#
#wrangler kv:key put --namespace-id $KEY_VALUE_NAMESPACE_ID "SENTRY_DSN" "https://5943bcec0a2e4787882cbb988fd0aabc@o364305.ingest.sentry.io/6291966" --preview
##wrangler kv:key --namespace-id $KEY_VALUE_NAMESPACE_ID get SENTRY_DSN
#
##SITE_URL
##namespace-id
#
##wrangler kv:namespace create kv_storage_staging
##wrangler kv:namespace create kv_storage_production
#
#
##wrangler kv:key put --env=staging --binding=<YOUR_BINDING> "<KEY>" "<VALUE>"
#wrangler kv:key put --namespace-id=<YOUR_ID> "<KEY>" "<VALUE>"
#
#
#wrangler kv:key put --binding=kv_storage "SENTRY_DSN" "https://5943bcec0a2e4787882cbb988fd0aabc@o364305.ingest.sentry.io/6291966"
#wrangler kv:key put --namespace-id c5abf72702c84d03b52e5ca65fce7fea "SENTRY_DSN" "https://5943bcec0a2e4787882cbb988fd0aabc@o364305.ingest.sentry.io/6291966"
#wrangler kv:key list --namespace-id c5abf72702c84d03b52e5ca65fce7fea --env=production
#
#
#wrangler kv:key put --namespace-id c5abf72702c84d03b52e5ca65fce7fea "SITE_URL" "https://soprun.com"
#
#
#"build": "wrangler pages functions build --outfile static/_worker.js",
#"build-plugin": "wrangler pages functions build --plugin --outfile index.js",
#"start": "wrangler pages dev static -k KV"

#.PHONY: shellcheck
#shellcheck: ## ShellCheck finds bugs in your shell scripts: https://www.shellcheck.net
#	@for file in $(SHELL_FILES); do \
#		shellcheck --check-sourced --external-sources --format=tty $$file; \
#	done

#bundle-config:
#	bundle config unset deployment


#bundle exec github_changelog_generator --token $GITHUB_TOKEN -u gjtorikian -p html-proofer


# bundle config set --local deployment 'true'
# bundle config set --local path vendor/bundle
#
#latest-version:
#	touch $(DIR)/latest_version.txt

#latest_version: ## latest_version.txt

#.PHONY: release-publish release
#VERSION ?= master
#release-publish:
#	VERSION=$(VERSION) PUBLISH=true utils/create-update-packages.sh
#release:
#	VERSION=$(VERSION) utils/create-update-packages.sh


#--verify
#git tag -d X

#git tag --verify --sign --annotate "v1.0.1" --message "Message v1.0.1"
#git tag --sign --annotate "v1.0.1" --message "Message v1.0.1"

#GIT_COMMITTER_DATE="2006-10-02 10:31" git tag -s v1.0.1

# Gets tag from current branch
# log_info $(git describe --tags --abbrev=0)

# # gets tags across all branches, not just the current branch
#output "Current tag: $(git describe --tags "$(git rev-list --tags --max-count=1)")" "info"
#output "Last tag: $(git tag -l "v*.*.*" --sort=-v:refname | head -n 1)" "info"


# npx workbox-cli wizard
# workbox generateSW workbox-config.js

create-signature: ## .well-known/security.txt
	gpg --output "$(DIR)/.well-known/security.txt.sig" --armor --detach-sig "$(DIR)/.well-known/security.txt"
	gpg --verify "$(DIR)/.well-known/security.txt.sig" "$(DIR)/.well-known/security.txt"
	cat "$(DIR)/.well-known/security.txt.sig" >> "$(DIR)/.well-known/security.txt"
