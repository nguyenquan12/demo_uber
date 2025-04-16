import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/components/widget.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/models/jcbSearchDestinationModel.dart';
import 'package:uber_app/utils/constants.dart';

class SearchDestinationScreen extends StatefulWidget {
  const SearchDestinationScreen({super.key});

  @override
  State<SearchDestinationScreen> createState() =>
      _SearchDestinationScreenState();
}

class _SearchDestinationScreenState extends State<SearchDestinationScreen> {
  List<JCBSearchDestinationModel> destinationList = jcbDestinationsList();

  TextEditingController destination = TextEditingController();
  List<String> addedDestinations = [];

  bool showAdd = false;

  Widget getDesWidget() {
    if (addedDestinations.isEmpty) {
      return Offstage();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ... Toán tử spread để thêm các widget vào danh sách
          ...addedDestinations.map((e) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      e,
                      style: boldTextStyle(),
                    ),
                    Icon(
                      Icons.cancel,
                      color: jcbSecBorderColor,
                      size: 20,
                    ).onTap(() {
                      addedDestinations.remove(e);
                      setState(() {});
                    }),
                    Divider(
                      color: jcbSecBorderColor,
                    )
                  ],
                )
              ],
            );
          }).toList(),
        ],
      );
    }
  }

  Widget getDottedLine() {
    if (addedDestinations.isEmpty) {
      return Offstage();
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: addedDestinations.map((e) {
          return Column(
            children: [
              Icon(
                Icons.square,
                color: jcbPrimaryColor,
                size: 20,
              ),
            ],
          );
        }).toList(),
      );
    }
  }

  @override
  void dispose() {
    addedDestinations.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            finish(context);
          },
          icon: Image.asset(
            ic_close,
            height: 20,
            width: 20,
            color: context.iconColor,
            fit: BoxFit.cover,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.map_outlined,
              color: context.iconColor,
              size: 30,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.scaffoldBackgroundColor,
                borderRadius: radiusOnly(
                  bottomLeft: jcbBottomSheetRadius,
                  bottomRight: jcbBottomSheetRadius,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 0), // Vị trí bóng
                    blurRadius: 6.0, // Độ mờ của bóng
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(Icons.circle, color: context.iconColor, size: 20),
                      jcbDottedLineComponent(),
                      getDottedLine(),
                      Icon(Icons.square, color: jcbPrimaryColor, size: 20),
                    ],
                  ),
                  8.width,
                  SizedBox(
                    width: context.width() * 4 / 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '199 Brown Estate Apt.866',
                          style: boldTextStyle(),
                        ),
                        Divider(color: jcbSecBorderColor),
                        getDesWidget(),
                        AppTextField(
                          textFieldType: TextFieldType.NAME,
                          controller: destination,
                          textStyle: boldTextStyle(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Destination',
                            hintStyle: boldTextStyle(color: jcbGreyColor),
                            contentPadding: EdgeInsets.all(0),
                            isDense: true,
                            suffixIcon: Icon(
                              Icons.add,
                              color: context.iconColor,
                              size: 24,
                            ).onTap(() {
                              if (destination.text != '') {
                                addedDestinations.add(destination.text);
                              } else {
                                toast('Please Enter Destination');
                              }
                              setState(() {});
                              destination.clear();
                            }),
                            suffixIconConstraints: BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                          ),
                          onChanged: (val) {
                            showAdd = true;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: jcbGreyColor.withValues(alpha: 0.2),
                      borderRadius: radius(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        ic_home,
                        height: 20,
                        width: 20,
                        color: context.iconColor,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  16.width,
                  Text('Home', style: boldTextStyle(color: jcbDarkColor)),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: jcbSecBorderColor,
              indent: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: jcbGreyColor.withValues(alpha: 0.2),
                      borderRadius: radius(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        ic_suitcase,
                        height: 20,
                        width: 20,
                        color: context.iconColor,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  16.width,
                  Text('Work', style: boldTextStyle(color: jcbDarkColor)),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: jcbSecBorderColor,
            ),
            Divider(
              height: 20,
              color: jcbSecBorderColor,
            ),
            Column(
              children: [
                ...destinationList.map((e) {
                  return JCBDestinationWidget(e);
                })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget JCBDestinationWidget(JCBSearchDestinationModel destinationModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Image.asset(
            ic_pin,
            height: 40,
            width: 40,
            color: jcbImageColor,
            fit: BoxFit.cover,
          ),
          8.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(destinationModel.name, style: boldTextStyle()),
                Text(destinationModel.address),
                Divider(height: 15, color: jcbSecBorderColor),
              ],
            ),
          )
        ],
      ),
    );
  }
}
