import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/models/general_lists_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/pagination.dart';
import 'package:highway_weight/widgets/popup_modal.dart';
import 'package:highway_weight/widgets/primary_button.dart';
import 'package:intl/intl.dart';

class HomeGeneralReports extends StatelessWidget {
  final GeneralListsController generalListsController;
  const HomeGeneralReports({super.key, required this.generalListsController});

  @override
  Widget build(BuildContext context) {
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
                text: "Add Report",
                onPressed: () {
                  context.push('/general_reports');
                },
              ),
            ],
          ),
          SizedBox(height: 24.0),
          DataTable(
            sortAscending: true,
            columns:
                generalReportHeaders.asMap().entries.map((entries) {
                  return DataColumn(label: Text(entries.value));
                }).toList(),
            rows:
                generalListsController
                    .getPaginatedGeneralLists()
                    .asMap()
                    .entries
                    .map((entries) {
                      final continuousIndex =
                          (generalListsController.currentPage *
                              generalListsController.itemsPerPage) +
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
                            Text(
                              IssueCategory.getTitle(entries.value.category),
                            ),
                          ),
                          DataCell(Text(entries.value.station.name)),
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
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.pen,
                                    color: AppColors.blackPrimary,
                                    size: 16.0,
                                  ),
                                ),
                                SizedBox(width: 4.0),
                                IconButton(
                                  onPressed: () {
                                    PopupModal.showModal(
                                      context,
                                      title: "Delete General Report",
                                      content: Image.asset(
                                        'assets/images/logo.png',
                                        width: 100,
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            PrimaryButton(
                                              text: "Yes",
                                              onPressed: () {},
                                            ),
                                            SizedBox(width: 10.0),
                                            PrimaryButton(
                                              text: "No",
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.trash,
                                    color: AppColors.blackPrimary,
                                    size: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    })
                    .toList(),
          ),
          SizedBox(height: 28.0),
          Pagination(
            onPageChanged: generalListsController.onPageChanged,
            itemPerPage: generalListsController.itemsPerPage,
            totalPages: generalListsController.generalReportLists.length,
            currentPage: generalListsController.currentPage,
          ),
        ],
      ),
    );
  }
}
