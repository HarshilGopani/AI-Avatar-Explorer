import 'package:ai_avatar_explorer_app/data/data.dart';
import 'package:ai_avatar_explorer_app/model/model.dart';
import 'package:ai_avatar_explorer_app/utilts/utils.dart';

class HomeRepository {
  final apiWrapper = ApiWrapper();

  Future<ResponseModel> postUserList({
    bool isLoading = false,
  }) async {
    var response = await apiWrapper.makeRequest(
      EndPoints.userListApi,
      Request.get,
      null,
      isLoading,
      Utility.commonHeader(isDefaultAuthorizationKeyAdd: false),
    );
    return response;
  }
}
