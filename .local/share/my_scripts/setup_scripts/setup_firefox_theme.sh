#!/bin/bash

# Run Firefox to create the ".mozilla" directory

firefox --no-remote &
sleep 5
# shellcheck disable=SC2164
cd
# shellcheck disable=SC2012
browserProfileDir=$(ls -d .mozilla/firefox/*.default-release | head -n 1)
ln -s .config/custom_firefox/user.js "$browserProfileDir/user.js"
ln -s .config/custom_firefox/userChrome.css "$browserProfileDir/Chrome/userChrome.css"
