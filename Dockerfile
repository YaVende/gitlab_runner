FROM gitlab/gitlab-runner
ADD entrypoint.sh /tmp/entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/tmp/entrypoint.sh"]
