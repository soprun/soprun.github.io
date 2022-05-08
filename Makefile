
check:
	bundle exec jekyll build
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
	bundle exec jekyll build

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
