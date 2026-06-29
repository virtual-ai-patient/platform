"""Create base schema (users, cases, sessions, action logs).

Revision ID: 000_initial_schema
Revises:
Create Date: 2026-06-29

"""

from typing import Sequence, Union

import sqlalchemy as sa
from alembic import op

revision: str = "000_initial_schema"
down_revision: Union[str, Sequence[str], None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        "users",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("username", sa.String(), nullable=False),
        sa.Column("email", sa.String(), nullable=False),
        sa.Column("hashed_password", sa.String(), nullable=False),
        sa.Column("role", sa.String(), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("username"),
        sa.UniqueConstraint("email"),
    )
    op.create_table(
        "clinical_cases",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("case_id", sa.String(), nullable=False),
        sa.Column("status", sa.String(), nullable=False),
        sa.Column("version", sa.Integer(), nullable=False),
        sa.Column("created_by", sa.String(), nullable=False),
        sa.Column("title", sa.String(), nullable=False),
        sa.Column("language", sa.String(), nullable=False),
        sa.Column("difficulty", sa.String(), nullable=False),
        sa.Column("specialty", sa.String(), nullable=False),
        sa.Column("age", sa.Integer(), nullable=False),
        sa.Column("sex", sa.String(), nullable=False),
        sa.Column("persona", sa.Text(), nullable=False),
        sa.Column("chief_complaint", sa.Text(), nullable=False),
        sa.Column("history_of_present_illness", sa.Text(), nullable=False),
        sa.Column("final_diagnosis", sa.Text(), nullable=False),
        sa.Column("severity_or_stage", sa.Text(), nullable=True),
        sa.Column("weight_diagnosis", sa.Float(), nullable=False),
        sa.Column("weight_diagnostics", sa.Float(), nullable=False),
        sa.Column("weight_treatment", sa.Float(), nullable=False),
        sa.Column("weight_safety", sa.Float(), nullable=False),
        sa.ForeignKeyConstraint(["created_by"], ["users.id"]),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("case_id"),
    )
    op.create_table(
        "reset_tokens",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("user_id", sa.String(), nullable=False),
        sa.Column("token_hash", sa.String(), nullable=False),
        sa.Column("expires_at", sa.DateTime(timezone=True), nullable=False),
        sa.Column("is_used", sa.Boolean(), nullable=False),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"]),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "case_acceptable_answers",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("case_id", sa.String(), nullable=False),
        sa.Column("field", sa.String(), nullable=False),
        sa.Column("answer", sa.Text(), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["clinical_cases.id"]),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "case_catalog_hints",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("case_id", sa.String(), nullable=False),
        sa.Column("hint", sa.String(), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["clinical_cases.id"]),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "case_differentials",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("case_id", sa.String(), nullable=False),
        sa.Column("rank", sa.Integer(), nullable=False),
        sa.Column("diagnosis", sa.Text(), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["clinical_cases.id"]),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "case_expected_tests",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("case_id", sa.String(), nullable=False),
        sa.Column("test_name", sa.String(), nullable=False),
        sa.Column("category", sa.String(), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["clinical_cases.id"]),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "case_history_points",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("case_id", sa.String(), nullable=False),
        sa.Column("point_type", sa.String(), nullable=False),
        sa.Column("content", sa.Text(), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["clinical_cases.id"]),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "case_investigation_results",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("case_id", sa.String(), nullable=False),
        sa.Column("test_name", sa.String(), nullable=False),
        sa.Column("result_type", sa.String(), nullable=False),
        sa.Column("value", sa.Text(), nullable=False),
        sa.Column("unit", sa.String(), nullable=True),
        sa.Column("reference_range", sa.String(), nullable=True),
        sa.ForeignKeyConstraint(["case_id"], ["clinical_cases.id"]),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "case_management_steps",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("case_id", sa.String(), nullable=False),
        sa.Column("step_type", sa.String(), nullable=False),
        sa.Column("step", sa.Text(), nullable=False),
        sa.Column("order", sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["clinical_cases.id"]),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "case_safety_errors",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("case_id", sa.String(), nullable=False),
        sa.Column("error", sa.Text(), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["clinical_cases.id"]),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "case_sessions",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("session_id", sa.String(), nullable=False),
        sa.Column("user_id", sa.String(), nullable=False),
        sa.Column("clinical_case_id", sa.String(), nullable=False),
        sa.Column("status", sa.String(), nullable=False),
        sa.Column("frozen_case_snapshot", sa.JSON(), nullable=False),
        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            server_default=sa.text("now()"),
            nullable=False,
        ),
        sa.Column("conclusions", sa.JSON(), nullable=True),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"]),
        sa.ForeignKeyConstraint(["clinical_case_id"], ["clinical_cases.id"]),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("session_id"),
    )
    op.create_table(
        "case_tags",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("case_id", sa.String(), nullable=False),
        sa.Column("tag", sa.String(), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["clinical_cases.id"]),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "case_tone_presets",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("case_id", sa.String(), nullable=False),
        sa.Column("preset", sa.String(), nullable=False),
        sa.ForeignKeyConstraint(["case_id"], ["clinical_cases.id"]),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_table(
        "action_logs",
        sa.Column("id", sa.String(), nullable=False),
        sa.Column("session_id", sa.String(), nullable=False),
        sa.Column("role", sa.String(), nullable=False),
        sa.Column("content", sa.Text(), nullable=False),
        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            server_default=sa.text("now()"),
            nullable=False,
        ),
        sa.ForeignKeyConstraint(["session_id"], ["case_sessions.session_id"]),
        sa.PrimaryKeyConstraint("id"),
    )


def downgrade() -> None:
    op.drop_table("action_logs")
    op.drop_table("case_tone_presets")
    op.drop_table("case_tags")
    op.drop_table("case_sessions")
    op.drop_table("case_safety_errors")
    op.drop_table("case_management_steps")
    op.drop_table("case_investigation_results")
    op.drop_table("case_history_points")
    op.drop_table("case_expected_tests")
    op.drop_table("case_differentials")
    op.drop_table("case_catalog_hints")
    op.drop_table("case_acceptable_answers")
    op.drop_table("reset_tokens")
    op.drop_table("clinical_cases")
    op.drop_table("users")
