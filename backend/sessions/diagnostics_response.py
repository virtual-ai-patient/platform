from pydantic import BaseModel


class AvailableTestItem(BaseModel):
    test_name: str
    category: str


class AvailableTestsResponse(BaseModel):
    tests: list[AvailableTestItem]


class TestResultResponse(BaseModel):
    test_name: str
    result_type: str
    value: str
    unit: str | None
    reference_range: str | None
    is_normal_default: bool
