from exceptions.auth_exceptions import ForbiddenError, NotFoundError
from models.db import User
from sessions.chat_repository import ActionLogRepository
from sessions.diagnostics_response import (
    AvailableTestItem,
    AvailableTestsResponse,
    TestResultResponse,
)
from sessions.repository import SessionRepository

_NORMAL_RESULT = TestResultResponse(
    test_name="",
    result_type="text_report",
    value="Normal / No significant findings.",
    unit=None,
    reference_range=None,
    is_normal_default=True,
)


async def get_available_tests(
    session_id: str,
    current_user: User,
    session_repo: SessionRepository,
) -> AvailableTestsResponse:
    session = await session_repo.get_by_session_id(session_id)
    if session is None:
        raise NotFoundError(f"Session '{session_id}' not found")
    if session.user_id != current_user.id:
        raise ForbiddenError("You do not have access to this session")

    expected = session.frozen_case_snapshot["investigations"]["expected"]
    tests: list[AvailableTestItem] = []
    for category in ("must_order", "optional", "should_not_order"):
        for test_name in expected.get(category, []):
            tests.append(AvailableTestItem(test_name=test_name, category=category))

    return AvailableTestsResponse(tests=tests)


async def order_test(
    session_id: str,
    test_id: str,
    current_user: User,
    session_repo: SessionRepository,
    log_repo: ActionLogRepository,
) -> TestResultResponse:
    session = await session_repo.get_by_session_id(session_id)
    if session is None:
        raise NotFoundError(f"Session '{session_id}' not found")
    if session.user_id != current_user.id:
        raise ForbiddenError("You do not have access to this session")

    results = session.frozen_case_snapshot["investigations"]["results"]
    match = next((r for r in results if r["test_name"] == test_id), None)

    if match is not None:
        response = TestResultResponse(
            test_name=match["test_name"],
            result_type=match["result_type"],
            value=match["value"],
            unit=match.get("unit"),
            reference_range=match.get("reference_range"),
            is_normal_default=False,
        )
    else:
        response = TestResultResponse(
            test_name=test_id,
            result_type=_NORMAL_RESULT.result_type,
            value=_NORMAL_RESULT.value,
            unit=None,
            reference_range=None,
            is_normal_default=True,
        )

    already_logged = await log_repo.find_test_order(session_id, test_id)
    if not already_logged:
        await log_repo.create(session_id, "system", f"TEST_ORDERED:{test_id}")

    return response
