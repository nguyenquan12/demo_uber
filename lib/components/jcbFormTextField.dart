import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/extensions/colors.dart';

// ignore: must_be_immutable
class Jcbformtextfield extends StatefulWidget {
  String label; // Nhãn hiển thị cho ô nhập liệu
  double? width; // Chiều rộng của TextField
  TextFieldType textFieldType; // Loại ô nhập liệu (ví dụ:email, password, etc.)
  TextInputAction? textInputAction; // Hành động trên bàn phím (next, done,...)
  TextEditingController? controller; // Điều khiển nội dung nhập liệu
  FocusNode? focusNode; // Điều khiển focus của trường nhập liệu
  FocusNode? nextFocusNode; // Focus tiếp theo khi nhấn Enter
  bool? autoFocus; // Có tự động focus vào trường nhập liệu không?
  TextInputType? keyboardType; // Loại bàn phím (text, number, email, phone,...)
  bool? labelSpace; // Có hiển thị khoảng cách giữa nhãn và ô nhập liệu không?

  Jcbformtextfield({
    required this.label,
    this.width,
    required this.textFieldType,
    this.textInputAction,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.autoFocus = false,
    this.keyboardType,
    this.labelSpace = true,
  });

  @override
  State<Jcbformtextfield> createState() => _JcbformtextfieldState();
}

class _JcbformtextfieldState extends State<Jcbformtextfield> {
  String checkText = ''; // Biến để kiểm tra nội dung nhập liệu

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        checkText != ''
            ? Text(
                widget.label,
                style: boldTextStyle(color: jcbGreyColor, size: 14),
              )
            : widget.labelSpace.validate()
                ? Text('', style: boldTextStyle(size: 14))
                : Offstage(),
        widget.labelSpace.validate() ? 6.height : Offstage(),
        Container(
          width: widget.width ?? context.width() - 30,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: jcbSecBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: AppTextField(
            // Loại bàn phím
            keyboardType: widget.keyboardType ?? TextInputType.name,
            // Tự động focus khi mở màn hình.
            autoFocus: widget.autoFocus ?? false,
            // Điều khiển nội dung nhập liệu
            controller: widget.controller,
            // Điều hướng focus khi nhập xong
            focus: widget.focusNode,
            nextFocus: widget.nextFocusNode,
            // Kiểu nhập liệu (email, password,...)
            textFieldType: widget.textFieldType,
            // Xác định hành động của phím "Enter" trên bàn phím ảo.
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            textStyle: boldTextStyle(),
            onChanged: (value) {
              checkText = value; // Cập nhật biến kiểm tra khi có thay đổi
              setState(() {});
            },
            suffixPasswordInvisibleWidget: Icon(Icons.visibility_off,
                color: Colors.grey), // Ẩn biểu tượng mắt khi nhập mật khẩu
            suffixPasswordVisibleWidget: Icon(Icons.visibility,
                color: jcbPrimaryColor), // Ẩn biểu tượng mắt khi nhập mật khẩu
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.label,
              hintStyle: boldTextStyle(color: jcbGreyColor, size: 14),
            ),
          ),
        )
      ],
    );
  }
}
