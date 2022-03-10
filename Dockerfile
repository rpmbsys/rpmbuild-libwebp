ARG centos=stream8
FROM aursu/rpmbuild:${centos}-build

USER root
RUN yum -y install \
        freeglut-devel \
        giflib-devel \
        java-devel \
        jpackage-utils \
        libjpeg-devel \
        libpng-devel \
        libtiff-devel \
        swig \
    && yum clean all && rm -rf /var/cache/yum

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "libwebp.spec"]
CMD ["-ba"]
