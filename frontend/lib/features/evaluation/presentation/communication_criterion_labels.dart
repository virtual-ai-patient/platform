/// Human-readable labels for communication rubric criterion keys from the API.
String communicationCriterionLabel(String criterionKey) {
  return _labels[criterionKey] ??
      criterionKey.replaceAll('_', ' ').replaceFirstMapped(
            RegExp(r'^\w'),
            (m) => m.group(0)!.toUpperCase(),
          );
}

const Map<String, String> _labels = {
  'open_ended_questions': 'Open-ended questions',
  'empathy': 'Empathy',
  'structured_history': 'Structured history',
  'closing_the_loop': 'Closing the loop',
  'no_leading_questions': 'No leading questions',
};
