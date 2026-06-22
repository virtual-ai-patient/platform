import config
from communication_eval.judge import run_judge
from communication_eval.repository import CommunicationEvaluationRepository
from communication_eval.response import (
    CommunicationCriterionResponse,
    CommunicationEvaluationResponse,
)
from core.provider import AIProvider
from exceptions.auth_exceptions import ConflictError, ForbiddenError, NotFoundError
from models.db import CaseSession, CommunicationEvaluation, User
from sessions.chat_repository import ActionLogRepository
from sessions.repository import SessionRepository


def _can_read_evaluation(session: CaseSession, user: User) -> bool:
    return user.role in ("educator", "admin") or session.user_id == user.id


def _to_response(
    evaluation: CommunicationEvaluation,
) -> CommunicationEvaluationResponse:
    return CommunicationEvaluationResponse(
        session_id=evaluation.session_id,
        model=evaluation.model,
        prompt_version=evaluation.prompt_version,
        total_score=evaluation.total_score,
        created_at=evaluation.created_at,
        criteria=[
            CommunicationCriterionResponse(
                criterion=item.criterion,
                score=item.score,
                rationale=item.rationale,
                quote=item.quote,
            )
            for item in evaluation.criteria
        ],
    )


async def _get_session_for_access(
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


def _require_finished(session: CaseSession) -> None:
    if session.status != "completed":
        raise ConflictError("Session is not finished")


def _resolved_model_name(provider: AIProvider) -> str:
    model_name = getattr(provider, "model_name", None)
    if isinstance(model_name, str):
        return model_name
    return config.COMMUNICATION_EVAL_MODEL


async def run_communication_evaluation(
    session_id: str,
    current_user: User,
    session_repo: SessionRepository,
    log_repo: ActionLogRepository,
    comm_eval_repo: CommunicationEvaluationRepository,
    provider: AIProvider,
) -> CommunicationEvaluationResponse:
    session = await _get_session_for_access(session_id, current_user, session_repo)
    _require_finished(session)

    existing = await comm_eval_repo.get_by_session_id(session_id)
    if existing is not None:
        return _to_response(existing)

    logs = await log_repo.get_history(session_id)
    judge_output, total_score = await run_judge(logs, provider)
    evaluation = await comm_eval_repo.create(
        session_id=session_id,
        model=_resolved_model_name(provider),
        prompt_version=config.COMMUNICATION_EVAL_PROMPT_VERSION,
        total_score=total_score,
        judge_output=judge_output,
    )
    return _to_response(evaluation)


async def get_communication_evaluation(
    session_id: str,
    current_user: User,
    session_repo: SessionRepository,
    comm_eval_repo: CommunicationEvaluationRepository,
) -> CommunicationEvaluationResponse:
    session = await _get_session_for_access(session_id, current_user, session_repo)
    _require_finished(session)

    evaluation = await comm_eval_repo.get_by_session_id(session_id)
    if evaluation is None:
        raise ConflictError("Communication evaluation not yet available")
    return _to_response(evaluation)
