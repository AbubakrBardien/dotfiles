#!/bin/bash

cat ~/.config/mysql_code_dark_theme/code_editor.xml | sudo tee /usr/share/mysql-workbench/data/code_editor.xml >/dev/null
