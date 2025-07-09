if [[ -f ~/.ssh/bitbucket ]]; then
	eval $(keychain --eval --quiet bitbucket)
fi
