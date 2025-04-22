import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/models/general_reports_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_text_button.dart';
import 'package:highway_weight/widgets/form_modal.dart';
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
            .toList()
          ..sort(
            (a, b) =>
                (b.whoCreated?.id.toString() == authController.id ? 1 : 0) -
                (a.whoCreated?.id.toString() == authController.id ? 1 : 0),
          );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("General Reports", style: TextStyles.h3Semi),

              if (authController.role == '1' || authController.role == "5")
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
              columnSpacing: 48.0,
              sortAscending: true,
              columns:
                  generalReportHeaders.asMap().entries.map((entries) {
                    return DataColumn(label: Text(entries.value));
                  }).toList(),
              rows:
                  generalReportsController
                      .getPaginatedGeneralLists(authController.id)
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
                                  ? CustomTextButton(
                                    icon: Icons.mark_unread_chat_alt,
                                    text: "Review",
                                    onPressed: () {
                                      generalReportsController.updateAllField(
                                        entries.value,
                                      );
                                      FormModal.showModal(
                                        role: authController.role,
                                        context,
                                        title: "Approve & Comment",
                                        generalName: entries.value.name,
                                        description: entries.value.description,
                                        category: IssueCategory.getTitle(
                                          entries.value.category,
                                        ),
                                        onCommentChange: (value) {
                                          generalReportsController.updateField(
                                            "comment",
                                            value,
                                          );
                                        },
                                        commentValidator:
                                            (value) => generalReportsController
                                                .validateField(
                                                  "comment",
                                                  value,
                                                ),
                                        station: entries.value.station.name,
                                        imageUrl: entries.value.imageUrl,
                                        primaryButtonText: "APPROVE",
                                        primaryButtonOnPressed: () {
                                          generalReportsController
                                              .resetAllField();
                                         
                                        },
                                        secondaryButtonText: "REJECT",
                                        secondaryButtonOnPressed: () {
                                          generalReportsController
                                              .resetAllField();
                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).pop();
                                        },
                                      );
                                    },
                                  )
                                  : entries.value.whoCreated?.id.toString() ==
                                      authController.id
                                  ? Row(
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
                                  )
                                  : CustomTextButton(
                                    icon: Icons.library_books_outlined,
                                    text: "View",
                                    onPressed: () {
                                      FormModal.showModal(
                                        role: authController.role,
                                        context,
                                        caption:
                                            "Created at ${DateFormat("yyyy-MM-dd HH:mm").format(entries.value.createdAt)}",
                                        title:
                                            "Created by ${entries.value.whoCreated?.name}",
                                        generalName: entries.value.name,
                                        description: entries.value.description,
                                        category: IssueCategory.getTitle(
                                          entries.value.category,
                                        ),
                                        station: entries.value.station.name,
                                        imageUrl: entries.value.imageUrl,
                                      );
                                    },
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
