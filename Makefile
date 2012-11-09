default: gen upload push

gen:
	@echo "# Generating static files with Jekyll..."
	@jekyll
	@echo

upload:
	@echo "# Uploading to NearlyFreeSpeech..."
	@rsync -vr _site/* nfs:
	@echo

push:
	@echo "# Pushing to GitHub.."
	@git push
	@echo
