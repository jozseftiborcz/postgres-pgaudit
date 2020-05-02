#!/bin/bash
versions=( */ )
versions=( "${versions[@]%/}" )

for version in "${versions[@]}"; do
  for variant in alpine; do
		[ -f "$version/$variant/Dockerfile" ] || continue
    docker build $version/$variant -t postgres-pgaudit:$version-$variant
  done
  docker build $version -t postgres-pgaudit:$version
done
