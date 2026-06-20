#!/bin/sh
set -e

uv run python <<'PY'
from sqlalchemy import create_engine, inspect, text

from config import DATABASE_URL

url = DATABASE_URL.replace("+asyncpg", "+psycopg2", 1)
engine = create_engine(url)
inspector = inspect(engine)
tables = set(inspector.get_table_names())

if "alembic_version" not in tables:
    version = None
else:
    with engine.connect() as conn:
        version = conn.execute(text("SELECT version_num FROM alembic_version")).scalar()

if version is None and "case_sessions" in tables:
    print("Legacy database detected; stamping alembic at 001_add_evaluations")
    import subprocess

    subprocess.check_call(["uv", "run", "alembic", "stamp", "001_add_evaluations"])
PY

uv run alembic upgrade head
exec uv run uvicorn server:app --host 0.0.0.0 --port 8000
