
# Self-Documented Makefile see https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.DEFAULT_GOAL := help

.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


check: markdownlint
	#bundle exec jekyll build
	bundle exec htmlproofer ./_site

clean:
	jekyll clean

serve:
	bundle exec jekyll serve --incremental

# чтобы позволить jekyll выполнить свою работу и преобразовать файлы вашего сайта в настоящий html
# и отправить его на локальный хост для тестирования, вы запускаете это в каталоге своего сайта:

watch: clean
	bundle exec jekyll serve --watch --incremental --livereload --profile --strict_front_matter --trace

# Deployed to production

deploy-dev:
#  – Deploy with Environment Variables
#    $ vercel -e NODE_ENV=production -e SECRET=@mysql-secret
#    $ vercel -e JEKYLL_ENV=production -e SECRET=@mysql-secret
	vercel --env JEKYLL_ENV=development

deploy-prod:
	vercel --prod

install:
	gem install bundler
	bundle install
	make -s build

build: clean
	bundle exec jekyll build --incremental --profile --trace

build-prod: clean
	JEKYLL_ENV=production bundle exec jekyll build --incremental --profile --trace --verbose

env-pull:
	vercel env pull

update: ## Running bundle update
	bundle update

remark:
	./node_modules/.bin/remark readme.md --output

# ps aux | grep jekyll

# https://developers.cloudflare.com/workers/cli-wrangler/commands/#generate
# wrangler


# https://dlaa.me/markdownlint/
# https://github.com/DavidAnson/markdownlint

markdownlint: ## Usage Command line
	@docker run -it -v $(PWD):/md peterdavehello/markdownlint markdownlint .
