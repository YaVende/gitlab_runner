FROM gitlab/gitlab-runner:v9.3.0

RUN apt-get update
RUN apt-get install -y gettext # get the enbsubst utility

ADD entrypoint.sh /tmp/entrypoint.sh
ADD config.toml.template /tmp/config.toml.template

VOLUME /cache

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/tmp/entrypoint.sh > /dev/stdout"]
