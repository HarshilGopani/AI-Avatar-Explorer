import 'package:ai_avatar_explorer_app/model/ai_avatar_user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../utilts/utils.dart';
import '../widgets/widgets.dart';

class ProfileDetailsScreen extends StatefulWidget {
  ProfileDetailsScreen({super.key, required this.resultData});

  Result? resultData;

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsValue.whiteColor,
      appBar: CustomAppBar(
        onTapBack: () {
          Navigator.pop(context);
        },
        isBackVisible: true,
        title: '',
      ),
      body: ListView(
        padding: Dimens.edgeInsets20,
        children: [
          Center(
            child: Container(
              height: Dimens.hundred,
              width: Dimens.hundred,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.fiveHundred),
                child: CachedNetworkImage(
                  height: Dimens.hundred,
                  width: Dimens.hundred,
                  fit: BoxFit.cover,
                  imageUrl: widget.resultData?.picture?.medium ?? "",
                  placeholder: (context, url) {
                    return Image.asset(AssetConstants.usera, fit: BoxFit.cover);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AssetConstants.usera, fit: BoxFit.cover);
                  },
                ),
              ),
            ),
          ),
          Dimens.boxHeight20,
          Center(
            child: Text(
              "${widget.resultData?.name?.first} ${widget.resultData?.name?.last}",
              style: Styles.txtBlackColorW70024,
            ),
          ),
          Dimens.boxHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.resultData?.dob?.age.toString() ?? "",
                style: Styles.txtColorGreyW50020,
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
                widget.resultData?.gender ?? "",
                style: Styles.txtColorGreyW50020,
              ),
            ],
          ),
          Dimens.boxHeight20,
          Divider(height: Dimens.one, color: ColorsValue.textfildBorder),
          Dimens.boxHeight15,
          Text("Location", style: Styles.txtBlackColorW50020),
          Dimens.boxHeight5,
          Text(
            widget.resultData?.location?.country ?? "",
            style: Styles.txtColorGreyW50018,
          ),
          Dimens.boxHeight10,
          Divider(height: Dimens.one, color: ColorsValue.textfildBorder),
          Dimens.boxHeight15,
          Text("Email", style: Styles.txtBlackColorW50020),
          Dimens.boxHeight5,
          Text(
            widget.resultData?.email ?? "",
            style: Styles.txtColorGreyW50018,
          ),
          Dimens.boxHeight10,
          Divider(height: Dimens.one, color: ColorsValue.textfildBorder),
          Dimens.boxHeight15,
          Text("Phone", style: Styles.txtBlackColorW50020),
          Dimens.boxHeight5,
          Text(
            widget.resultData?.phone ?? "",
            style: Styles.txtColorGreyW50018,
          ),
          Dimens.boxHeight10,
          Divider(height: Dimens.one, color: ColorsValue.textfildBorder),
          Dimens.boxHeight15,
          Text("Registered", style: Styles.txtBlackColorW50020),
          Dimens.boxHeight5,
          Text(
            Utility.dateStringddMMyyyy(
              widget.resultData?.registered?.date ?? "",
            ),
            style: Styles.txtColorGreyW50018,
          ),
        ],
      ),
    );
  }
}
