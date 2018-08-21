
## workspace to build ecmh

    $ cd dev-docker; docker build -t ecmh-dev:v1 .
    $ cd workspace; ./run.sh // this will goto docker shell
    $ cd workspace; make update && make build

* Note: the build of ecmh will take long time(compile and run), some cpps use complicated template tech, and take big RAM to compile, take a coffe...

## Bazel to build ecmh


