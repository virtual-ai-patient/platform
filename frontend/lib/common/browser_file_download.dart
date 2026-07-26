import 'dart:typed_data';

import 'package:frontend/common/browser_file_download_stub.dart'
    if (dart.library.html) 'package:frontend/common/browser_file_download_web.dart'
    as impl;

typedef BrowserFileSaver =
    void Function({
      required Uint8List bytes,
      required String filename,
      required String mimeType,
    });

/// Default saver — Blob download on web; throws on other platforms.
BrowserFileSaver saveBrowserFile = impl.saveBrowserFile;
