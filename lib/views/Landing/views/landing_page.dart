import 'package:financial_ratios/constants.dart';
import 'package:financial_ratios/views/Landing/views/existing_profile_view.dart';
import 'package:financial_ratios/views/Landing/views/new_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Get.to(() => const NewProfileView()),
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white10,
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(11)),
                child: Center(
                    child: Text(
                  "New Profile",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.tajawal(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const ExistingProfileView());
              },
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white10,
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(11)),
                child: Center(
                    child: Text(
                  "Existing Profile",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.tajawal(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
