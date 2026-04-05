import 'package:frontend/network/openapi.dart' as generated;
import 'package:shared_preferences/shared_preferences.dart';

class AuthSession {
  const AuthSession({
    required this.user,
    required this.tokens,
  });

  final generated.UserResponse user;
  final generated.TokenResponse tokens;
}

abstract class AuthRepositoryContract {
  Future<AuthSession> loginAndVerify({
    required String username,
    required String password,
  });

  Future<void> logout();

  Future<generated.UserResponse> signup({
    required String username,
    required String email,
    required String password,
  });

  Future<String> requestPasswordReset({required String email});
}

class AuthRepository implements AuthRepositoryContract {
  AuthRepository({required String baseUrl}) {
    _openapi = generated.Openapi(basePathOverride: baseUrl);
    _authApi = _openapi.getAuthApi();
  }

  static const _prefRefreshKey = 'vap_refresh_token';

  /// Shared HTTP client and OAuth token store for other domain APIs (e.g. cases).
  generated.Openapi get openapiClient => _openapi;

  late final generated.Openapi _openapi;
  late final generated.AuthApi _authApi;
  AuthSession? _session;
  String? _refreshToken;

  AuthSession? get currentSession => _session;

  Future<void> _persistRefreshToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    if (token == null || token.isEmpty) {
      await prefs.remove(_prefRefreshKey);
    } else {
      await prefs.setString(_prefRefreshKey, token);
    }
  }

  /// After a browser reload, exchange stored refresh token for new access and verify user.
  Future<AuthSession?> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_prefRefreshKey);
    if (stored == null || stored.isEmpty) {
      return null;
    }
    _openapi.setOAuthToken('OAuth2PasswordBearer', '');
    try {
      final tokens = await refreshToken(stored);
      final user = await verifyCurrentToken();
      final session = AuthSession(user: user, tokens: tokens);
      _session = session;
      await _persistRefreshToken(tokens.refreshToken);
      return session;
    } catch (_) {
      await _persistRefreshToken(null);
      _session = null;
      _refreshToken = null;
      _openapi.setOAuthToken('OAuth2PasswordBearer', '');
      return null;
    }
  }

  @override
  Future<AuthSession> loginAndVerify({
    required String username,
    required String password,
  }) async {
    final loginResponse = await _authApi.loginAuthLoginPost(
      username: username,
      password: password,
      grantType: 'password',
      scope: '',
    );
    final tokens = loginResponse.data;
    if (tokens == null) {
      throw StateError('Login returned empty token response');
    }

    _openapi.setOAuthToken('OAuth2PasswordBearer', tokens.accessToken);
    final verifyResponse = await _authApi.verifyAuthVerifyGet();
    final user = verifyResponse.data;
    if (user == null) {
      throw StateError('Verify returned empty user response');
    }

    final session = AuthSession(user: user, tokens: tokens);
    _session = session;
    _refreshToken = tokens.refreshToken;
    await _persistRefreshToken(tokens.refreshToken);
    return session;
  }

  @override
  Future<generated.UserResponse> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    final request = generated.SignupRequest(
      (b) => b
        ..username = username
        ..email = email
        ..password = password,
    );
    final response =
        await _authApi.signupAuthSignupPost(signupRequest: request);
    final user = response.data;
    if (user == null) {
      throw StateError('Signup returned empty user response');
    }
    return user;
  }

  Future<generated.TokenResponse> refreshToken([String? token]) async {
    final refreshToken = token ?? _refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      throw StateError('No refresh token available');
    }
    final request = generated.RefreshRequest(
      (b) => b..refreshToken = refreshToken,
    );
    final response =
        await _authApi.refreshAuthRefreshPost(refreshRequest: request);
    final refreshed = response.data;
    if (refreshed == null) {
      throw StateError('Refresh returned empty token response');
    }
    _openapi.setOAuthToken('OAuth2PasswordBearer', refreshed.accessToken);
    _refreshToken = refreshed.refreshToken;
    if (_session != null) {
      _session = AuthSession(user: _session!.user, tokens: refreshed);
    }
    await _persistRefreshToken(refreshed.refreshToken);
    return refreshed;
  }

  Future<generated.UserResponse> verifyCurrentToken() async {
    final response = await _authApi.verifyAuthVerifyGet();
    final user = response.data;
    if (user == null) {
      throw StateError('Verify returned empty user response');
    }
    return user;
  }

  @override
  Future<String> requestPasswordReset({required String email}) async {
    final request = generated.PasswordResetRequest((b) => b..email = email);
    final response =
        await _authApi.resetPasswordRequestAuthResetPasswordRequestPost(
      passwordResetRequest: request,
    );
    final message = response.data?.message;
    if (message == null) {
      throw StateError('Reset request returned empty message');
    }
    return message;
  }

  Future<String> confirmPasswordReset({
    required String token,
    required String newPassword,
  }) async {
    final request = generated.PasswordResetConfirm(
      (b) => b
        ..token = token
        ..newPassword = newPassword,
    );
    final response =
        await _authApi.resetPasswordConfirmAuthResetPasswordConfirmPost(
      passwordResetConfirm: request,
    );
    final message = response.data?.message;
    if (message == null) {
      throw StateError('Reset confirm returned empty message');
    }
    return message;
  }

  @override
  Future<void> logout() async {
    await _persistRefreshToken(null);
    _session = null;
    _refreshToken = null;
    _openapi.setOAuthToken('OAuth2PasswordBearer', '');
  }
}
