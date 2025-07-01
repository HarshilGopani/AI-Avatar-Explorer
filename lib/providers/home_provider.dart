import 'package:ai_avatar_explorer_app/api_response/api_resonse.dart';
import 'package:ai_avatar_explorer_app/model/ai_avatar_user_model.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  HomeResponse homeResponse = HomeResponse();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AiAvatarUserModel? aiAvatarUserModel = AiAvatarUserModel();

  List<Result> aiAvatarUserList = [];

  Future<void> postUserList(BuildContext context) async {
    var response = await homeResponse.postUserList(isLoading: true);
    aiAvatarUserList.clear();
    if (response != null) {
      aiAvatarUserList = response.results ?? [];
      notifyListeners();
    } else {
      // Utility.errorMessage(context, "Login not sucessfully...!");
    }
  }
}
