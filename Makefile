default: gen upload

gen:
	@echo "# Generating static files with Jekyll..."
	@jekyll
	@echo

upload:
	@echo "# Uploading to NearlyFreeSpeech..."
	@scp -r _site/* nfs:
