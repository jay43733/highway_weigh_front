import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_text_form_field.dart';
import 'package:highway_weight/widgets/primary_button.dart';

class FormModal extends StatefulWidget {
  final String generalName;
  final String description;
  final String category;
  final String station;
  final String imageUrl;
  final int status;
  final String? Function(String?)? commentValidator;
  final Function(String)? onCommentChanged;
  final String? title;
  final String? caption;
  final String? boldText;
  final String? secondaryButtonText;
  final String? primaryButtonText;
  final Function(String comment)? secondaryButtonOnPressed;
  final Function(String comment)? primaryButtonOnPressed;
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
    required this.generalName,
    required this.description,
    required this.category,
    required this.station,
    required this.imageUrl,
    this.commentValidator,
    this.onCommentChanged,
    this.role,
    required this.status,
  });

  @override
  State<FormModal> createState() => _FormModalState();

  static Future<void> showModal(
    BuildContext context, {
    String? role,
    String? primaryButtonText,
    Function(String comment)? secondaryButtonOnPressed,
    Function(String comment)? primaryButtonOnPressed,
    String? title,
    String? caption,
    String? boldText,
    String? secondaryButtonText,
    Function(String)? onCommentChange,
    String? Function(String?)? commentValidator,
    required String generalName,
    required String description,
    required String category,
    required String station,
    required String imageUrl,
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
              primaryButtonOnPressed: (String comment) async {
                if (modalContext.mounted) {
                  Navigator.of(modalContext, rootNavigator: true).pop();
                }
                await primaryButtonOnPressed!(comment);
              },
              secondaryButtonText: secondaryButtonText,
              secondaryButtonOnPressed: (String comment) async {
                if (modalContext.mounted) {
                  Navigator.of(modalContext, rootNavigator: true).pop();
                }
                await secondaryButtonOnPressed!(comment);
              },
              commentValidator: commentValidator,
              onCommentChanged: onCommentChange,
              generalName: generalName,
              description: description,
              category: category,
              station: station,
              imageUrl: imageUrl,
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

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 320.0,
          vertical: widget.role == "2" ? 20.0 : 80.0,
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
                  (widget.role == "2" && widget.status == 1)
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
        maxHeight: widget.role == "2" ? 840.0 : 640.0,
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
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
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
            SizedBox(
              height: 160.0,
              width: double.infinity,
              child: Image.network(
                widget.imageUrl,
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      if (widget.role == "2" && widget.status == 1) ...[
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUnfocus,
            key: _formKey,
            child: CustomTextFormField(
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
          ),
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
                    widget.primaryButtonOnPressed!.call(comment);
                  }
                },
              ),
            ],
          ),
      ],
    ];
  }
}
