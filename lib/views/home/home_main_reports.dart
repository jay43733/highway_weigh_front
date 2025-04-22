import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/controllers/main_reports_controller.dart';
import 'package:highway_weight/models/general_reports_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_text_button.dart';
import 'package:highway_weight/widgets/form_modal.dart';
import 'package:highway_weight/widgets/pagination.dart';
import 'package:intl/intl.dart';

class HomeMainReports extends StatelessWidget {
  final AuthController authController;
  final MainReportsController mainListsController;
  const HomeMainReports({
    super.key,
    required this.mainListsController,
    required this.authController,
  });

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

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1340.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text("Main Reports", style: TextStyles.h3Semi)],
            ),
            SizedBox(height: 24.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 300.0),
              child: DataTable(
                columnSpacing: 48.0,
                sortAscending: true,
                columns:
                    generalReportHeaders.asMap().entries.map((entries) {
                      return DataColumn(label: Text(entries.value));
                    }).toList(),
                rows:
                    mainListsController.getPaginatedMainLists().asMap().entries.map((
                      entries,
                    ) {
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
                            authController.role == '1'
                                ? Row(
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
                                )
                                : CustomTextButton(
                                  icon: Icons.library_books_outlined,
                                  text: "View",
                                  onPressed: () {
                                    FormModal.showModal(
                                      status: entries.value.status,
                                      role: authController.role,
                                      context,
                                      caption:
                                          "Created at ${DateFormat("yyyy-MM-dd HH:mm").format(entries.value.createdAt)}",
                                      title:
                                          "Created by ${entries.value.generalListReport.whoCreated?.name}",
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
              onPageChanged: mainListsController.onPageChanged,
              itemPerPage: mainListsController.itemsPerPage,
              totalPages: mainListsController.mainReportLists.length,
              currentPage: mainListsController.currentPage,
            ),
          ],
        ),
      ),
    );
  }
}
