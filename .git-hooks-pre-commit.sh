#!/usr/bin/env bash
# .git-hooks-pre-commit.sh
# ########################
# This script prevents buggy code from being commited. It was made to work
# as a pre-commit git hook. So everytime you try a commit, it runs and checks
# if the tests are passing.
#
# HOW TO INSTALL IT:
# ##################
# This file must be placed in '.git/hooks/pre-commit' and have the eXecutable
# permission.
#
# $ cp .git-hooks-pre-commit.sh > .git/hooks/pre-commit
# $ chmod a+x .git/hooks/pre-commit
#
######################################################################

set -Eeo pipefail

trapInfo() {
  echo "Your commit failed!"
  echo "👆 Check the logs above 👆"
  return 1
}

trap 'trapInfo "$BASH_SOURCE" "$FUNCNAME" "$LINENO"' ERR

main() {
  echo "Running Unit Tests..."
  rails test
}

######################################################################

main "$@"
