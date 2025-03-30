import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/components/widget.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/main.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AppButton(
              color: jcbPrimaryColor,
              text: "Show loader...",
              onTap: () => {appStore.setLoading(true)},
            ),
          ),
          Observer(builder: (context) {
            return Visibility(
                visible: appStore.isLoading,
                child: Loading().onTap(() => {
                      appStore.setLoading(false),
                    }));
          })
        ],
      ),
    );
  }
}
