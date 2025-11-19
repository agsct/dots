if [[ -f ~/.ssh/bitbucket ]]; then
	eval $(keychain --eval --quiet bitbucket)
fi

if [[ -f ~/.ssh/buildserver ]]; then
    eval $(keychain --eval --quiet buildserver)
fi
