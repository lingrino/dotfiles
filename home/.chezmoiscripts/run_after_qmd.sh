#!/usr/bin/env sh
set -euo pipefail

export PATH="${HOME}/.bun/bin:${PATH}"

# name|path|context
COLLECTIONS="
notes|${HOME}/Documents/notes|personal notes
content|${HOME}/projects/content-archive|web archive of all journal link entries
"

EXISTING=$(qmd collection list 2>&1 || true)

echo "${COLLECTIONS}" | while IFS='|' read -r NAME DIR CONTEXT; do
    if [[ -z ${NAME} ]]; then
        continue
    fi
    if [[ ! -d ${DIR} ]]; then
        echo "qmd: skipping collection ${NAME} (${DIR} does not exist)"
        continue
    fi
    if [[ ${EXISTING} != *"(qmd://${NAME}/)"* ]]; then
        qmd collection add "${DIR}" --name "${NAME}" >/dev/null
        echo "qmd: added collection ${NAME}"
    fi
    qmd context add "qmd://${NAME}" "${CONTEXT}" >/dev/null
done

OUTPUT_UPDATE=$(qmd update 2>&1)
if echo "${OUTPUT_UPDATE}" | grep "Indexed:" | grep -qv "0 new, 0 updated"; then
    echo "qmd: index updated"
fi

OUTPUT_EMBED=$(qmd embed 2>&1)
if [[ ${OUTPUT_EMBED} != *"already have embeddings"* ]]; then
    echo "qmd: embeddings updated"
fi
