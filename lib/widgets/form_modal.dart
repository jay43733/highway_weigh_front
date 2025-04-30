import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_text_form_field.dart';
import 'package:highway_weight/widgets/primary_button.dart';
import 'package:intl/intl.dart';

class FormModal extends StatefulWidget {
  final String generalName;
  final String description;
  final String category;
  final String station;
  final String imageUrl;
  final String reportedDate;
  final int status;
  final String formName;
  final String? Function(String?)? commentValidator;
  final String? Function(String?)? visitDateValidator;
  final Function(String)? onCommentChanged;
  final String? title;
  final String? caption;
  final String? boldText;
  final String? secondaryButtonText;
  final String? primaryButtonText;
  final String? visitDate;
  final Function(String comment)? secondaryButtonOnPressed;
  final Function(String comment, String? visitDate)? primaryButtonOnPressed;
  final String? role;

  const FormModal({
    super.key,
    this.title,
    this.caption,
    this.secondaryButtonText,
    this.primaryButtonText,
    this.secondaryButtonOnPressed,
    this.primaryButtonOnPressed,
    this.boldText,
    this.visitDate,
    required this.generalName,
    required this.description,
    required this.category,
    required this.station,
    required this.imageUrl,
    required this.reportedDate,
    this.commentValidator,
    this.visitDateValidator,
    this.onCommentChanged,
    this.role,
    required this.status,
    required this.formName,
  });

  @override
  State<FormModal> createState() => _FormModalState();

  static Future<void> showModal(
    BuildContext context, {
    String? role,
    String? primaryButtonText,
    Function(String comment)? secondaryButtonOnPressed,
    Function(String comment, String? visitDate)? primaryButtonOnPressed,
    String? title,
    String? caption,
    String? boldText,
    String? visitDate,
    String? secondaryButtonText,
    Function(String)? onCommentChange,
    String? Function(String?)? commentValidator,
    String? Function(String?)? visitDateValidator,
    required String formName,
    required String generalName,
    required String description,
    required String category,
    required String station,
    required String imageUrl,
    required String reportedDate,
    required int status,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) {
        return Builder(
          builder: (modalContext) {
            return FormModal(
              status: status,
              title: title,
              role: role,
              caption: caption,
              boldText: boldText,
              primaryButtonText: primaryButtonText,
              primaryButtonOnPressed: (
                String comment,
                String? visitDate,
              ) async {
                if (modalContext.mounted) {
                  Navigator.of(modalContext, rootNavigator: true).pop();
                }
                Future.microtask(() async {
                  await primaryButtonOnPressed!(comment, visitDate);
                });
              },
              secondaryButtonText: secondaryButtonText,
              secondaryButtonOnPressed: (String comment) async {
                if (modalContext.mounted) {
                  Navigator.of(modalContext, rootNavigator: true).pop();
                }
                Future.microtask(() async {
                  await secondaryButtonOnPressed!(comment);
                });
              },
              commentValidator: commentValidator,
              onCommentChanged: onCommentChange,
              visitDateValidator: visitDateValidator,
              generalName: generalName,
              description: description,
              category: category,
              station: station,
              imageUrl: imageUrl,
              formName: formName,
              visitDate: visitDate,
              reportedDate: reportedDate,
            );
          },
        );
      },
    );
  }
}

