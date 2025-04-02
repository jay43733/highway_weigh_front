import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/controllers/stations_controller.dart';
import 'package:highway_weight/models/general_lists_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_animated_container.dart';
import 'package:highway_weight/widgets/custom_dotted_container.dart';
import 'package:highway_weight/widgets/custom_drop_down_text_form_field.dart';
import 'package:highway_weight/widgets/custom_text_form_field.dart';
import 'package:highway_weight/widgets/primary_button.dart';
import 'package:highway_weight/widgets/secondary_button.dart';
import 'package:provider/provider.dart';

class GeneralReportForm extends StatelessWidget {
  final GeneralListsController generalListsController;
  final StationsController stationsController;

  const GeneralReportForm({
    super.key,
    required this.generalListsController,
    required this.stationsController,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    List<int> categoryOptions = [
      IssueCategory.overWeight,
      IssueCategory.improperStaff,
    ];

    List<LatLng> stationOptions =
        stationsController.stationLists
            .asMap()
            .entries
            .map((entries) => entries.value.latLng)
            .toList();

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
                          generalListsController.updateField(
                            "generalName",
                            value,
                          );
                        },
                        validator:
                            (value) => generalListsController.validateField(
                              'generalName',
                              value,
                            ),
                      ),
                      SizedBox(height: 20.0),
                      CustomDropDownTextFormField(
                        value: generalListsController.category,
                        onChanged: (value) {
                          generalListsController.updateField('category', value);
                        },
                        hintText: "ประเภทการร้องเรียน",
                        dropdownItems: categoryOptions,
                        itemLabelBuilder: IssueCategory.getTitle,
                        validator:
                            (value) => generalListsController.validateField(
                              "category",
                              value,
                            ),
                      ),
                      SizedBox(height: 20.0),
                      CustomTextFormField(
                        labelText: "หมายเหตุ",
                        hintText: "อธิบายรายละเอียดเพิ่มเติม...",
                        onChanged: (value) {
                          generalListsController.updateField(
                            "description",
                            value,
                          );
                        },
                        maxLines: 4,
                        validator:
                            (value) => generalListsController.validateField(
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
                        value: generalListsController.station,
                        onChanged: (value) {
                          generalListsController.updateField('station', value);
                        },
                        hintText: "สถานี",
                        dropdownItems: stationOptions,
                        itemLabelBuilder: stationsController.getStationName,
                        validator:
                            (value) => generalListsController.validateField(
                              "station",
                              value,
                            ),
                      ),
                      SizedBox(height: 40.0),
                      Text("แนบหลักฐานประกอบ", style: TextStyles.h4Semi),
                      SizedBox(height: 20.0),
                      Consumer<GeneralListsController>(
                        builder: (context, value, _) {
                          return generalListsController.image == null
                              ? Column(
                                children: [
                                  CustomDottedContainer(
                                    imagePath: 'assets/icons/upload.png',
                                    onPressed: () {
                                      generalListsController.getImageGallery();
                                    },
                                    buttonName: 'Upload Image',
                                  ),
                                  if (generalListsController
                                          .errorMessage['image'] !=
                                      null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        generalListsController
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
                                imagePath: generalListsController.image,
                                onPressed: generalListsController.clearImage,
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
                              context.pop();
                            },
                          ),
                          SizedBox(width: 32.0),
                          PrimaryButton(
                            text: "สร้างข้อร้องเรียน",
                            onPressed: () {
                              generalListsController.validateImage();
                              if (_formKey.currentState!.validate() &&
                                  !generalListsController.errorMessage
                                      .containsKey('image')) {
                                print(
                                  "General name : ${generalListsController.generalName}",
                                );
                                print(
                                  "Category : ${generalListsController.category}",
                                );
                                print(
                                  "Description : ${generalListsController.description}",
                                );
                                print(
                                  "Stations : ${generalListsController.station}",
                                );
                                print("Yeahhhhhhhhhhhhhhhhhhh!!");
                                context.pop();
                              } else {
                                print(
                                  "Error : ${generalListsController.errorMessage['image']}",
                                );
                                print("Fxck off");
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
