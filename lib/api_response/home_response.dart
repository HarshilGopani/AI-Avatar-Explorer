import 'package:ai_avatar_explorer_app/model/ai_avatar_user_model.dart';

import '../repository/home_repository.dart';

class HomeResponse {
  HomeRepository homeRepository = HomeRepository();

  Future<AiAvatarUserModel?> postUserList({bool isLoading = false}) async {
    try {
      var response = await homeRepository.postUserList(isLoading: isLoading);
      var aiAvatarUserModel = aiAvatarUserModelFromJson(response.data);
      if (aiAvatarUserModel != null) {
        return aiAvatarUserModel;
      } else {
        return aiAvatarUserModel;
      }
    } catch (_) {
      UnimplementedError();
      return null;
    }
  }
}
