#!/bin/sh

# https://man.sr.ht/git.sr.ht/#setting-a-custom-readme

if [ "$#" -ne 2 ] || ! [ -f "$2" ]; then
	echo "Usage: $0 REPO_NAME README_FILE" >&2
	exit 1
fi

repo="$(curl --get --silent --oauth2-bearer "$HUTTOKEN" --data-urlencode \
	query='query { repositoryByName(name: "'"$1"'") { id } }' \
	https://git.sr.ht/query | jq .data.repositoryByName.id)"

jq -sR '{
    "query": "mutation UpdateRepo($id: Int!, $readme: String!) {
      updateRepository(id: $id, input: { readme: $readme }) { id }
    }", "variables": {
      "id": '"$repo"',
      "readme": .
    } }' <"$2" |
	curl --oauth2-bearer "$HUTTOKEN" \
		--header "Content-Type: application/json" \
		--data @- https://git.sr.ht/query
