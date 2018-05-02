FROM library/alpine:latest

ARG build_as_user=10000
ARG build_as_group=10000

RUN echo "builder:x:${build_as_user}:${build_as_group}:Builder:/build:/bin/sh" >> /etc/passwd && \
	echo "builder:x:${build_as_group}" >> /etc/group && \
	mkdir /build && chown ${build_as_user}:${build_as_group} /build && chmod 755 /build

WORKDIR /build
USER builder:builder
