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
import 'package:highway_weight/widgets/loading.dart';
import 'package:highway_weight/widgets/primary_button.dart';
import 'package:highway_weight/widgets/secondary_button.dart';
import 'package:highway_weight/widgets/success_snack_bar.dart';
import 'package:provider/provider.dart';

class GeneralReportForm extends StatelessWidget {
  final GeneralReportsController generalReportsController;
  final StationsController stationsController;

  const GeneralReportForm({
    super.key,
    required this.generalReportsController,
    required this.stationsController,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    List<int> categoryOptions = [
      IssueCategory.overWeight,
      IssueCategory.improperStaff,
    ];

    List<int> stationOptions =
        stationsController.stations
            .asMap()
            .entries
            .map((entries) => entries.value.id)
            .toList();

    if (generalReportsController.isLoading) {
      return const Loading();
    }

    return Column(
      children: [
        Text(
          "Create General Report",
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
                      CustomTextFormField(
                        labelText: "ชื่อหัวข้อ",
                        onChanged: (value) {
                          generalReportsController.updateField(
                            "generalName",
                            value,
                          );
                        },
                        validator:
                            (value) => generalReportsController.validateField(
                              'generalName',
                              value,
                            ),
                      ),
                      SizedBox(height: 20.0),
                      CustomDropDownTextFormField(
                        value: generalReportsController.category,
                        onChanged: (value) {
                          generalReportsController.updateField(
                            'category',
                            value,
                          );
                        },
                        hintText: "ประเภทการร้องเรียน",
                        dropdownItems: categoryOptions,
                        itemLabelBuilder: IssueCategory.getTitle,
                        validator:
                            (value) => generalReportsController.validateField(
                              "category",
                              value,
                            ),
                      ),
                      SizedBox(height: 20.0),
                      CustomTextFormField(
                        labelText: "หมายเหตุ",
                        hintText: "อธิบายรายละเอียดเพิ่มเติม...",
                        onChanged: (value) {
                          generalReportsController.updateField(
                            "description",
                            value,
                          );
                        },
                        maxLines: 4,
                        validator:
                            (value) => generalReportsController.validateField(
                              "description",
                              value,
                            ),
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
                        value: generalReportsController.station,
                        onChanged: (value) {
                          generalReportsController.updateField(
                            'station',
                            value,
                          );
                        },
                        hintText: "สถานี",
                        dropdownItems: stationOptions,
                        itemLabelBuilder: stationsController.getStationName,
                        validator:
                            (value) => generalReportsController.validateField(
                              "station",
                              value,
                            ),
                      ),
                      SizedBox(height: 40.0),
                      Text("แนบหลักฐานประกอบ", style: TextStyles.h4Semi),
                      SizedBox(height: 20.0),
                      Consumer<GeneralReportsController>(
                        builder: (context, value, _) {
                          return generalReportsController.image == null
                              ? Column(
                                children: [
                                  CustomDottedContainer(
                                    imagePath: 'assets/icons/upload.png',
                                    onPressed: () {
                                      generalReportsController
                                          .getImageGallery();
                                    },
                                    buttonName: 'Upload Image',
                                  ),
                                  if (generalReportsController
                                          .errorMessage['image'] !=
                                      null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        generalReportsController
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
                                imagePath: generalReportsController.image,
                                onPressed: generalReportsController.clearImage,
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
                                generalReportsController.clearImage();
                              }
                              context.pop();
                            },
                          ),
                          SizedBox(width: 32.0),
                          PrimaryButton(
                            text: "สร้างข้อร้องเรียน",
                            onPressed: () async {
                              generalReportsController.validateImage();
                              if (_formKey.currentState!.validate() &&
                                  !generalReportsController.errorMessage
                                      .containsKey('image')) {
                                await generalReportsController
                                    .createGeneralReports();
                                SuccessSnackBar.show(
                                  title: "Created new report Successfully",
                                  subtitle:
                                      "at ${stationsController.getStationName(generalReportsController.station!)}",
                                  context,
                                );
                                _formKey.currentState!.reset();
                                generalReportsController.clearImage();
                                context.pop();
                              } else {
                                ErrorSnackBar.show(
                                  title:
                                      'Error: ${generalReportsController.errorMessage['image']}',
                                  context,
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
