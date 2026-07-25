import 'dart:typed_data';

/// Non-web fallback — tests inject their own [saveBrowserFile] override.
void saveBrowserFile({
  required Uint8List bytes,
  required String filename,
  required String mimeType,
}) {
  throw UnsupportedError(
    'Browser file download is only available on Flutter web. '
    'Inject a saveBrowserFile override in tests.',
  );
}
