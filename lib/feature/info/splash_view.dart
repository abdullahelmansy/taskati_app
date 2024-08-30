import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../core/function/navigation.dart';
import '../../core/services/local_storage.dart';
import '../../core/utils/text_style.dart';
import '../home/home_view.dart';
import '../upload/upload_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      pushReplacement(
          context,
          (AppLocalStorage.getCachedData(AppLocalStorage.kIsUploaded) ?? false)
              ? const HomeView()
              : const UploadView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/logo.json'),
            Text(
              'Taskati',
              style: getTitleTextStyle(
                context,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(5),
            Text(
              'It\'s Time To Get Organized',
              style: getSmallTextStyle(context, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
