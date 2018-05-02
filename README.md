
Docker build container
----------------------

This runs a build as the current user, allowing bind mounted volumes to work as expected.

```sh
wmono@docker:~/docker-builder$ id
uid=1000(wmono) gid=1000(wmono) groups=1000(wmono),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),108(netdev),112(bluetooth),999(vboxsf)

wmono@docker:~/docker-builder$ ./build.sh
Sending build context to Docker daemon  3.584kB
Step 1/6 : FROM library/alpine:latest
latest: Pulling from library/alpine
ff3a5c916c92: Pull complete
Digest: sha256:7df6db5aa61ae9480f52f0b3a06a140ab98d427f86d8d5de0bedab9b8df6b1c0
Status: Downloaded newer image for alpine:latest
 ---> 3fd9065eaf02
Step 2/6 : ARG build_as_user=10000
 ---> Running in 2ee16cdd83b6
 ---> bfb8871d4f53
Removing intermediate container 2ee16cdd83b6
Step 3/6 : ARG build_as_group=10000
 ---> Running in 3f587397bb77
 ---> 8b0d7b417d15
Removing intermediate container 3f587397bb77
Step 4/6 : RUN echo "builder:x:${build_as_user}:${build_as_group}:Builder:/build:/bin/sh" >> /etc/passwd && 	echo "builder:x:${build_as_group}" >> /etc/group && 	mkdir /build && chown ${build_as_user}:${build_as_group} /build && chmod 755 /build
 ---> Running in 4b8a113e8481
 ---> 330fd0ea7be9
Removing intermediate container 4b8a113e8481
Step 5/6 : WORKDIR /build
 ---> dffbb2888648
Removing intermediate container f903aaa1a753
Step 6/6 : USER builder:builder
 ---> Running in 12129579fadc
 ---> dddeae62b33b
Removing intermediate container 12129579fadc
Successfully built dddeae62b33b

wmono@docker:~/docker-builder$ docker run -it --rm -v `pwd`:/build dddeae62b33b
~ $ id
uid=1000(builder) gid=1000
~ $ ls -lFa
total 20
drwxr-xr-x    2 builder  1000          4096 May  2 01:59 ./
drwxr-xr-x   26 root     root          4096 May  2 01:59 ../
-rw-------    1 builder  1000            18 May  2 01:59 .ash_history
-rw-r--r--    1 builder  1000           354 May  2 01:52 Dockerfile
-rwxr-xr-x    1 builder  1000           619 May  2 01:52 build.sh*
~ $ touch my-file
~ $ exit
wmono@docker:~/docker-builder$ ls -lFa
total 20
drwxr-xr-x  2 wmono wmono 4096 May  1 19:00 ./
drwxr-xr-x 10 wmono wmono 4096 May  1 18:54 ../
-rw-------  1 wmono wmono   37 May  1 19:00 .ash_history
-rwxr-xr-x  1 wmono wmono  619 May  1 18:52 build.sh*
-rw-r--r--  1 wmono wmono  354 May  1 18:52 Dockerfile
-rw-r--r--  1 wmono wmono    0 May  1 19:00 my-file
wmono@docker:~/docker-builder$
```
