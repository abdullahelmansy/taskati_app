import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/function/navigation.dart';
import '../../../core/model/task_model.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../add_task/add_task_view.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
  });

  final TaskModel? model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (model?.isCompleted != true) {
          push(
              context,
              AddTaskView(
                model: model,
              ));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
        decoration: BoxDecoration(
          color: (model?.color == 0)
              ? AppColors.primaryColor
              : (model?.color == 1)
                  ? AppColors.orangeColor
                  : (model?.color == 1)
                      ? AppColors.redColor
                      : Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model?.title ?? '',
                    style:
                        getTitleTextStyle(context, color: AppColors.whiteColor),
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      const Icon(
                        Icons.alarm,
                        color: AppColors.whiteColor,
                      ),
                      const Gap(5),
                      Text(
                        '${model?.startTime} - ${model?.endTime}',
                        style: getSmallTextStyle(
                          context,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                  Text(
                    model?.note ?? '',
                    style: getBodyTextStyle(
                      context,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 0.5,
              height: 50,
              color: AppColors.whiteColor,
            ),
            const Gap(10),
            RotatedBox(
                quarterTurns: 3,
                child: Text(
                  model!.isCompleted ? 'Completed' : 'TODO',
                  style: getTitleTextStyle(context,
                      color: AppColors.whiteColor, fontSize: 12),
                )),
          ],
        ),
      ),
    );
  }
}
