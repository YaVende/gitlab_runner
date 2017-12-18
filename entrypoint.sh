#!/bin/bash
declare required_vars="\
  \$CONCURRENT
  \$GITLAB_TOKEN
  \$GITLAB_URL
  \$NAME
  \$WORKER_IMAGE
"

# Remove dollar sign in variable name and store all var names in an array
IFS=' '; read -a non_prefixed_var_names <<< $(
  echo $required_vars | sed 's/\$//g'
)

# Ensure required vars are present
for var_name in "${non_prefixed_var_names[@]}"
do
  echo Testing presence of required var $var_name

  if [[ ! -v $var_name ]]; then
    echo "Missing environment variable $var_name"
    exit 1
  fi
done

# Backup old config
mv /etc/gitlab-runner/config.toml /etc/gitlab-runner/config.toml.bu

# Generate new config file from template
cat ./tmp/config.toml.template \
  | envsubst "$required_vars" \
  > /etc/gitlab-runner/config.toml

# Remove template
rm ./tmp/config.toml.template

# Run the usual entrypoint
/usr/bin/dumb-init /entrypoint run        \
  --user=gitlab-runner                    \
  --working-directory=/home/gitlab-runner \
