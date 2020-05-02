#!/bin/bash
versions=( */ )
versions=( "${versions[@]%/}" )

for version in "${versions[@]}"; do
  cp init.sql $version
  cp pgaudit-docker-entrypoint.sh $version
  for variant in alpine; do
		[ -f "$version/$variant/Dockerfile" ] || continue
    cp init.sql $version/$variant
    cp pgaudit-docker-entrypoint.sh $version/$variant
    docker build $version/$variant -t postgres-pgaudit:$version-$variant
  done
  docker build $version -t postgres-pgaudit:$version
done
