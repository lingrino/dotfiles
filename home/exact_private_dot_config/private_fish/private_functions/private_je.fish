#!/usr/bin/env fish

function je --description 'create journal entry'
    gh workflow run --repo lingrino/site --ref main journal.yml --field entry="$argv[1]"
end
