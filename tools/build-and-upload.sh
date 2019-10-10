#!/bin/bash

root_dir=$(dirname $(dirname $(readlink -f $0})))

python3 ${root_dir}/python/setup.py bdist_wheel \
  --bdist-dir ${root_dir}/assets/build \
  --dist-dir ${root_dir}/assets/dist
rm -rf tflite.egg-info

read -p "Would you like to upload the package? [Y|N] " input_str
if [ -z "${input_str}" -o "${input_str}" != "Y" ]; then
  exit 0
fi

read -p "Will upload to test.pypi.org, type \"Release\" for real publishment " input_str
if [ -z "${input_str}" -o ${input_str} != "Release" ]; then
  python3 -m twine upload \
    --repository-url https://test.pypi.org/legacy/ \
    ${root_dir}/assets/dist/tflite-*
else
  read -p "Will publish the package, are you sure to continue? [Y|N] " input_str
  if [ -z "${input_str}" -o ${input_str} = "Y" ]; then
    echo "Uploading..."
    # python3 -m twine upload ${root_dir}/assets/dist/tflite-*
  fi
fi
