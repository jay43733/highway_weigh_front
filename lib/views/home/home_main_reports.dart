import 'package:flutter/material.dart';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/controllers/inspector_reports_controller.dart';
import 'package:highway_weight/controllers/main_reports_controller.dart';
import 'package:highway_weight/models/general_reports_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_text_button.dart';
import 'package:highway_weight/widgets/error_snack_bar.dart';
import 'package:highway_weight/widgets/form_modal.dart';
import 'package:highway_weight/widgets/pagination.dart';
import 'package:intl/intl.dart';

class HomeMainReports extends StatelessWidget {
  final AuthController authController;
  final MainReportsController mainReportsController;
  final InspectorReportsController inspectorReportsController;
  const HomeMainReports({
    super.key,
    required this.mainReportsController,
    required this.authController,
    required this.inspectorReportsController,
  });

  @override
  Widget build(BuildContext context) {
    if (mainReportsController.mainReportLists.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("รายการอนุมัติออกตรวจ", style: TextStyles.h4Semi),
            SizedBox(height: 24.0),
            Center(
              child: Text(
                "ไม่มีรายการอนุมัติออกตรวจ",
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
              children: [
                Text("รายการอนุมัติออกตรวจ", style: TextStyles.h4Semi),
              ],
            ),
            SizedBox(height: 24.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 00.0),
              child: DataTable(
                columnSpacing: 48.0,
                sortAscending: true,
                columns:
                    mainReportHeaders.asMap().entries.map((entries) {
                      return DataColumn(label: Text(entries.value));
                    }).toList(),
                rows:
                    mainReportsController.getPaginatedMainLists().asMap().entries.map((
                      entries,
                    ) {
                      final continuousIndex =
                          (mainReportsController.currentPage *
                              mainReportsController.itemsPerPage) +
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
                                message: entries.value.generalListReport.name,
                                child: Text(
                                  entries.value.generalListReport.name,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 140.0,
                              child: Text(
                                IssueCategory.getTitle(
                                  entries.value.generalListReport.category,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 200.0,
                              child: Text(
                                entries.value.generalListReport.station.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              DateFormat(
                                "yyyy-MM-dd HH:mm",
                                "th_TH",
                              ).format(entries.value.createdAt),
                            ),
                          ),
                          DataCell(
                            Container(
                              decoration: BoxDecoration(
                                color: StatusType.getColor(
                                  entries.value.status,
                                ),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 4.0,
                              ),
                              child: Text(
                                StatusType.getTitle(entries.value.status),
                                style: TextStyles.labelSemi,
                              ),
                            ),
                          ),

                          DataCell(
                            authController.role == '1' &&
                                    entries.value.status == 1
                                ? CustomTextButton(
                                  icon: Icons.mark_email_unread_outlined,
                                  text: "Review",
                                  onPressed: () {
                                    FormModal.showModal(
                                      formName: "main",
                                      reportedDate:
                                          entries
                                              .value
                                              .generalListReport
                                              .reportedDate,
                                      status: entries.value.status,
                                      role: authController.role,
                                      context,
                                      title: "Approve & Comment",
                                      commentValidator:
                                          (value) => mainReportsController
                                              .validateField("comment", value),
                                      generalName:
                                          entries.value.generalListReport.name,
                                      description:
                                          entries
                                              .value
                                              .generalListReport
                                              .description,
                                      category: IssueCategory.getTitle(
                                        entries
                                            .value
                                            .generalListReport
                                            .category,
                                      ),

                                      station:
                                          entries
                                              .value
                                              .generalListReport
                                              .station
                                              .name,
                                      imageUrl:
                                          entries
                                              .value
                                              .generalListReport
                                              .imageUrl,
                                      visitDate:
                                          entries
                                              .value
                                              .generalListReport
                                              .visitDate,
                                      primaryButtonText: "APPROVE",
                                      primaryButtonOnPressed: (
                                        String comment,
                                        String? visitDate,
                                      ) async {
                                        final int reportId = entries.value.id;
                                        try {
                                          await Future.delayed(
                                            const Duration(milliseconds: 100),
                                          );
                                          await mainReportsController
                                              .approveMainReports(
                                                reportId,
                                                comment,
                                              );

                                          await Future.delayed(
                                            const Duration(milliseconds: 500),
                                          );

                                          await inspectorReportsController
                                              .createInspectorReport(reportId);
                                          if (context.mounted) {
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop();
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop();
                                          }

                                          ErrorSnackBar(title: e.toString());
                                        }
                                      },
                                      secondaryButtonText: "REJECT",
                                      secondaryButtonOnPressed: (
                                        String comment,
                                      ) async {
                                        final int reportId = entries.value.id;

                                        await Future.delayed(
                                          const Duration(milliseconds: 100),
                                        );
                                        await mainReportsController
                                            .rejectMainReports(
                                              reportId,
                                              comment,
                                            );
                                        if (context.mounted) {
                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).pop();
                                        }
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
                                      reportedDate:
                                          entries
                                              .value
                                              .generalListReport
                                              .reportedDate,
                                      status: entries.value.status,
                                      role: authController.role,
                                      context,
                                      caption:
                                          "อนุมัติเมื่อ ${DateFormat("yyyy-MM-dd HH:mm", "th_TH").format(entries.value.createdAt)}",
                                      title:
                                          "สร้างโดย ${entries.value.generalListReport.whoCreated?.name}",
                                      generalName:
                                          entries.value.generalListReport.name,
                                      description:
                                          entries
                                              .value
                                              .generalListReport
                                              .description,
                                      category: IssueCategory.getTitle(
                                        entries
                                            .value
                                            .generalListReport
                                            .category,
                                      ),
                                      station:
                                          entries
                                              .value
                                              .generalListReport
                                              .station
                                              .name,
                                      imageUrl:
                                          entries
                                              .value
                                              .generalListReport
                                              .imageUrl,
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
              onPageChanged: mainReportsController.onPageChanged,
              itemPerPage: mainReportsController.itemsPerPage,
              totalPages: mainReportsController.mainReportLists.length,
              currentPage: mainReportsController.currentPage,
            ),
          ],
        ),
      ),
    );
  }
}
