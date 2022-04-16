
check:
	bundle exec jekyll build
	bundle exec htmlproofer ./_site

serve:
	rm -rf $(PWD)/_site
	rm -rf $(PWD)/.jekyll-metadata
	bundle exec jekyll serve --incremental

# чтобы позволить jekyll выполнить свою работу и преобразовать файлы вашего сайта в настоящий html
# и отправить его на локальный хост для тестирования, вы запускаете это в каталоге своего сайта:

watch:
	jekyll serve --watch --incremental --livereload --profile --trace
