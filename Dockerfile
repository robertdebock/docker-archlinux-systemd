FROM archlinux:latest

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build_date="2023-09-01"

ENV container docker

# Clean services
RUN pacman -Sy --noconfirm systemd-sysvcompat && \
  cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done ;\
  rm -f /lib/systemd/system/multi-user.target.wants/*;\
  rm -f /etc/systemd/system/*.wants/*;\
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*;\
  rm -f /lib/systemd/system/anaconda.target.wants/*;\
  pacman -Syu --noconfirm

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
