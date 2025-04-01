import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/controllers/stations_controller.dart';
import 'package:highway_weight/models/general_lists_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_drop_down_text_form_field.dart';
import 'package:highway_weight/widgets/custom_text_form_field.dart';
import 'package:highway_weight/widgets/primary_button.dart';
import 'package:highway_weight/widgets/secondary_button.dart';

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
                    ),
                    SizedBox(height: 20.0),
                    CustomDropDownTextFormField(
                      onChanged: (value) {
                        generalListsController.updateField('category', value);
                      },
                      hintText: "ประเภทการร้องเรียน",
                      dropdownItems: categoryOptions,
                      itemLabelBuilder: IssueCategory.getTitle,
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
                      onChanged: (value) {
                        generalListsController.updateField('station', value);
                      },
                      hintText: "สถานี",
                      dropdownItems: stationOptions,
                      itemLabelBuilder: stationsController.getStationName,
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
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
