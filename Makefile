MAKEFILE_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Self-Documented Makefile see https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.DEFAULT_GOAL := help
.PHONY: help check clean watch install update build all test

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

check: ## check
	bundle check
	#bundle exec jekyll build

clean: ## Removes all generated files: destination folder, metadata file, Sass and Jekyll caches.
	@jekyll clean
	@bundle clean --force
	@clear -x

doctor: ##  Outputs any deprecation or configuration issues.
	jekyll doctor

#serve:
#	 Execute a script in the current bundl
#	bundle exec jekyll serve

# чтобы позволить jekyll выполнить свою работу и преобразовать файлы вашего сайта в настоящий html
# и отправить его на локальный хост для тестирования, вы запускаете это в каталоге своего сайта:

watch: ##Execute a script in the current bundl
	@JEKYLL_LOG_LEVEL=debug
	@#JEKYLL_ENV=development
	@#kill $(pgrep jekyll)
	@#bundle exec jekyll serve --incremental --watch --profile --strict_front_matter --trace --open-url
	bundle exec jekyll serve --incremental --watch --profile --strict_front_matter --trace

kill:
	kill $(pgrep jekyll)

# export FREEDESKTOP_MIME_TYPES_PATH=$HOME/freedesktop.org.xml

install: ## Install the gems specified by the Gemfile or Gemfile.lock
	#gem install jekyll
	gem install bundler
	bundle install
	make -s build

update: ## Update dependencies to their latest versions
	@gem update --system
	@#bundle update --all
	@bundle outdated
	@bundle update --bundler
	@bundle check
	@make -s build

test-htmlproofer: ## Run HTMLProofer 📚
	## HTMLProofer is a set of tests to validate your HTML output.
	@# htmlproofer _site --check-html --allow-hash-href --empty-alt-ignore --disable-external
	bundle exec htmlproofer \
		--check-favicon \
		--check-html \
 		--check-img-http \
 		--check-opengraph \
		--allow-hash-href \
		--empty-alt-ignore \
		--disable-external \
		--trace \
 		./_site


# https://github.com/GoogleChrome/lighthouse#using-the-node-cli
test-lighthouse: ## Run Lighthouse 💡
	@#lighthouse --output html --output-path ./report.html
	@#lighthouse http://example.com -G --output html --output-path ./report.html
	@mkdir -p ./report
	lighthouse http://127.0.0.1:4000 -GA --output html --output-path ./report/report.html
	open ./report/report.html

build: clean ## Build your site
	JEKYLL_ENV=production bundle exec jekyll build --incremental --profile --trace --verbose

build-preview:
	JEKYLL_ENV=production bundle exec jekyll build --incremental --profile --trace
	JEKYLL_ENV=development bundle exec jekyll build --incremental --profile --trace
	JEKYLL_ENV=preview bundle exec jekyll build --incremental --profile --trace

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


markdownlint: ##  MarkdownLint Command Line Interface
	@docker run -it --rm -v $(PWD):/md peterdavehello/markdownlint:0.22.0 markdownlint .

markdownlint-fix: ##  MarkdownLint Command Line Interface: fix basic errors (does not work with STDIN)
	@docker run -it --rm -v $(PWD):/md peterdavehello/markdownlint:0.22.0 markdownlint --fix .

sarda:
	CLOUDFLARE_ACCOUNT_ID=04fcec9f6b5313d8cd9feb20456640de npx wrangler pages publish <directory>

deployment: ## Publish a directory of static assets as a new deployment. This will automatically pull in git information if available.
	CLOUDFLARE_ACCOUNT_ID=04fcec9f6b5313d8cd9feb20456640de npx wrangler pages publish <directory>


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

releases:
		VERSION=$(sentry-cli releases propose-version)

		# Create a release
		sentry-cli releases new -p project1 -p project2 $VERSION

		# Associate commits with the release
		sentry-cli releases set-commits --auto $VERSION

#https://docs.sentry.io/platforms/javascript/sourcemaps/uploading/cli/
sourcemaps:
	sentry-cli sourcemaps upload --release=<release_name> /path/to/directory
