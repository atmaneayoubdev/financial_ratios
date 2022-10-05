import 'package:financial_ratios/Helpers/boxes.dart';
import 'package:financial_ratios/Helpers/data.dart';
import 'package:financial_ratios/Helpers/profile_controller.dart';
import 'package:financial_ratios/Models/operation.dart';
import 'package:financial_ratios/Models/profile.dart';
import 'package:financial_ratios/constants.dart';
import 'package:financial_ratios/views/Landing/views/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ComparaisonView extends StatefulWidget {
  const ComparaisonView({Key? key}) : super(key: key);

  @override
  State<ComparaisonView> createState() => _ComparaisonViewState();
}

class _ComparaisonViewState extends State<ComparaisonView> {
  final ProfileDateController controller =
      Get.put<ProfileDateController>(ProfileDateController(), permanent: true);

  // Initial Selected Value
  Profile? dropdownvalue1;
  Profile? dropdownvalue2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_outlined)),
                FittedBox(
                  child: Text(
                    "Comparaison",
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
                    Get.to(
                      () => const LandingView(),
                    );
                  },
                  icon: const Icon(Icons.account_circle_outlined),
                ),
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
          const SizedBox(height: 20),
          ValueListenableBuilder<Box<Profile>>(
            valueListenable: Boxes.getProfiles().listenable(),
            builder: (context, box, _) {
              final profiles = box.values.toList().cast<Profile>();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(16)),
                            child: DropdownButton<Profile>(
                              borderRadius: BorderRadius.circular(16),
                              underline: const SizedBox(),

                              // Initial Value
                              value: dropdownvalue1,
                              hint: const Text("First Profile"),
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: profiles.map((Profile pro) {
                                return DropdownMenuItem(
                                  value: pro,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    color: Colors.red.shade100,
                                    child: FittedBox(
                                      child: Text(
                                        'From ${DateFormat.yMMMd().format(pro.startDate)}\nTo ${DateFormat.yMMMEd().format(pro.endDate)}',
                                        overflow: TextOverflow.clip,
                                        style: GoogleFonts.tajawal(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (Profile? newProfile) {
                                setState(() {
                                  dropdownvalue1 = newProfile!;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.all(5),
                            child: DropdownButton<Profile>(
                              borderRadius: BorderRadius.circular(16),
                              underline: const SizedBox(),

                              // Initial Value
                              value: dropdownvalue2,
                              hint: const Text("Second Profile"),
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: profiles.map((Profile pro) {
                                return DropdownMenuItem(
                                  value: pro,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    color: Colors.amber.shade100,
                                    child: FittedBox(
                                      child: Text(
                                        'From ${DateFormat.yMMMd().format(pro.startDate)}\nTo ${DateFormat.yMMMEd().format(pro.endDate)}',
                                        overflow: TextOverflow.clip,
                                        style: GoogleFonts.tajawal(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (Profile? newProfile) {
                                setState(() {
                                  dropdownvalue2 = newProfile!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Liquidity Ratios",
            style: GoogleFonts.tajawal(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          ValueListenableBuilder<Box<Operation>>(
            valueListenable: Boxes.getOperations().listenable(),
            builder: (context, box, _) {
              final operations = box.values.toList().cast<Operation>();
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: liquidityRatios.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Center(
                        child: Text(
                          liquidityRatios[index],
                          style: GoogleFonts.tajawal(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          dropdownvalue1 != null &&
                                  operations.any((element) =>
                                      element.name == liquidityRatios[index] &&
                                      element.startDate ==
                                          dropdownvalue1!.startDate &&
                                      element.endDate ==
                                          dropdownvalue1!.endDate)
                              ? Expanded(
                                  child: Container(
                                  padding: const EdgeInsets.all(3),
                                  color: Colors.red.shade100,
                                  child: Center(
                                    child: Text(
                                      operations
                                          .firstWhere((element) =>
                                              element.name ==
                                                  liquidityRatios[index] &&
                                              element.startDate ==
                                                  dropdownvalue1!.startDate &&
                                              element.endDate ==
                                                  dropdownvalue1!.endDate)
                                          .value
                                          .toStringAsFixed(3),
                                      style: GoogleFonts.tajawal(fontSize: 18),
                                    ),
                                  ),
                                ))
                              : Expanded(
                                  child: Container(
                                      color: Colors.red.shade100,
                                      child: Center(
                                        child: Text(
                                          "no data",
                                          style:
                                              GoogleFonts.tajawal(fontSize: 18),
                                        ),
                                      )),
                                ),
                          // const Divider(),
                          dropdownvalue2 != null &&
                                  operations.any((element) =>
                                      element.name == liquidityRatios[index] &&
                                      element.startDate ==
                                          dropdownvalue2!.startDate &&
                                      element.endDate ==
                                          dropdownvalue2!.endDate)
                              ? Expanded(
                                  child: Container(
                                  padding: const EdgeInsets.all(3),
                                  color: Colors.amber.shade100,
                                  child: Center(
                                    child: Text(
                                      operations
                                          .firstWhere((element) =>
                                              element.name ==
                                                  liquidityRatios[index] &&
                                              element.startDate ==
                                                  dropdownvalue2!.startDate &&
                                              element.endDate ==
                                                  dropdownvalue2!.endDate)
                                          .value
                                          .toStringAsFixed(3),
                                      style: GoogleFonts.tajawal(fontSize: 18),
                                    ),
                                  ),
                                ))
                              : Expanded(
                                  child: Container(
                                      color: Colors.amber.shade100,
                                      child: Center(
                                        child: Text(
                                          "no data",
                                          style:
                                              GoogleFonts.tajawal(fontSize: 18),
                                        ),
                                      )),
                                )
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
