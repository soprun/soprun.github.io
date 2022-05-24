
# Self-Documented Makefile see https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.DEFAULT_GOAL := help

.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

check: ## check
	bundle check
	#bundle exec jekyll build

clean: ## Clean the site (removes site output and metadata file) without building.
	jekyll clean

#serve:
#	 Execute a script in the current bundl
#	bundle exec jekyll serve

# чтобы позволить jekyll выполнить свою работу и преобразовать файлы вашего сайта в настоящий html
# и отправить его на локальный хост для тестирования, вы запускаете это в каталоге своего сайта:

watch: clean ##Execute a script in the current bundl
	bundle exec jekyll serve  --incremental --watch --livereload --profile --strict_front_matter --trace

install: ## Install the gems specified by the Gemfile or Gemfile.lock
	gem install bundler
	bundle install
	make -s build

update: ## Update dependencies to their latest versions
	@#gem update --system
	@#bundle update --all
	bundle outdated
	bundle update --bundler
	bundle check
	make -s build

build: clean ## Build your site
	bundle exec jekyll build --incremental --profile --trace
	## HTMLProofer is a set of tests to validate your HTML output.
	bundle exec htmlproofer \
		--check-favicon \
		--check-html \
 		--check-img-http \
 		./_site

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


markdownlint: ## Usage Command line
	docker run -it -v $(PWD):/md peterdavehello/markdownlint markdownlint .



sarda:
	CLOUDFLARE_ACCOUNT_ID=04fcec9f6b5313d8cd9feb20456640de npx wrangler pages publish <directory>
