import 'package:ai_avatar_explorer_app/pages/pages.dart';
import 'package:ai_avatar_explorer_app/providers/home_provider.dart';
import 'package:ai_avatar_explorer_app/theme/theme.dart';
import 'package:ai_avatar_explorer_app/utilts/asset_constants.dart';
import 'package:ai_avatar_explorer_app/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Delay to ensure context is ready before using Provider
    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).postUserList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: ColorsValue.whiteColor,
      appBar: CustomAppBar(
        onTapBack: () {},
        isBackVisible: false,
        title: 'AI Avatar Explorer',
        leadingWidth: Dimens.twenty,
      ),
      body: RefreshIndicator(
        onRefresh: () async => await homeProvider.postUserList(context),
        child:
            homeProvider.aiAvatarUserList.isNotEmpty
                ? ListView.separated(
                  itemCount: homeProvider.aiAvatarUserList.length,
                  itemBuilder: (context, index) {
                    var item = homeProvider.aiAvatarUserList[index];
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
                            item.gender.toString() ?? "",
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
                              borderRadius: BorderRadius.circular(
                                Dimens.hundred,
                              ),
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
                  separatorBuilder:
                      (_, __) => const Divider(
                        height: 1,
                        color: ColorsValue.textfildBorder,
                      ),
                )
                : Center(
                  child: Text(
                    "User data not found...!",
                    style: Styles.txtColorGreyW70018,
                  ),
                ),
      ),
    );
  }
}
