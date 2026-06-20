"""Add case_sessions.last_activity_at for persistent session tracking.

Revision ID: 002_add_last_activity_at
Revises: 001_add_evaluations
Create Date: 2026-06-19

"""

from typing import Sequence, Union

import sqlalchemy as sa
from alembic import op

revision: str = "002_add_last_activity_at"
down_revision: Union[str, Sequence[str], None] = "001_add_evaluations"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column(
        "case_sessions",
        sa.Column("last_activity_at", sa.DateTime(timezone=True), nullable=True),
    )
    op.execute(
        "UPDATE case_sessions SET last_activity_at = created_at "
        "WHERE last_activity_at IS NULL"
    )
    op.alter_column(
        "case_sessions",
        "last_activity_at",
        existing_type=sa.DateTime(timezone=True),
        nullable=False,
        server_default=sa.text("(CURRENT_TIMESTAMP)"),
    )
    op.create_index(
        "ix_case_sessions_last_activity_at",
        "case_sessions",
        ["last_activity_at"],
    )


def downgrade() -> None:
    op.drop_index("ix_case_sessions_last_activity_at", table_name="case_sessions")
    op.drop_column("case_sessions", "last_activity_at")
