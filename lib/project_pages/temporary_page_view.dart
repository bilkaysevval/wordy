import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../features/customs/custom_text_widget.dart';
import '../features/project_utilities/colors_utility.dart';
import '../features/project_utilities/sizes_utility.dart';
import 'main_page.dart';

class TemporaryPageView extends StatefulWidget {
  const TemporaryPageView({super.key});

  @override
  State<TemporaryPageView> createState() => _TemporaryPageViewState();
}

class _TemporaryPageViewState extends State<TemporaryPageView> {
  @override
  void initState() {
    super.initState();
    // with this initState our page shows up 3 seconds and then will be closed
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ));
        // 'push' just skips the current page but 'pushReplacement' deletes and skips the current page
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle
            .light, // if we do not this then appBar will disappear
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 175),
                child: Image.asset("assets/logo/wordy_logo.png"),
              ),
              const TextUtility(
                  txt: "wordy",
                  color: ColorsUtility.mandy,
                  size: SizesUtility.mainSize),
            ],
          ),
        ),
      ),
    );
  }
}
