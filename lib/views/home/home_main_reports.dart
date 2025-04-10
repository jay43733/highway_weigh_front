import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:highway_weight/controllers/main_lists_controller.dart';
import 'package:highway_weight/models/general_lists_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/pagination.dart';
import 'package:intl/intl.dart';

class HomeMainReports extends StatelessWidget {
  final MainListsController mainListsController;
  const HomeMainReports({super.key, required this.mainListsController});

  @override
  Widget build(BuildContext context) {
    if (mainListsController.mainReportLists.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Main Reports", style: TextStyles.h3Semi),
            SizedBox(height: 24.0),
            Center(
              child: Text(
                "No main report",
                style: TextStyles.captionReg.copyWith(
                  color: AppColors.redColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Main Reports", style: TextStyles.h3Semi),
          SizedBox(height: 24.0),
          DataTable(
            sortAscending: true,
            columns:
                generalReportHeaders.asMap().entries.map((entries) {
                  return DataColumn(label: Text(entries.value));
                }).toList(),
            rows:
                mainListsController.getPaginatedMainLists().asMap().entries.map(
                  (entries) {
                    final continuousIndex =
                        (mainListsController.currentPage *
                            mainListsController.itemsPerPage) +
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
                              child: Text(entries.value.generalListReport.name),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            IssueCategory.getTitle(
                              entries.value.generalListReport.category,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(entries.value.generalListReport.station.name),
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
                              color: StatusType.getColor(entries.value.status),
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
                                onPressed: () {},
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
                  },
                ).toList(),
          ),
          SizedBox(height: 28.0),
          Pagination(
            onPageChanged: mainListsController.onPageChanged,
            itemPerPage: mainListsController.itemsPerPage,
            totalPages: mainListsController.mainReportLists.length,
            currentPage: mainListsController.currentPage,
          ),
        ],
      ),
    );
  }
}
