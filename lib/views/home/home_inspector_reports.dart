import 'package:flutter/material.dart';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/controllers/general_reports_controller.dart';
import 'package:highway_weight/controllers/inspector_reports_controller.dart';
import 'package:highway_weight/models/general_reports_model.dart';
import 'package:highway_weight/models/inspector_reports_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_text_button.dart';
import 'package:highway_weight/widgets/error_snack_bar.dart';
import 'package:highway_weight/widgets/form_modal.dart';
import 'package:highway_weight/widgets/pagination.dart';
import 'package:intl/intl.dart';

class HomeInspectorReports extends StatelessWidget {
  final AuthController authController;
  final InspectorReportsController inspectorReportsController;
  final GeneralReportsController generalReportsController;
  const HomeInspectorReports({
    super.key,
    required this.inspectorReportsController,
    required this.authController,
    required this.generalReportsController,
  });

  @override
  Widget build(BuildContext context) {
    if (inspectorReportsController.inspectorReportsLists.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("รายการรอสุ่มตรวจ", style: TextStyles.h4Semi),
            SizedBox(height: 24.0),
            Center(
              child: Text(
                "ไม่มีรายการรอสุ่มตรวจ",
                style: TextStyles.labelReg.copyWith(color: AppColors.redColor),
              ),
            ),
          ],
        ),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1340.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text("รายการรอสุ่มตรวจ", style: TextStyles.h4Semi)],
            ),
            SizedBox(height: 24.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 00.0),
              child: DataTable(
                columnSpacing: 48.0,
                sortAscending: true,
                columns:
                    inspectorReportHeaders.asMap().entries.map((entries) {
                      return DataColumn(label: Text(entries.value));
                    }).toList(),
                rows:
                    inspectorReportsController.getPaginatedMainLists().asMap().entries.map((
                      entries,
                    ) {
                      final continuousIndex =
                          (inspectorReportsController.currentPage *
                              inspectorReportsController.itemsPerPage) +
                          entries.key +
                          1;
                      return DataRow(
                        color: WidgetStatePropertyAll(
                          entries.key.isEven
                              ? AppColors.tableEvenRowColor
                              : AppColors.tableOddRowColor,
                        ),
                        cells: [
                          DataCell(Text((continuousIndex).toString())),
                          DataCell(
                            SizedBox(
                              width: 200.0,
                              child: Tooltip(
                                message:
                                    entries
                                        .value
                                        .mainReportsModel
                                        .generalListReport
                                        .name,
                                child: Text(
                                  entries
                                      .value
                                      .mainReportsModel
                                      .generalListReport
                                      .name,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 140.0,
                              child: Text(
                                IssueCategory.getTitle(
                                  entries
                                      .value
                                      .mainReportsModel
                                      .generalListReport
                                      .category,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 200.0,
                              child: Text(
                                entries
                                    .value
                                    .mainReportsModel
                                    .generalListReport
                                    .station
                                    .name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 120.0,
                              child: Text(
                                entries
                                        .value
                                        .mainReportsModel
                                        .generalListReport
                                        .visitDate ??
                                    "ยังไม่มีวันตรวจ",
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              decoration: BoxDecoration(
                                color: InspectorReportStatusType.getColor(
                                  entries.value.status,
                                ),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 4.0,
                              ),
                              child: Text(
                                InspectorReportStatusType.getTitle(entries.value.status),
                                style: TextStyles.labelSemi,
                              ),
                            ),
                          ),
                          DataCell(
                            authController.role == '4' &&
                                    entries.value.status == 1
                                ? CustomTextButton(
                                  icon: Icons.mark_email_unread_outlined,
                                  text: "Review",
                                  onPressed: () {
                                    FormModal.showModal(
                                      formName: "inspector",
                                      reportedDate:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .reportedDate,
                                      status: entries.value.status,
                                      role: authController.role,
                                      context,
                                      title: "โปรดตรวจสอบวันที่ออกตรวจและสถานี",
                                      caption:
                                          "หากยังไม่มีวันที่ออกตรวจ ผู้ตรวจต้องใส่วันที่ต้องการออกตรวจก่อน",
                                      generalName:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .name,
                                      description:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .description,
                                      category: IssueCategory.getTitle(
                                        entries
                                            .value
                                            .mainReportsModel
                                            .generalListReport
                                            .category,
                                      ),

                                      station:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .station
                                              .name,
                                      imageUrl:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .imageUrl,
                                      visitDate:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .visitDate,
                                      visitDateValidator:
                                          (value) => generalReportsController
                                              .validateField(
                                                "visitDate",
                                                value,
                                              ),
                                      commentValidator:
                                          (value) => generalReportsController
                                              .validateField("comment", value),

                                      primaryButtonText: "BOOK",
                                      primaryButtonOnPressed: (
                                        String comment,
                                        String? visitDate,
                                      ) async {
                                        try {
                                          if (comment != '' &&
                                              visitDate != null) {
                                            await inspectorReportsController
                                                .bookInspectorReport(
                                                  entries.value.id,
                                                  2,
                                                  visitDate,
                                                  comment,
                                                );
                                          }

                                          await Future.delayed(
                                            const Duration(milliseconds: 500),
                                          );

                                          if (context.mounted) {
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop();
                                          }
                                        } catch (e) {
                                          print('Error occurred: $e');
                                          if (context.mounted) {
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop();
                                          }

                                          ErrorSnackBar(title: e.toString());
                                        }
                                      },
                                      secondaryButtonOnPressed: (
                                        String comment,
                                      ) async {
                                        if (context.mounted) {
                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).pop();
                                        }

                                        await Future.delayed(
                                          const Duration(milliseconds: 100),
                                        );
                                        //   await generalReportsController
                                        //       .rejectGeneralReport(
                                        //         entries.value.id,
                                        //         comment,
                                        //       );
                                        //   generalReportsController
                                        //       .resetAllField();
                                      },
                                    );
                                  },
                                )
                                : CustomTextButton(
                                  icon: Icons.library_books_outlined,
                                  text: "View",
                                  onPressed: () {
                                    FormModal.showModal(
                                      formName: "main",
                                      status: entries.value.status,
                                      reportedDate:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .reportedDate,
                                      role: authController.role,
                                      context,
                                      caption:
                                          "เมื่อ ${DateFormat("yyyy-MM-dd HH:mm", "th_TH").format(entries.value.createdAt)}",
                                      title:
                                          "สร้างโดย ${entries.value.mainReportsModel.generalListReport.whoCreated?.name}",
                                      generalName:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .name,
                                      description:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .description,
                                      category: IssueCategory.getTitle(
                                        entries
                                            .value
                                            .mainReportsModel
                                            .generalListReport
                                            .category,
                                      ),
                                      station:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .station
                                              .name,
                                      imageUrl:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .imageUrl,
                                      visitDate:
                                          entries
                                              .value
                                              .mainReportsModel
                                              .generalListReport
                                              .visitDate,
                                    );
                                  },
                                ),
                          ),
                        ],
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: 28.0),
            Pagination(
              onPageChanged: inspectorReportsController.onPageChanged,
              itemPerPage: inspectorReportsController.itemsPerPage,
              totalPages:
                  inspectorReportsController.inspectorReportsLists.length,
              currentPage: inspectorReportsController.currentPage,
            ),
          ],
        ),
      ),
    );
  }
}
