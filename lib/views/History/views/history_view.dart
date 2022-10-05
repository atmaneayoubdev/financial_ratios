// ignore_for_file: depend_on_referenced_packages

import 'package:financial_ratios/Helpers/boxes.dart';
import 'package:financial_ratios/Helpers/profile_controller.dart';
import 'package:financial_ratios/Models/operation.dart';
import 'package:financial_ratios/constants.dart';
import 'package:financial_ratios/views/Landing/views/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final ProfileDateController controller =
      Get.put<ProfileDateController>(ProfileDateController(), permanent: true);

  DateFormat dateFormat = DateFormat("MMMM-dd-yyyy");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_outlined)),
                FittedBox(
                  child: Text(
                    "History",
                    style: GoogleFonts.tajawal(
                      height: 2,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Get.to(() => const LandingView());
                    },
                    icon: const Icon(
                      Icons.account_circle_outlined,
                    )),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: kPrimaryColor,
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Text(
                'From ${DateFormat.yMMMd().format(controller.profileStartDate.value)} To ${DateFormat.yMMMEd().format(controller.profileEndDate.value)}',
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Box<Operation>>(
              valueListenable: Boxes.getOperations().listenable(),
              builder: (context, box, _) {
                final operation = box.values.toList().cast<Operation>();
                return operation.isEmpty
                    ? Center(
                        child: Text(
                          "There no data in history...",
                          style: GoogleFonts.tajawal(
                              fontSize: 23,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(top: 50),
                        itemCount: operation.length,
                        itemBuilder: (BuildContext context, int index) {
                          String start =
                              dateFormat.format(operation[index].startDate);
                          String end =
                              dateFormat.format(operation[index].endDate);

                          return operation.isEmpty
                              ? Center(
                                  child: Text(
                                    "You have no operations saved...",
                                    style: GoogleFonts.tajawal(
                                        fontSize: 16,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 0, 6, 72),
                                        kPrimaryColor,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      tileMode: TileMode.clamp,
                                    ),
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            operation[index].name,
                                            style: GoogleFonts.tajawal(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Start datae : $start",
                                            style: GoogleFonts.tajawal(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("End date : $end",
                                              style: GoogleFonts.tajawal(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.normal))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          operation[index]
                                              .value
                                              .toStringAsFixed(3),
                                          style: GoogleFonts.tajawal(
                                              fontSize: 20,
                                              color: const Color.fromARGB(
                                                  255, 123, 213, 126),
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 10,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
