
check:
	bundle exec jekyll build
	bundle exec htmlproofer ./_site

serve:
	rm -rf $(PWD)/_site
	rm -rf $(PWD)/.jekyll-metadata
	bundle exec jekyll serve --incremental
