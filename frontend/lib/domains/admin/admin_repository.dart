import 'package:frontend/network/openapi.dart' as generated;

abstract class AdminRepositoryContract {
  Future<generated.SessionListResponse> listSessions({
    int page = 1,
    int pageSize = 20,
    String? student,
    String? caseId,
    DateTime? onDate,
  });

  Future<generated.SessionDetailResponse> getSessionDetail({
    required String sessionId,
  });
}

class AdminRepository implements AdminRepositoryContract {
  AdminRepository({required generated.Openapi openapi})
      : _api = openapi.getAdminApi();

  final generated.AdminApi _api;

  @override
  Future<generated.SessionListResponse> listSessions({
    int page = 1,
    int pageSize = 20,
    String? student,
    String? caseId,
    DateTime? onDate,
  }) async {
    final response = await _api.listSessionsAdminSessionsGet(
      page: page,
      pageSize: pageSize,
      student: student?.trim().isEmpty == true ? null : student?.trim(),
      caseId: caseId?.trim().isEmpty == true ? null : caseId?.trim(),
      onDate: onDate == null
          ? null
          : generated.Date(onDate.year, onDate.month, onDate.day),
    );
    return response.data!;
  }

  @override
  Future<generated.SessionDetailResponse> getSessionDetail({
    required String sessionId,
  }) async {
    final response = await _api.getSessionDetailAdminSessionsSessionIdGet(
      sessionId: sessionId,
    );
    return response.data!;
  }
}
