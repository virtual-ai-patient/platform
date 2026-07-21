import csv
import io
import json
from collections.abc import AsyncIterator
from typing import Any

from pydantic import BaseModel

_INJECTION_PREFIXES = ("=", "+", "-", "@")


def _sanitize_cell(value: Any) -> str:
    if isinstance(value, dict | list):
        text = json.dumps(value, sort_keys=True)
    elif value is None:
        text = ""
    else:
        text = str(value)
    if text and text[0] in _INJECTION_PREFIXES:
        return "'" + text
    return text


async def stream_csv(
    fieldnames: list[str], rows: AsyncIterator[BaseModel]
) -> AsyncIterator[str]:
    buffer = io.StringIO()
    writer = csv.writer(buffer, lineterminator="\r\n")
    writer.writerow(fieldnames)
    yield buffer.getvalue()
    buffer.seek(0)
    buffer.truncate(0)

    async for row in rows:
        data = row.model_dump(mode="json")
        writer.writerow([_sanitize_cell(data[name]) for name in fieldnames])
        yield buffer.getvalue()
        buffer.seek(0)
        buffer.truncate(0)


async def stream_json(rows: AsyncIterator[BaseModel]) -> AsyncIterator[str]:
    yield "["
    first = True
    async for row in rows:
        if not first:
            yield ","
        first = False
        yield row.model_dump_json()
    yield "]"
