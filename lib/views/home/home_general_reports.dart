import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/models/general_lists_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/pagination.dart';
import 'package:highway_weight/widgets/popup_modal.dart';
import 'package:highway_weight/widgets/primary_button.dart';
import 'package:intl/intl.dart';

class HomeGeneralReports extends StatelessWidget {
  final GeneralReportsController generalReportsController;
  final AuthController authController;
  const HomeGeneralReports({
    super.key,
    required this.generalReportsController,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    List<GeneralReportsModel> activeGeneralLists =
        generalReportsController.generalReportLists
            .where((item) => item.isActive)
            .toList();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("General Reports", style: TextStyles.h3Semi),
              PrimaryButton(
                icon: Icons.add,
                text: "ADD REPORT",
                onPressed: () {
                  context.push('/general_reports');
                },
              ),
            ],
          ),
          SizedBox(height: 24.0),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 300.0),
            child: DataTable(
              sortAscending: true,
              columns:
                  generalReportHeaders.asMap().entries.map((entries) {
                    return DataColumn(label: Text(entries.value));
                  }).toList(),
              rows:
                  generalReportsController
                      .getPaginatedGeneralLists()
                      .asMap()
                      .entries
                      .map((entries) {
                        final continuousIndex =
                            (generalReportsController.currentPage *
                                generalReportsController.itemsPerPage) +
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
                                  message: entries.value.name,
                                  child: Text(entries.value.name),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 140.0,
                                child: Text(
                                  IssueCategory.getTitle(
                                    entries.value.category,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 200.0,
                                child: Text(
                                  entries.value.station.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                DateFormat(
                                  "yyyy-MM-dd HH:mm",
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
                              entries.value.isActive == false
                                  ? SizedBox.shrink()
                                  : authController.role == '2'
                                  ? Row(
                                    children: [
                                      PrimaryButton(
                                        text: "Approve",
                                        onPressed: () {},
                                      ),
                                      SizedBox(width: 8.0),
                                      PrimaryButton(
                                        text: "Reject",
                                        onPressed: () {},
                                      ),
                                    ],
                                  )
                                  : Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.mode_edit_outline_outlined,
                                        ),
                                        tooltip: 'Edit',
                                        color: AppColors.blackPrimary,
                                        onPressed: () {
                                          generalReportsController
                                              .updateAllField(entries.value);
                                          context.push(
                                            '/updated_general_reports',
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline),
                                        tooltip: 'Delete',
                                        color: AppColors.blackPrimary,
                                        onPressed: () {
                                          PopupModal.showModal(
                                            context,
                                            caption:
                                                "Do you want to delete this report of ",
                                            boldText:
                                                "${entries.value.station.name}?",
                                            primaryButtonText: "DELETE",
                                            primaryButtonOnPressed: () async {
                                              Navigator.of(
                                                context,
                                                rootNavigator: true,
                                              ).pop();
                                              await generalReportsController
                                                  .deactivateGeneralReport(
                                                    entries.value.id,
                                                  );
                                            },
                                            secondaryButtonText: "CANCEL",
                                            secondaryButtonOnPressed: () {
                                              Navigator.of(
                                                context,
                                                rootNavigator: true,
                                              ).pop();
                                            },
                                            icon: FontAwesomeIcons.trash,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                            ),
                          ],
                        );
                      })
                      .toList(),
            ),
          ),
          SizedBox(height: 28.0),
          Pagination(
            onPageChanged: generalReportsController.onPageChanged,
            itemPerPage: generalReportsController.itemsPerPage,
            totalPages: activeGeneralLists.length,
            currentPage: generalReportsController.currentPage,
          ),
        ],
      ),
    );
  }
}
