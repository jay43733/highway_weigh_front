import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/controllers/stations_controller.dart';
import 'package:highway_weight/models/general_reports_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_animated_container.dart';
import 'package:highway_weight/widgets/custom_dotted_container.dart';
import 'package:highway_weight/widgets/custom_drop_down_text_form_field.dart';
import 'package:highway_weight/widgets/custom_text_form_field.dart';
import 'package:highway_weight/widgets/error_snack_bar.dart';
import 'package:highway_weight/widgets/primary_button.dart';
import 'package:highway_weight/widgets/secondary_button.dart';
import 'package:highway_weight/widgets/success_snack_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateGeneralReportForm extends StatefulWidget {
  final GeneralReportsController generalReportsController;
  final StationsController stationsController;

  const UpdateGeneralReportForm({
    super.key,
    required this.generalReportsController,
    required this.stationsController,
  });

  @override
  State<UpdateGeneralReportForm> createState() =>
      _UpdateGeneralReportFormState();
}

class _UpdateGeneralReportFormState extends State<UpdateGeneralReportForm> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      widget.generalReportsController.loadImageFileName();
    });
  }

  @override
  Widget build(BuildContext context) {
     print('Report : ${widget.generalReportsController.reportedDate}');
    print('Update Report : ${widget.generalReportsController.updateReportedDate}');
    final _formKey = GlobalKey<FormState>();
    List<int> categoryOptions = [
      IssueCategory.overWeight,
      IssueCategory.improperStaff,
    ];

    List<int> stationOptions =
        widget.stationsController.stations
            .asMap()
            .entries
            .map((entries) => entries.value.id)
            .toList();

    return Column(
      children: [
        Text(
          "แก้ไขข้อร้องเรียน",
          style: TextStyles.h3Semi.copyWith(color: AppColors.whitePrimary),
        ),
        SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whitePrimary,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.all(40.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUnfocus,
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("รายละเอียดการร้องเรียน", style: TextStyles.h4Semi),
                      SizedBox(height: 20.0),

                      Consumer<GeneralReportsController>(
                        builder: (context, value, _) {
                          return CustomTextFormField(
                            controller: value.reportedDateController,
                            labelText: "วันที่ร้องเรียน",
                            readOnly: true,
                            useCursorClick: true,
                            suffixIcon: Icons.calendar_month_outlined,
                            validator:
                                (value) => widget.generalReportsController
                                    .validateField("updateReportedDate", value),
                            onTap: () async {
                              final DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.tryParse(
                                  widget.generalReportsController.reportedDate,
                                ),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                currentDate: DateTime.now(),
                              );
                              if (dateTime != null) {
                                final String dateTimeString = DateFormat(
                                  'yyyy-MM-dd',
                                ).format(dateTime);
                                widget.generalReportsController.updateField(
                                  "reportedDate",
                                  dateTimeString,
                                );
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20.0),
                      CustomTextFormField(
                        initialValue:
                            widget.generalReportsController.generalName,
                        labelText: "ชื่อหัวข้อ",
                        onChanged: (value) {
                          widget.generalReportsController.updateField(
                            "generalName",
                            value,
                          );
                        },
                        validator:
                            (value) => widget.generalReportsController
                                .validateField('generalName', value),
                      ),
                      SizedBox(height: 20.0),
                      CustomDropDownTextFormField(
                        value: widget.generalReportsController.category,
                        onChanged: (value) {
                          widget.generalReportsController.updateField(
                            'category',
                            value,
                          );
                        },
                        hintText: "ประเภทการร้องเรียน",
                        dropdownItems: categoryOptions,
                        itemLabelBuilder: IssueCategory.getTitle,
                        validator:
                            (value) => widget.generalReportsController
                                .validateField("category", value),
                      ),
                      SizedBox(height: 20.0),
                      CustomTextFormField(
                        initialValue:
                            widget.generalReportsController.description,
                        labelText: "หมายเหตุ",
                        hintText: "อธิบายรายละเอียดเพิ่มเติม...",
                        onChanged: (value) {
                          widget.generalReportsController.updateField(
                            "description",
                            value,
                          );
                        },
                        maxLines: 4,
                        validator:
                            (value) => widget.generalReportsController
                                .validateField("description", value),
                      ),
                    ],
                  ),

                  SizedBox(height: 40.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("สถานีที่ร้องเรียน", style: TextStyles.h4Semi),
                      SizedBox(height: 20.0),
                      CustomDropDownTextFormField(
                        value: widget.generalReportsController.station,
                        onChanged: (value) {
                          widget.generalReportsController.updateField(
                            'station',
                            value,
                          );
                        },
                        hintText: "สถานี",
                        dropdownItems: stationOptions,
                        itemLabelBuilder:
                            widget.stationsController.getStationName,
                        validator:
                            (value) => widget.generalReportsController
                                .validateField("station", value),
                      ),
                      SizedBox(height: 40.0),
                      Text("แนบหลักฐานประกอบ", style: TextStyles.h4Semi),
                      SizedBox(height: 20.0),
                      Consumer<GeneralReportsController>(
                        builder: (context, value, _) {
                          return widget
                                      .generalReportsController
                                      .imageFileName ==
                                  null
                              ? Column(
                                children: [
                                  CustomDottedContainer(
                                    imagePath: 'assets/icons/upload.png',
                                    onPressed: () {
                                      widget.generalReportsController
                                          .getImageGallery();
                                    },
                                    buttonName: 'Upload Image',
                                  ),
                                  if (widget
                                          .generalReportsController
                                          .errorMessage['image'] !=
                                      null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        widget
                                            .generalReportsController
                                            .errorMessage['image']
                                            .toString(),
                                        style: TextStyles.labelReg.copyWith(
                                          color: AppColors.redColor,
                                        ),
                                      ),
                                    ),
                                ],
                              )
                              : CustomAnimatedContainer(
                                imagePath:
                                    widget.generalReportsController.image,
                                imageUrl:
                                    widget
                                        .generalReportsController
                                        .imageFileName,
                                onPressed:
                                    widget.generalReportsController.clearImage,
                              );
                        },
                      ),

                      SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SecondaryButton(
                            text: "กลับหน้าแรก",
                            onPressed: () {
                              if (_formKey.currentState != null) {
                                _formKey.currentState!.reset();
                                widget.generalReportsController.resetAllField();
                                widget.generalReportsController.clearImage();
                              }
                              context.pop();
                            },
                          ),
                          SizedBox(width: 32.0),
                          PrimaryButton(
                            text: "แก้ไขข้อร้องเรียน",
                            onPressed: () async {
                              widget.generalReportsController.validateImage();
                              if (_formKey.currentState!.validate() &&
                                  !widget.generalReportsController.errorMessage
                                      .containsKey('image')) {
                                await widget.generalReportsController
                                    .updateGeneralReport(
                                      widget.generalReportsController.reportId!,
                                    );
                                SuccessSnackBar.show(
                                  context,
                                  title: "Updated successfully",
                                  subtitle: widget.stationsController
                                      .getStationName(
                                        widget
                                            .generalReportsController
                                            .station!,
                                      ),
                                );

                                _formKey.currentState!.reset();
                                widget.generalReportsController.resetAllField();
                                widget.generalReportsController.clearImage();
                                context.pop();
                              } else {
                                ErrorSnackBar.show(context, title: "Error");
                                print(
                                  "Error : ${widget.generalReportsController.errorMessage['image']}",
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
