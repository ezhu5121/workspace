#!/bin/sh

if [ -f /.dockerenv ]; then
  echo "Can't run in docker!"
  exit 1
fi

dir=`pwd`
name="dev"
img="ecmh-dev:v1"
while getopts "i:n:" arg
do
  case $arg in
    i)
      img="arg:$OPTARG"
      ;;
    n)
      name="arg:$OPTARG"
      ;;
    ?)
      echo "run.sh -i <img> -n <container-name>"
      exit 1
      ;;
  esac
done

docker run -it --name $name \
  --mount type=bind,source=$dir,target=/home/develop/workspace \
  $img
