FROM gitlab/gitlab-runner

RUN apt-get update
RUN apt-get install -y gettext # get the enbsubst utility

ADD entrypoint.sh /tmp/entrypoint.sh
ADD config.toml.template /tmp/config.toml.template

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/tmp/entrypoint.sh > /dev/stdout"]
