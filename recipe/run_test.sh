#!/usr/bin/env bash

set -euo pipefail

tests_to_skip=(
  "--deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_history_is_preserved "
  "--deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_new_requests_are_used "
  "--deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_permissions_denied "
  "--deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_requests_ntlm "
  "--deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_requests_ntlm_hash"
)

pip check
python -m tests.test_server &
pytest tests -v ${tests_to_skip[@]} --ignore=tests/functional/test_functional.py 
