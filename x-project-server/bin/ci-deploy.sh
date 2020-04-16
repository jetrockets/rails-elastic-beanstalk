#!/bin/sh

xargs -P 3 -I {} sh -c 'eval "$1"' - {} << "EOF"
cd eb/$RAILS_ENV/rails; sed -i 's/tag/'$RAILS_ENV-$CI_COMMIT_SHORT_SHA'/' Dockerrun.aws.json; eb deploy --profile default --label $LABEL-rails --timeout 30
cd eb/$RAILS_ENV/sidekiq; sed -i 's/tag/'$RAILS_ENV-$CI_COMMIT_SHORT_SHA'/' Dockerfile; eb deploy --profile default --label $LABEL-sidekiq --timeout 30
cd eb/$RAILS_ENV/anycable-rails;  sed -i 's/tag/'$RAILS_ENV-$CI_COMMIT_SHORT_SHA'/' Dockerrun.aws.json; eb deploy --profile default --label $LABEL-anycable-rails --timeout 30
EOF

