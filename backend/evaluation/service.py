from models.db import CaseSession, Evaluation, User
from evaluation.repository import EvaluationRepository
from evaluation.response import (
    DebriefResponse,
    EvaluationFindingResponse,
    ScoresResponse,
)
from evaluation.scorer import compute_score
from exceptions.auth_exceptions import ConflictError, ForbiddenError, NotFoundError
from sessions.chat_repository import ActionLogRepository
from sessions.repository import SessionRepository


def _can_read_evaluation(session: CaseSession, user: User) -> bool:
    return user.role in ("educator", "admin") or session.user_id == user.id


def _to_scores_response(evaluation: Evaluation) -> ScoresResponse:
    return ScoresResponse(
        session_id=evaluation.session_id,
        case_version=evaluation.case_version,
        total_score=evaluation.total_score,
        score_diagnosis=evaluation.score_diagnosis,
        score_diagnostics=evaluation.score_diagnostics,
        score_treatment=evaluation.score_treatment,
        score_safety=evaluation.score_safety,
        scored_at=evaluation.scored_at,
    )


def _to_debrief_response(
    evaluation: Evaluation,
    conclusions: dict[str, object] | None,
) -> DebriefResponse:
    return DebriefResponse(
        session_id=evaluation.session_id,
        case_version=evaluation.case_version,
        total_score=evaluation.total_score,
        score_diagnosis=evaluation.score_diagnosis,
        score_diagnostics=evaluation.score_diagnostics,
        score_treatment=evaluation.score_treatment,
        score_safety=evaluation.score_safety,
        scored_at=evaluation.scored_at,
        findings=[
            EvaluationFindingResponse(
                category=finding.category,
                finding_type=finding.finding_type,
                severity=finding.severity,
                expected=finding.expected,
                actual=finding.actual,
                why_matters=finding.why_matters,
                how_to_correct=finding.how_to_correct,
                deduction_points=finding.deduction_points,
            )
            for finding in evaluation.findings
        ],
        reference_solution=evaluation.reference_solution,
        conclusions=dict(conclusions or {}),
    )


async def _get_session_for_read(
    session_id: str,
    current_user: User,
    session_repo: SessionRepository,
) -> CaseSession:
    session = await session_repo.get_by_session_id(session_id)
    if session is None:
        raise NotFoundError(f"Session '{session_id}' not found")
    if not _can_read_evaluation(session, current_user):
        raise ForbiddenError("You do not have access to this evaluation")
    return session


async def _get_scored_evaluation(
    session: CaseSession,
    eval_repo: EvaluationRepository,
) -> Evaluation:
    if session.status != "completed":
        raise ConflictError("Session is not finished")
    evaluation = await eval_repo.get_by_session_id(session.session_id)
    if evaluation is None:
        raise ConflictError("Evaluation not yet available")
    return evaluation


async def score_session(
    session_id: str,
    session_repo: SessionRepository,
    log_repo: ActionLogRepository,
    eval_repo: EvaluationRepository,
) -> Evaluation:
    session = await session_repo.get_by_session_id(session_id)
    if session is None:
        raise NotFoundError(f"Session '{session_id}' not found")
    if session.status != "completed":
        raise ConflictError("Session is not finished")

    existing = await eval_repo.get_by_session_id(session_id)
    if existing is not None:
        return existing

    ordered_tests = await log_repo.get_ordered_tests(session_id)
    conclusions = dict(session.conclusions or {})
    snapshot = dict(session.frozen_case_snapshot)
    result = compute_score(snapshot, conclusions, ordered_tests)
    case_version = int(snapshot.get("version") or 1)
    return await eval_repo.create(session_id, case_version, result)


async def get_scores(
    session_id: str,
    current_user: User,
    session_repo: SessionRepository,
    eval_repo: EvaluationRepository,
) -> ScoresResponse:
    session = await _get_session_for_read(session_id, current_user, session_repo)
    evaluation = await _get_scored_evaluation(session, eval_repo)
    return _to_scores_response(evaluation)


async def get_debrief(
    session_id: str,
    current_user: User,
    session_repo: SessionRepository,
    eval_repo: EvaluationRepository,
) -> DebriefResponse:
    session = await _get_session_for_read(session_id, current_user, session_repo)
    evaluation = await _get_scored_evaluation(session, eval_repo)
    return _to_debrief_response(evaluation, session.conclusions)
