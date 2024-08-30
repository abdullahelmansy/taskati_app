import 'dart:io';

import 'package:flutter/material.dart';
import '../../../core/function/navigation.dart';
import '../../../core/services/local_storage.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../profile/profile_view.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello ,${AppLocalStorage.getCachedData(AppLocalStorage.kUserName)}',
              style: getTitleTextStyle(
                context,
                color: AppColors.primaryColor,
              ),
            ),
            Text(
              'Have a Nice Day',
              style: getBodyTextStyle(
                context,
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            pushReplacement(context, const ProfileView());
          },
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 28,
            child: CircleAvatar(
              radius: 25,
              backgroundImage:
                  AppLocalStorage.getCachedData(AppLocalStorage.kUserImage) !=
                          null
                      ? FileImage(
                          File(AppLocalStorage.getCachedData(
                              AppLocalStorage.kUserImage)),
                        )
                      : const AssetImage('assets/images/user.png'),
            ),
          ),
        )
      ],
    );
  }
}
