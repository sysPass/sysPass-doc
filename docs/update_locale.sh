#!/bin/bash

make gettext && sphinx-intl update -p build/es/locale/ -l en
