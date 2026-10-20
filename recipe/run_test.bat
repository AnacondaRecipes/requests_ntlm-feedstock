@echo on

set TESTS_TO_SKIP=--deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_history_is_preserved
set TESTS_TO_SKIP=%TESTS_TO_SKIP% --deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_new_requests_are_used
set TESTS_TO_SKIP=%TESTS_TO_SKIP% --deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_permissions_denied
set TESTS_TO_SKIP=%TESTS_TO_SKIP% --deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_requests_ntlm
set TESTS_TO_SKIP=%TESTS_TO_SKIP% --deselect=tests/unit/test_requests_ntlm.py::TestRequestsNtlm::test_requests_ntlm_hash

pip check
if errorlevel 1 exit 1

set SERVER_PID=
for /f %%i in ('powershell -NoProfile -Command "(Start-Process -FilePath python -ArgumentList '-m','tests.test_server' -WorkingDirectory '%CD%' -WindowStyle Hidden -PassThru).Id"') do set SERVER_PID=%%i
if not defined SERVER_PID exit 1

pytest tests -v %TESTS_TO_SKIP% --ignore=tests/functional/test_functional.py
set TEST_EXIT=%ERRORLEVEL%

taskkill /F /T /PID %SERVER_PID% >nul 2>&1
exit /b %TEST_EXIT%
