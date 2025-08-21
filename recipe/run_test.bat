@echo on

set TESTS_TO_SKIP=--deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_history_is_preserved
set TESTS_TO_SKIP=%TESTS_TO_SKIP% --deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_new_requests_are_used
set TESTS_TO_SKIP=%TESTS_TO_SKIP% --deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_permissions_denied
set TESTS_TO_SKIP=%TESTS_TO_SKIP% --deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_requests_ntlm
set TESTS_TO_SKIP=%TESTS_TO_SKIP% --deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_requests_ntlm_hash

pip check
start /B python -m tests.test_server
pytest tests -v %TESTS_TO_SKIP% --ignore=tests/functional/test_functional.py
