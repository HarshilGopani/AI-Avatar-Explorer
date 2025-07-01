import 'package:ai_avatar_explorer_app/pages/pages.dart';
import 'package:ai_avatar_explorer_app/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../theme/theme.dart';
import '../utilts/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SearchProvider>(context, listen: false).postUserList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return Scaffold(
      backgroundColor: ColorsValue.whiteColor,
      appBar: CustomAppBar(
        onTapBack: () {},
        isBackVisible: false,
        title: 'Search',
        leadingWidth: Dimens.twenty,
      ),
      body: ListView(
        padding: Dimens.edgeInsets20_10_20_10,
        children: [
          CustomTextFormField(
            controller: searchProvider.searchController,
            text: '',
            isShowText: false,
            hintText: 'Search',
            hintTextStyle: Styles.txtBlackColorW60016,
            fillColor: ColorsValue.colorEEEAEA,
            prefixIcon: Icon(Icons.search),
            onChanged: searchProvider.searchUsers,
          ),
          Dimens.boxHeight20,
          Row(
            spacing: Dimens.twenty,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gender", style: Styles.txtBlackColorW40014),
                    Dimens.boxHeight5,
                    Container(
                      padding: Dimens.edgeInsets20_00_20_00,
                      height: Dimens.fifty,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorsValue.colorEEEAEA,
                        borderRadius: BorderRadius.circular(Dimens.ten),
                      ),
                      child: DropdownButton<String>(
                        underline: Container(),
                        isDense: true,
                        isExpanded: true,
                        onChanged: (value) {
                          searchProvider.genderValue(value!);
                        },
                        hint: Text('Any', style: Styles.txtBlackColorW40014),
                        focusColor: Colors.white,
                        dropdownColor: ColorsValue.whiteColor,
                        value: searchProvider.selectedGender,
                        style: Styles.txtBlackColorW60014,
                        iconEnabledColor: Colors.black,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: Dimens.twenty,
                        ),
                        items:
                            searchProvider.genderList.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(
                                  option,
                                  style: Styles.txtBlackColorW60014,
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Age", style: Styles.txtBlackColorW40014),
                    Dimens.boxHeight5,
                    Container(
                      padding: Dimens.edgeInsets20_00_20_00,
                      height: Dimens.fifty,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorsValue.colorEEEAEA,
                        borderRadius: BorderRadius.circular(Dimens.ten),
                      ),
                      child: DropdownButton<String>(
                        underline: Container(),
                        isDense: true,
                        isExpanded: true,
                        onChanged: (value) {
                          searchProvider.ageValue(value!);
                        },
                        hint: Text('Any', style: Styles.txtBlackColorW40014),
                        focusColor: Colors.white,
                        dropdownColor: ColorsValue.whiteColor,
                        value: searchProvider.selectedAge,
                        style: Styles.txtBlackColorW60014,
                        iconEnabledColor: Colors.black,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: Dimens.twenty,
                        ),
                        items:
                            searchProvider.ageList.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(
                                  option,
                                  style: Styles.txtBlackColorW60014,
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  searchProvider.clearFilters();
                },
                child: Icon(Icons.close, color: ColorsValue.redColor),
              ),
            ],
          ),
          Dimens.boxHeight20,
          searchProvider.filteredUsers.isNotEmpty
              ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: searchProvider.filteredUsers.length,
                itemBuilder: (context, index) {
                  var item = searchProvider.filteredUsers[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  ProfileDetailsScreen(resultData: item),
                        ),
                      );
                    },
                    contentPadding: Dimens.edgeInsets0,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimens.hundred),
                      child: CachedNetworkImage(
                        height: Dimens.fifty,
                        width: Dimens.fifty,
                        imageUrl: item.picture?.medium ?? "",
                        placeholder: (context, url) {
                          return Image.asset(
                            AssetConstants.usera,
                            fit: BoxFit.cover,
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            AssetConstants.usera,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    title: Row(
                      spacing: Dimens.five,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "${item.name?.first} ${item.name?.last}",
                            style: Styles.txtBlackColorW70016,
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          item.gender ?? "",
                          style: Styles.txtBlackColorW70016,
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          item.dob?.age.toString() ?? "",
                          style: Styles.txtColorGreyW70016,
                        ),
                        Dimens.boxWidth5,
                        Container(
                          height: Dimens.three,
                          width: Dimens.three,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimens.hundred),
                            color: ColorsValue.txtColorGrey,
                          ),
                        ),
                        Dimens.boxWidth5,
                        Text(
                          item.location?.country ?? "",
                          style: Styles.txtColorGreyW70016,
                        ),
                      ],
                    ),
                  );
                },
              )
              : Expanded(
                child: Padding(
                  padding: Dimens.edgeInsetsTop150,
                  child: Center(
                    child: Text(
                      "User data not found...!",
                      style: Styles.txtColorGreyW70018,
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
