import 'package:financial_ratios/Helpers/boxes.dart';
import 'package:financial_ratios/Helpers/profile_controller.dart';
import 'package:financial_ratios/Models/profile.dart';
import 'package:financial_ratios/constants.dart';
import 'package:financial_ratios/tab-view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ExistingProfileView extends StatefulWidget {
  const ExistingProfileView({Key? key}) : super(key: key);

  @override
  State<ExistingProfileView> createState() => _ExistingProfileViewState();
}

class _ExistingProfileViewState extends State<ExistingProfileView> {
  final ProfileDateController controller =
      Get.put<ProfileDateController>(ProfileDateController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            " Please select one the next profiles :",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: GoogleFonts.tajawal(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ValueListenableBuilder<Box<Profile>>(
            valueListenable: Boxes.getProfiles().listenable(),
            builder: (context, box, _) {
              final profiles = box.values.toList().cast<Profile>();
              return ListView.separated(
                padding: const EdgeInsets.only(top: 50),
                itemCount: profiles.length,
                itemBuilder: (BuildContext context, int index) {
                  Profile profile = profiles[index];

                  return profiles.isEmpty
                      ? Center(
                          child: Text(
                            "You have no profiles saved...",
                            style: GoogleFonts.tajawal(
                                fontSize: 16,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.updateDateRange(
                              profile.startDate,
                              profile.endDate,
                            );

                            Get.offAll(() => const TabView());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start date : ${DateFormat.yMMMd().format(profile.startDate)}",
                                  style: GoogleFonts.tajawal(
                                      fontSize: 13,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "End date : ${DateFormat.yMMMd().format(profile.endDate)}",
                                    style: GoogleFonts.tajawal(
                                        fontSize: 13,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.normal))
                              ],
                            ),
                          ),
                        );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
