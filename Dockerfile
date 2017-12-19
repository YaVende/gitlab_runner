FROM gitlab/gitlab-runner:v10.2.0

RUN apt-get update
RUN apt-get install -y gettext # get the enbsubst utility

ADD entrypoint.sh /etc/entrypoint.sh
ADD config.toml.template /tmp/config.toml.template

VOLUME /cache

RUN chmod +x /etc/entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/etc/entrypoint.sh > /dev/stdout"]
