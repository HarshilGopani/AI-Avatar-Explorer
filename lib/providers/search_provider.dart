import 'package:ai_avatar_explorer_app/api_response/api_resonse.dart';
import 'package:ai_avatar_explorer_app/model/ai_avatar_user_model.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  final HomeResponse homeResponse = HomeResponse();

  TextEditingController searchController = TextEditingController();

  String? selectedGender;
  String? selectedAge;

  final List<String> genderList = ["Male", "Female"];
  final List<String> ageList = ["18-30", "31-45", "65+"];

  List<Result> aiavatarUserList = [];
  List<Result> aiFilterUsersList = [];

  List<Result> get filteredUsers => aiFilterUsersList;

  void genderValue(String gender) {
    selectedGender = gender;
    applyAllFilters();
  }

  void ageValue(String value) {
    selectedAge = value;
    notifyListeners();
    applyAllFilters();
  }

  Future<void> postUserList(BuildContext context) async {
    var response = await homeResponse.postUserList(isLoading: true);
    aiavatarUserList.clear();
    if (response != null) {
      aiavatarUserList = response.results ?? [];
      applyAllFilters();
    }
  }

  void searchUsers(String query) {
    searchController.text = query.trim().toLowerCase();
    applyAllFilters();
  }

  void applyAllFilters() {
    aiFilterUsersList =
        aiavatarUserList.where((user) {
          //TODO:- Search
          final name =
              "${user.name?.first ?? ""} ${user.name?.last ?? ""}"
                  .toLowerCase();
          final email = user.email?.toLowerCase() ?? "";
          final matchesSearch =
              searchController.text.isEmpty ||
              name.contains(searchController.text) ||
              email.contains(searchController.text);

          //TODO:- Gender
          final matchesGender =
              selectedGender == null ||
              selectedGender!.isEmpty ||
              user.gender == selectedGender?.toLowerCase();

          //TODO:- Filter
          final age = user.dob?.age ?? 0;
          bool sameAge = true;
          if (selectedAge == "18-30") {
            sameAge = age >= 18 && age <= 30;
          } else if (selectedAge == "31-45") {
            sameAge = age >= 31 && age <= 45;
          } else if (selectedAge == "65+") {
            sameAge = age >= 65;
          }

          // All Filters
          return matchesSearch && matchesGender && sameAge;
        }).toList();
    notifyListeners();
  }

  void clearFilters() {
    selectedGender = null;
    selectedAge = null;
    searchController.clear();
    applyAllFilters();
  }
}
