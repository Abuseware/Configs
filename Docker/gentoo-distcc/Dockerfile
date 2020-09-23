FROM gentoo/stage3-amd64-hardened-nomultilib

EXPOSE 3632/tcp

ADD make.conf /etc/portage/make.conf

RUN mkdir --parents /etc/portage/repos.conf
RUN cp /usr/share/portage/config/repos.conf /etc/portage/repos.conf/gentoo.conf

RUN emerge-webrsync
RUN emerge --sync

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN eselect locale set en_US.utf8

RUN echo "Europe/Warsaw" > /etc/timezone
RUN emerge --config sys-libs/timezone-data

RUN env-update

RUN emerge --oneshot --update sys-apps/portage
#RUN emerge --update --changed-use --deep --with-bdeps=y @world
#RUN emerge --depclean
RUN emerge sys-devel/distcc

CMD /usr/bin/distccd --no-detach --port 3632
