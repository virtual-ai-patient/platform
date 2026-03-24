class FriendlyErrorData {
  const FriendlyErrorData({
    required this.title,
    required this.message,
    this.canReset = false,
  });

  final String title;
  final String message;
  final bool canReset;
}
