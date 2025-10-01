#!/usr/bin/env fish

function je --description 'create journal entry'
    gh workflow run --repo lingrino/website --ref main journal.yml --field entry="$argv[1]"
end
