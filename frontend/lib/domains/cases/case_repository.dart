import 'package:frontend/network/openapi.dart' as generated;

/// Wraps generated [generated.CasesApi]. Regenerate client from [openapi/openapi.json]
/// using [openapi/openapi.bash] (output: `lib/network`).
abstract class CaseRepositoryContract {
  Future<List<generated.CaseResponse>> listCases({String? status});

  Future<generated.CaseResponse> createCase(
    generated.CreateCaseRequest request,
  );

  Future<generated.CaseResponse> updateCase({
    required String id,
    required generated.UpdateCaseRequest updateCaseRequest,
  });

  Future<void> deleteCase({required String id});
}

class CaseRepository implements CaseRepositoryContract {
  CaseRepository({required generated.Openapi openapi})
      : _api = openapi.getCasesApi();

  final generated.CasesApi _api;

  @override
  Future<List<generated.CaseResponse>> listCases({String? status}) async {
    final response = await _api.listCasesCasesGet(status: status);
    return response.data?.toList() ?? [];
  }

  @override
  Future<generated.CaseResponse> createCase(
    generated.CreateCaseRequest request,
  ) async {
    final response = await _api.createCaseCasesPost(
      createCaseRequest: request,
    );
    final data = response.data;
    if (data == null) {
      throw StateError('Create case returned empty body');
    }
    return data;
  }

  @override
  Future<generated.CaseResponse> updateCase({
    required String id,
    required generated.UpdateCaseRequest updateCaseRequest,
  }) async {
    final response = await _api.updateCaseCasesIdPut(
      id: id,
      updateCaseRequest: updateCaseRequest,
    );
    final data = response.data;
    if (data == null) {
      throw StateError('Update case returned empty body');
    }
    return data;
  }

  @override
  Future<void> deleteCase({required String id}) async {
    final response = await _api.deleteCaseCasesIdDelete(id: id);
    final code = response.statusCode ?? 0;
    if (code != 204 && code != 200) {
      throw StateError('Delete case failed with status $code');
    }
  }
}
