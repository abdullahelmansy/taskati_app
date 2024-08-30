import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../core/function/navigation.dart';
import '../../core/model/task_model.dart';
import '../../core/services/local_storage.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/text_style.dart';
import '../../core/widgets/custom_button.dart';
import '../home/home_view.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key, this.model});

  final TaskModel? model;

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  late int colorIndex;
  late String date;
  late String startTime;
  late String endTime;
  var titleController = TextEditingController();
  var noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.model?.title ?? '';
    noteController.text = widget.model?.note ?? '';
    date = widget.model?.date ?? DateFormat.yMd().format(DateTime.now());
    startTime =
        widget.model?.startTime ?? DateFormat("hh:mm a").format(DateTime.now());
    endTime =
        widget.model?.endTime ?? DateFormat("hh:mm a").format(DateTime.now());
    colorIndex = widget.model?.color ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          widget.model == null ? 'Add Task' : 'Update Task',
          style: getTitleTextStyle(context,
              color: AppColors.whiteColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: getBodyTextStyle(
                context,
              ),
            ),
            const Gap(10),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Enter title Here,',
              ),
            ),
            const Gap(10),
            Text(
              'Note',
              style: getBodyTextStyle(
                context,
              ),
            ),
            const Gap(10),
            TextFormField(
              controller: noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Enter note Here,',
              ),
            ),
            const Gap(10),
            Text(
              'Date',
              style: getBodyTextStyle(
                context,
              ),
            ),
            const Gap(10),
            TextFormField(
              onTap: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      date = DateFormat.yMd().format(value);
                    });
                  }
                });
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText: date,
                hintStyle: getBodyTextStyle(
                  context,
                ),
                suffixIcon: const Icon(
                  Icons.date_range,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Start Time',
                    style: getBodyTextStyle(
                      context,
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    'End Time',
                    style: getBodyTextStyle(
                      context,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            startTime = value.format(context);
                          });
                        }
                      });
                    },
                    decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.watch_later_outlined,
                          color: AppColors.primaryColor,
                        ),
                        hintText: startTime,
                        hintStyle: getBodyTextStyle(
                          context,
                        )),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            endTime = value.format(context);
                          });
                        }
                      });
                    },
                    decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.watch_later_outlined,
                          color: AppColors.primaryColor,
                        ),
                        hintText: endTime,
                        hintStyle: getBodyTextStyle(
                          context,
                        )),
                  ),
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              colorIndex = index;
                            });
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: (index == 0)
                                ? AppColors.primaryColor
                                : (index == 1)
                                    ? AppColors.orangeColor
                                    : AppColors.redColor,
                            child: (colorIndex == index)
                                ? const Icon(
                                    Icons.check,
                                    color: AppColors.whiteColor,
                                  )
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                CustomButton(
                  width: 150,
                  text: widget.model == null ? 'Create Task' : 'Update Task',
                  onTap: () {
                    String id = widget.model?.id ??
                        '$Title - ${DateTime.now().toString()}';
                    AppLocalStorage.cacheTask(
                      id,
                      TaskModel(
                          id: id,
                          title: titleController.text,
                          note: noteController.text,
                          date: date,
                          startTime: startTime,
                          endTime: endTime,
                          color: colorIndex,
                          isCompleted: false),
                    );
                    pushAndRemoveUntil(
                      context,
                      const HomeView(),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
