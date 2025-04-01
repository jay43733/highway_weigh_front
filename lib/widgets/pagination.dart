import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:number_pagination/number_pagination.dart';

class Pagination extends StatelessWidget {
  final Function(int) onPageChanged;
  final int totalPages;
  final int currentPage;
  final int itemPerPage;
  const Pagination({
    super.key,
    required this.onPageChanged,
    required this.totalPages,
    required this.currentPage,
    required this.itemPerPage,
  });

  @override
  Widget build(BuildContext context) {
    return NumberPagination(
      buttonElevation: 0.0,
      buttonRadius: 64.0,
      selectedButtonColor: AppColors.brandSecondary,
      selectedNumberFontWeight: FontWeight.w700,
      unSelectedButtonColor: AppColors.whitePrimary,
      fontFamily: 'IBMPlexSansThai',
      visiblePagesCount: 5,
      onPageChanged: (int newPage) {
        onPageChanged(newPage - 1);
      },
      totalPages: (totalPages / itemPerPage).ceil(),
      currentPage: currentPage + 1,
    );
  }
}
