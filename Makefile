
check:
	bundle exec jekyll build
	bundle exec htmlproofer ./_site

serve:
	bundle exec jekyll serve --incremental
