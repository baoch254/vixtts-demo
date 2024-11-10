#!/usr/bin/env bash

if python3 --version &>/dev/null; then
  echo "The environment is not ok. Running setup..."
  rm -rf .env
  python$PYTHON_VERSION -m venv .env &&
    source .env/bin/activate &&
    git submodule update --init --recursive &&
    cd TTS &&
    git fetch --tags &&
    git checkout 0.1.1 &&
    echo "Installing TTS..." &&
    pip install --use-deprecated=legacy-resolver -e . -q &&
    cd .. &&
    echo "Installing other requirements..." &&
    pip install -r requirements.txt -q &&
    echo "Downloading Japanese/Chinese tokenizer..." &&
    python -m unidic download
else
  echo "Python version $PYTHON_VERSION is not installed. Please install it."
fi
