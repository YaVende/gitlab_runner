#!/bin/bash

# Ensure needed vars are present
declare -a vars=(NAME GITLAB_URL GITLAB_TOKEN)

for var_name in "${vars[@]}"
do
  if [ -z "$(eval "echo \$$var_name")" ]; then
    echo "Missing environment variable $var_name"
    exit 1
  fi
done

# Backup old config
mv /etc/gitlab-runner/config.toml /etc/gitlab-runner/config.toml.bu

# Generate new config file from template
cat ./tmp/config.toml.template | envsubst '\
  \$NAME \
  \$GITLAB_URL \
  \$GITLAB_TOKEN \
' \
> /etc/gitlab-runner/config.toml

# Run the usual entrypoint
/usr/bin/dumb-init /entrypoint run        \
  --user=gitlab-runner                    \
  --working-directory=/home/gitlab-runner \
