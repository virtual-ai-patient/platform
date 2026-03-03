FROM python:3.14-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY pyproject.toml ./
RUN pip install --no-cache-dir "uv"
RUN uv pip install --system . || uv pip install --system aiogram httpx pydantic

COPY . .

CMD ["python", "bot.py"]

