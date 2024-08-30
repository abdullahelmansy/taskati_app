import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../core/model/task_model.dart';
import '../../../core/services/local_storage.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import 'task_item_widget.dart';

class TaskListBuilder extends StatefulWidget {
  const TaskListBuilder({
    super.key,
  });

  @override
  State<TaskListBuilder> createState() => _TaskListBuilderState();
}

class _TaskListBuilderState extends State<TaskListBuilder> {
  String selectedDate = DateFormat.yMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          height: 90,
          width: 70,
          DateTime.now().subtract(const Duration(days: 2)),
          initialSelectedDate: DateTime.now(),
          selectionColor: AppColors.primaryColor,
          selectedTextColor: Colors.white,
          dayTextStyle: getBodyTextStyle(context,
              color: AppColors.primaryColor, fontSize: 12),
          monthTextStyle: getBodyTextStyle(context,
              color: AppColors.primaryColor, fontSize: 12),
          dateTextStyle: getBodyTextStyle(context,
              color: AppColors.primaryColor, fontSize: 24),
          onDateChange: (date) {
            // New date selected
            setState(() {
              selectedDate = DateFormat.yMd().format(date);
            });
          },
        ),
        const Gap(20),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: AppLocalStorage.taskBox.listenable(),
            builder: (BuildContext context, Box<dynamic> box, Widget? child) {
              List<TaskModel?> taskList = [];
              box.keys.forEach((key) {
                if (AppLocalStorage.getCachedTask(key)?.date == selectedDate) {
                  taskList.add(AppLocalStorage.getCachedTask(key));
                }
              });
              return (taskList.isEmpty)
                  ? Column(
                      children: [
                        Lottie.asset('assets/images/no.json'),
                        const Gap(10),
                        Text(
                          'No Task Add yet',
                          style: getBodyTextStyle(
                            context,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: taskList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              box.delete(taskList[index]?.id);
                            } else {
                              box.put(
                                  taskList[index]?.id,
                                  TaskModel(
                                      id: taskList[index]!.id,
                                      title: taskList[index]!.title,
                                      note: taskList[index]!.note,
                                      date: taskList[index]!.date,
                                      startTime: taskList[index]!.startTime,
                                      endTime: taskList[index]!.endTime,
                                      color: 3,
                                      isCompleted: true));
                            }
                          },
                          key: UniqueKey(),
                          secondaryBackground: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.redColor,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: AppColors.whiteColor,
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          background: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: AppColors.whiteColor,
                                ),
                                Text(
                                  'Complete Task',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          child: TaskItemWidget(
                            model: taskList[index],
                          ),
                        );
                      });
            },
          ),
        ),
      ],
    );
  }
}
