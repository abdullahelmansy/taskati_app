import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'widgets/home_header_widget.dart';
import 'widgets/task_list_builder.dart';
import 'widgets/today_header_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              HomeHeaderWidget(),
              Gap(20),
              TodayHeaderWidget(),
              Gap(20),
              Expanded(
                child: TaskListBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
