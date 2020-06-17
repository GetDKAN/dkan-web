# DKAN Web docker container image

## Work with image locally
Makefile offers handy commands to work with image locally.

### Build
Build image locally.
```
$ make build
```

### Push
Push image to registry.
```
$ make push
```

### Shell
Run a bash shell on an temporary instance of the image.
```
$ make shell
```

### Run
Run a command on an temporary instance of the image.
```
$ make run CMD='echo "hello world"'
```

### Release (Build + Push)
Build image locally, then push it to remote registry.
```
$ make release
```

## Build on Docker Hub
Build Arguments are set using the hooks overrides, documentation available [here](https://docs.docker.com/docker-hub/builds/advanced/#override-build-test-or-push-commands).

```
├── hooks
│   └── build
```
