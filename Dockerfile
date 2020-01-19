FROM debian:bullseye
RUN adduser --disabled-password --gecos '' maciej
RUN adduser maciej sudo

RUN apt-get update -y && \
    apt-get install git sudo -y
RUN echo "maciej ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/maciej

USER maciej:maciej
WORKDIR /home/maciej

RUN mkdir .configs && chown maciej:maciej .configs
COPY --chown=maciej:maciej . .configs/config
COPY --chown=maciej:maciej rc.headless .configs/config/rc

RUN cd .configs/config && ./configinstall

ENTRYPOINT ["/bin/zsh"]
