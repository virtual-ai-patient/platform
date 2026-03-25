import uuid

from sqlalchemy import Boolean, DateTime, Float, ForeignKey, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from models.database import Base


class User(Base):
    __tablename__ = "users"

    id: Mapped[str] = mapped_column(
        String, primary_key=True, default=lambda: str(uuid.uuid4())
    )
    username: Mapped[str] = mapped_column(String, unique=True, nullable=False)
    email: Mapped[str] = mapped_column(String, unique=True, nullable=False)
    hashed_password: Mapped[str] = mapped_column(String, nullable=False)
    role: Mapped[str] = mapped_column(String, nullable=False, default="learner")


class ResetToken(Base):
    __tablename__ = "reset_tokens"

    id: Mapped[str] = mapped_column(
        String, primary_key=True, default=lambda: str(uuid.uuid4())
    )
    user_id: Mapped[str] = mapped_column(String, ForeignKey("users.id"), nullable=False)
    token_hash: Mapped[str] = mapped_column(String, nullable=False)
    expires_at: Mapped[DateTime] = mapped_column(
        DateTime(timezone=True), nullable=False
    )
    is_used: Mapped[bool] = mapped_column(Boolean, nullable=False, default=False)


# ---------------------------------------------------------------------------
# Clinical Case (normalized)
# ---------------------------------------------------------------------------


def _uuid() -> str:
    return str(uuid.uuid4())


class ClinicalCase(Base):
    __tablename__ = "clinical_cases"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    case_id: Mapped[str] = mapped_column(String, unique=True, nullable=False)
    status: Mapped[str] = mapped_column(String, nullable=False, default="draft")
    version: Mapped[int] = mapped_column(Integer, nullable=False, default=1)
    created_by: Mapped[str] = mapped_column(
        String, ForeignKey("users.id"), nullable=False
    )

    # metadata
    title: Mapped[str] = mapped_column(String, nullable=False)
    language: Mapped[str] = mapped_column(String, nullable=False, default="en")
    difficulty: Mapped[str] = mapped_column(String, nullable=False)
    specialty: Mapped[str] = mapped_column(String, nullable=False)

    # patient
    age: Mapped[int] = mapped_column(Integer, nullable=False)
    sex: Mapped[str] = mapped_column(String, nullable=False)
    persona: Mapped[str] = mapped_column(Text, nullable=False)

    # presentation
    chief_complaint: Mapped[str] = mapped_column(Text, nullable=False)
    history_of_present_illness: Mapped[str] = mapped_column(Text, nullable=False)

    # ground truth
    final_diagnosis: Mapped[str] = mapped_column(Text, nullable=False)
    severity_or_stage: Mapped[str | None] = mapped_column(Text, nullable=True)

    # scoring weights
    weight_diagnosis: Mapped[float] = mapped_column(Float, nullable=False)
    weight_diagnostics: Mapped[float] = mapped_column(Float, nullable=False)
    weight_treatment: Mapped[float] = mapped_column(Float, nullable=False)
    weight_safety: Mapped[float] = mapped_column(Float, nullable=False)

    # child rows
    tags: Mapped[list["CaseTag"]] = relationship(
        "CaseTag", back_populates="case", cascade="all, delete-orphan"
    )
    tone_presets: Mapped[list["CaseTonePreset"]] = relationship(
        "CaseTonePreset", back_populates="case", cascade="all, delete-orphan"
    )
    history_points: Mapped[list["CaseHistoryPoint"]] = relationship(
        "CaseHistoryPoint", back_populates="case", cascade="all, delete-orphan"
    )
    differentials: Mapped[list["CaseDifferential"]] = relationship(
        "CaseDifferential",
        back_populates="case",
        cascade="all, delete-orphan",
        order_by="CaseDifferential.rank",
    )
    catalog_hints: Mapped[list["CaseCatalogHint"]] = relationship(
        "CaseCatalogHint", back_populates="case", cascade="all, delete-orphan"
    )
    expected_tests: Mapped[list["CaseExpectedTest"]] = relationship(
        "CaseExpectedTest", back_populates="case", cascade="all, delete-orphan"
    )
    investigation_results: Mapped[list["CaseInvestigationResult"]] = relationship(
        "CaseInvestigationResult", back_populates="case", cascade="all, delete-orphan"
    )
    management_steps: Mapped[list["CaseManagementStep"]] = relationship(
        "CaseManagementStep",
        back_populates="case",
        cascade="all, delete-orphan",
        order_by="CaseManagementStep.order",
    )
    acceptable_answers: Mapped[list["CaseAcceptableAnswer"]] = relationship(
        "CaseAcceptableAnswer", back_populates="case", cascade="all, delete-orphan"
    )
    safety_errors: Mapped[list["CaseSafetyError"]] = relationship(
        "CaseSafetyError", back_populates="case", cascade="all, delete-orphan"
    )


