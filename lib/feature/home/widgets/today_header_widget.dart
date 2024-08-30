import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/function/navigation.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/widgets/custom_button.dart';
import '../../add_task/add_task_view.dart';

class TodayHeaderWidget extends StatelessWidget {
  const TodayHeaderWidget({
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
              DateFormat.yMMMEd().format(DateTime.now()),
              style: getTitleTextStyle(
                context,
              ),
            ),
            Text(
              'Today',
              style: getTitleTextStyle(
                context,
              ),
            ),
          ],
        ),
        const Spacer(),
        CustomButton(
          text: 'Add Task',
          onTap: () {
            push(context, const AddTaskView());
          },
          width: 130,
          height: 45,
        )
      ],
    );
  }
}