class _FormModalState extends State<FormModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String comment = "";
  String? visitDate;
  final TextEditingController visitDateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.visitDate != null) {
      visitDateController.text = widget.visitDate!;
      visitDate = widget.visitDate!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 320.0,
          vertical:
              ((widget.formName == 'general' &&
                          widget.role == "2" &&
                          widget.status == 1) ||
                      (widget.formName == 'main' &&
                          widget.role == "1" &&
                          widget.status == 1) ||
                      (widget.formName == 'inspector' &&
                          widget.role == "4" &&
                          widget.status == 1))
                  ? 20.0
                  : 22.0,
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.whitePrimary,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(13),
                    blurRadius: 20.0,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 40.0,
                    offset: Offset(0, 24),
                  ),
                ],
              ),
              child:
                  widget.formName == 'general' &&
                          (widget.role == "2" && widget.status == 1)
                      ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: _buildScrollableContent(),
                      )
                      : widget.formName == 'main' &&
                          (widget.role == "1" && widget.status == 1)
                      ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: _buildScrollableContent(),
                      )
                      : widget.formName == 'inspector' &&
                          (widget.role == "4" && widget.status == 1)
                      ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: _buildScrollableContent(),
                      )
                      : _buildNoScrollContent(),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: const Icon(
                  Icons.close,
                  size: 28.0,
                  color: AppColors.blackPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoScrollContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildMainChildren(),
    );
  }

  Widget _buildScrollableContent() {
    return Container(
      constraints: BoxConstraints(
        maxHeight:
            (widget.formName == 'general' && widget.role == "2") ||
                    (widget.formName == 'main' && widget.role == "1") ||
                    (widget.formName == 'inspector' && widget.role == "4")
                ? 992.0
                : 732.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildMainChildren(),
      ),
    );
  }

  List<Widget> _buildMainChildren() {
    return [
      if (widget.title != null)
        Center(
          child: Text(
            widget.title!,
            style: TextStyles.h4Semi.copyWith(color: AppColors.blackPure),
          ),
        ),
      SizedBox(height: 10.0),
      if (widget.caption != null)
        Center(
          child: Text(
            widget.caption!,
            style: TextStyles.bodyReg.copyWith(color: AppColors.redColor),
          ),
        ),
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            children: [
              CustomTextFormField(
                labelText: "วันที่ร้องเรียน",
                initialValue: widget.reportedDate,
                enabled: false,
                suffixIcon: Icons.calendar_month,
                onTap: null,
                validator: null,
              ),
              SizedBox(height: 16.0),
              CustomTextFormField(
                labelText: "ชื่อหัวข้อ",
                initialValue: widget.generalName,
                enabled: false,
              ),
              SizedBox(height: 16.0),
              CustomTextFormField(
                labelText: "ประเภทการร้องเรียน",
                initialValue: widget.category,
                enabled: false,
              ),
              SizedBox(height: 16.0),
              CustomTextFormField(
                labelText: "หมายเหตุ",
                initialValue: widget.description,
                maxLines: 3,
                enabled: false,
              ),
              SizedBox(height: 16.0),
              CustomTextFormField(
                labelText: "สถานี",
                initialValue: widget.station,
                enabled: false,
              ),
              SizedBox(height: 16.0),

              if (widget.role == '4' && widget.formName == 'inspector') ...[
                CustomTextFormField(
                  controller: visitDateController,
                  labelText:
                      (widget.visitDate != null || visitDate != null)
                          ? "วันที่ออกตรวจ"
                          : "ยังไม่มีวันตรวจ",
                  enabled: true,
                  readOnly: true,
                  useCursorClick: true,
                  suffixIcon: Icons.calendar_month,
                  onTap: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialDate:
                          (widget.visitDate != null || visitDate != null)
                              ? DateTime.tryParse(visitDate!)
                              : DateTime.now(),
                    );
                    if (dateTime != null) {
                      final String dateTimeString = DateFormat(
                        'yyyy-MM-dd',
                      ).format(dateTime);
                      setState(() {
                        visitDate = dateTimeString;
                        visitDateController.text = dateTimeString;
                      });
                    }
                  },
                  validator: widget.visitDateValidator,
                ),
                SizedBox(height: 16.0),
              ],

              SizedBox(
                height: 160.0,
                width: double.infinity,
                child: Image.network(
                  widget.imageUrl,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                ),
              ),
              if (widget.formName == 'general' &&
                  widget.role == "2" &&
                  widget.status == 1) ...[
                const SizedBox(height: 20.0),
                Column(
                  children: [
                    CustomTextFormField(
                      controller: visitDateController,
                      labelText: "วันที่ออกตรวจ",
                      hintText: "วันที่ออกตรวจ",
                      readOnly: true,
                      useCursorClick: true,
                      suffixIcon: Icons.calendar_month,
                      validator: (value) {
                        if (value != null) {
                          final dateValue = DateTime.tryParse(value);
                          final now = DateTime.now();
                          final today = DateTime(now.year, now.month, now.day);
                          if (dateValue == null) {
                            return null;
                          }
                          if (dateValue.isBefore(today)) {
                            return 'Visit date cannot be in the past';
                          }
                          return null;
                        }
                        return null;
                      },
                      onTap: () async {
                        final DateTime? dateTime = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          initialDate: DateTime.now(),
                        );
                        if (dateTime != null) {
                          final String dateTimeString = DateFormat(
                            'yyyy-MM-dd',
                          ).format(dateTime);
                          setState(() {
                            visitDate = dateTimeString;
                            visitDateController.text = dateTimeString;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    CustomTextFormField(
                      hintText: "ความคิดเห็นของหัวหน้าสถานี",
                      labelText: "Comment",
                      maxLines: 3,
                      onChanged: (value) {
                        setState(() {
                          comment = value;
                        });
                      },
                      validator: widget.commentValidator,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                if (widget.secondaryButtonText != null &&
                    widget.secondaryButtonOnPressed != null &&
                    widget.primaryButtonText != null &&
                    widget.primaryButtonOnPressed != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        icon: Icons.close_sharp,
                        color: AppColors.redColor,
                        text: widget.secondaryButtonText!,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.secondaryButtonOnPressed!.call(comment);
                          }
                        },
                      ),
                      SizedBox(width: 40.0),
                      PrimaryButton(
                        icon: Icons.check,
                        color: AppColors.greenColor,
                        text: widget.primaryButtonText!,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.primaryButtonOnPressed!.call(
                              comment,
                              visitDate,
                            );
                          }
                        },
                      ),
                    ],
                  ),
              ],
              if (widget.formName == 'main' &&
                  widget.role == "1" &&
                  widget.status == 1) ...[
                const SizedBox(height: 20.0),
                Column(
                  children: [
                    CustomTextFormField(
                      labelText:
                          widget.visitDate != null
                              ? "วันออกตรวจ"
                              : 'ยังไม่มีวันตรวจ',
                      initialValue: widget.visitDate,
                      enabled: false,
                      suffixIcon: Icons.calendar_month,
                    ),
                    SizedBox(height: 16),
                    CustomTextFormField(
                      hintText: "ความคิดเห็นของผู้อำนวยการ",
                      labelText: "Comment",
                      maxLines: 3,
                      onChanged: (value) {
                        setState(() {
                          comment = value;
                        });
                      },
                      validator: widget.commentValidator,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                if (widget.secondaryButtonText != null &&
                    widget.secondaryButtonOnPressed != null &&
                    widget.primaryButtonText != null &&
                    widget.primaryButtonOnPressed != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        icon: Icons.close_sharp,
                        color: AppColors.redColor,
                        text: widget.secondaryButtonText!,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.secondaryButtonOnPressed!.call(comment);
                          }
                        },
                      ),
                      SizedBox(width: 40.0),
                      PrimaryButton(
                        icon: Icons.check,
                        color: AppColors.greenColor,
                        text: widget.primaryButtonText!,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            widget.primaryButtonOnPressed!.call(
                              comment,
                              visitDate,
                            );
                          }
                        },
                      ),
                    ],
                  ),
              ],
              if (widget.formName == 'inspector' &&
                  widget.role == "4" &&
                  widget.status == 1) ...[
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  hintText: "ความคิดเห็นของผู้อำนวยการ",
                  labelText: "Comment",
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      comment = value;
                    });
                  },
                  validator: widget.commentValidator,
                ),
                const SizedBox(height: 32.0),
                if (widget.primaryButtonText != null &&
                    widget.primaryButtonOnPressed != null)
                  SizedBox(
                    width: 160.0,
                    child: PrimaryButton(
                      icon: Icons.check,
                      color: AppColors.greenColor,
                      text: widget.primaryButtonText!,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.primaryButtonOnPressed!.call(
                            comment,
                            visitDate,
                          );
                        }
                      },
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    visitDateController.dispose();
  }
}
