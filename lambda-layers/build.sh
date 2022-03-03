#!/usr/bin/env bash

set -e


install_python_dependencies() {
  pip install --target="$BUILD_PATH/python" -r "$SOURCE_FILE"
}

install_nodejs_dependencies() {
  mkdir -p "$BUILD_PATH/nodejs"
  cp "$SOURCE_FILE" "$BUILD_PATH/nodejs/package.json"
  npm install --production --prefix "$BUILD_PATH/nodejs"
}

clean_up() {
  rm -rf $BUILD_PATH
}

clean_up

case $LANGUAGE in

  python)
    install_python_dependencies
    ;;

  nodejs)
    install_nodejs_dependencies
    ;;

  *)
    echo "Wrong language".
    exit 1
    ;;

esac