class CaseTag(Base):
    __tablename__ = "case_tags"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    case_id: Mapped[str] = mapped_column(
        String, ForeignKey("clinical_cases.id"), nullable=False
    )
    tag: Mapped[str] = mapped_column(String, nullable=False)
    case: Mapped[ClinicalCase] = relationship("ClinicalCase", back_populates="tags")


class CaseTonePreset(Base):
    __tablename__ = "case_tone_presets"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    case_id: Mapped[str] = mapped_column(
        String, ForeignKey("clinical_cases.id"), nullable=False
    )
    preset: Mapped[str] = mapped_column(String, nullable=False)
    case: Mapped[ClinicalCase] = relationship(
        "ClinicalCase", back_populates="tone_presets"
    )


class CaseHistoryPoint(Base):
    """Stores must_ask / nice_to_ask / red_flag history points."""

    __tablename__ = "case_history_points"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    case_id: Mapped[str] = mapped_column(
        String, ForeignKey("clinical_cases.id"), nullable=False
    )
    point_type: Mapped[str] = mapped_column(String, nullable=False)
    content: Mapped[str] = mapped_column(Text, nullable=False)
    case: Mapped[ClinicalCase] = relationship(
        "ClinicalCase", back_populates="history_points"
    )


class CaseDifferential(Base):
    __tablename__ = "case_differentials"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    case_id: Mapped[str] = mapped_column(
        String, ForeignKey("clinical_cases.id"), nullable=False
    )
    rank: Mapped[int] = mapped_column(Integer, nullable=False)
    diagnosis: Mapped[str] = mapped_column(Text, nullable=False)
    case: Mapped[ClinicalCase] = relationship(
        "ClinicalCase", back_populates="differentials"
    )


class CaseCatalogHint(Base):
    __tablename__ = "case_catalog_hints"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    case_id: Mapped[str] = mapped_column(
        String, ForeignKey("clinical_cases.id"), nullable=False
    )
    hint: Mapped[str] = mapped_column(String, nullable=False)
    case: Mapped[ClinicalCase] = relationship(
        "ClinicalCase", back_populates="catalog_hints"
    )


class CaseExpectedTest(Base):
    """must_order / optional / should_not_order tests."""

    __tablename__ = "case_expected_tests"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    case_id: Mapped[str] = mapped_column(
        String, ForeignKey("clinical_cases.id"), nullable=False
    )
    test_name: Mapped[str] = mapped_column(String, nullable=False)
    category: Mapped[str] = mapped_column(String, nullable=False)
    case: Mapped[ClinicalCase] = relationship(
        "ClinicalCase", back_populates="expected_tests"
    )


class CaseInvestigationResult(Base):
    __tablename__ = "case_investigation_results"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    case_id: Mapped[str] = mapped_column(
        String, ForeignKey("clinical_cases.id"), nullable=False
    )
    test_name: Mapped[str] = mapped_column(String, nullable=False)
    result_type: Mapped[str] = mapped_column(String, nullable=False)
    value: Mapped[str] = mapped_column(Text, nullable=False)
    unit: Mapped[str | None] = mapped_column(String, nullable=True)
    reference_range: Mapped[str | None] = mapped_column(String, nullable=True)
    case: Mapped[ClinicalCase] = relationship(
        "ClinicalCase", back_populates="investigation_results"
    )


class CaseManagementStep(Base):
    """diagnostic_plan / treatment_plan / contraindication / follow_up steps."""

    __tablename__ = "case_management_steps"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    case_id: Mapped[str] = mapped_column(
        String, ForeignKey("clinical_cases.id"), nullable=False
    )
    step_type: Mapped[str] = mapped_column(String, nullable=False)
    step: Mapped[str] = mapped_column(Text, nullable=False)
    order: Mapped[int] = mapped_column(Integer, nullable=False)
    case: Mapped[ClinicalCase] = relationship(
        "ClinicalCase", back_populates="management_steps"
    )


class CaseAcceptableAnswer(Base):
    __tablename__ = "case_acceptable_answers"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    case_id: Mapped[str] = mapped_column(
        String, ForeignKey("clinical_cases.id"), nullable=False
    )
    field: Mapped[str] = mapped_column(String, nullable=False)
    answer: Mapped[str] = mapped_column(Text, nullable=False)
    case: Mapped[ClinicalCase] = relationship(
        "ClinicalCase", back_populates="acceptable_answers"
    )


class CaseSafetyError(Base):
    __tablename__ = "case_safety_errors"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    case_id: Mapped[str] = mapped_column(
        String, ForeignKey("clinical_cases.id"), nullable=False
    )
    error: Mapped[str] = mapped_column(Text, nullable=False)
    case: Mapped[ClinicalCase] = relationship(
        "ClinicalCase", back_populates="safety_errors"
    )
