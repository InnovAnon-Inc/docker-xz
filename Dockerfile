FROM innovanon/doom-base as xz
ARG LFS=/mnt/lfs
USER lfs
RUN sleep 31 \
 && git clone --depth=1 --recursive     \
      https://github.com/xz-mirror/xz.git \
 && cd                           xz     \
 && ./autogen.sh                        \
 && ./configure                         \
      --disable-shared --enable-static  \
 && make                                \
 && make DESTDIR=/tmp/xz install        \
 && cd           /tmp/xz                \
 && tar acf        ../xz.txz .          \
 && rm -rf          $LFS/sources/xz

FROM scratch as final
COPY --from=xz /tmp/xz.txz /tmp/

