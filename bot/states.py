from aiogram.fsm.state import State, StatesGroup


class CaseStates(StatesGroup):
    """FSM states for the clinical case workflow (placeholder for future use)."""

    selecting_case = State()
    in_conversation = State()
    ordering_test = State()
    submitting_diagnosis = State()
    submitting_treatment = State()
