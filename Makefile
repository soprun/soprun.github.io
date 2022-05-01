
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
	jekyll serve --watch --incremental --livereload --profile --trace

# Deployed to production

deploy-dev:
	vercel

deploy-prod:
	vercel --prod
