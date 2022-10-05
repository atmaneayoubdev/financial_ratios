// ignore_for_file: file_names

import 'package:financial_ratios/Helpers/boxes.dart';
import 'package:financial_ratios/Helpers/profile_controller.dart';
import 'package:financial_ratios/Models/operation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../constants.dart';
import '../image_widget.dart';

class CurrentRatioWidget extends StatefulWidget {
  const CurrentRatioWidget({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<CurrentRatioWidget> createState() => _CurrentRatioWidgetState();
}

class _CurrentRatioWidgetState extends State<CurrentRatioWidget> {
  final ProfileDateController controller =
      Get.put<ProfileDateController>(ProfileDateController(), permanent: true);

  bool iscalculated = false;
  double result = 0;
  TextEditingController currentLiabilities = TextEditingController();
  TextEditingController currentAssets = TextEditingController();
  bool wantToSave = false;
  double temp = 0;

  Future addOperation(
      double value, String name, DateTime startDate, DateTime endDate) async {
    final operation = Operation()
      ..name = name
      ..value = value
      ..startDate = startDate
      ..endDate = endDate;
    final box = Boxes.getOperations();
    box.add(operation);
  }

  Future deleteOperation(List<Operation> ops) async {
    final box = Boxes.getOperations();
    box.deleteAll(ops);
  }

  Future editOperation(Operation operation, double value) async {
    operation.value = value;
    operation.save();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), (() {
      setState(() {
        result = temp;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const ImageWidget(name: "currentRatios"),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: kPrimaryColor,
                  )),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    result = double.parse(currentAssets.text) /
                        double.parse(currentLiabilities.text);
                  });
                },
                keyboardType: TextInputType.number,
                controller: currentAssets,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  border: InputBorder.none,
                  hintText: "Current Assets",
                  hintStyle:
                      GoogleFonts.tajawal(color: kPrimaryColor, fontSize: 20),
                ),
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: kPrimaryColor,
                  )),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    result = double.parse(currentAssets.text) /
                        double.parse(currentLiabilities.text);
                  });
                },
                keyboardType: TextInputType.number,
                controller: currentLiabilities,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  border: InputBorder.none,
                  hintText: "Current Liabilities",
                  hintStyle:
                      GoogleFonts.tajawal(color: kPrimaryColor, fontSize: 20),
                ),
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(16)),
          child: Text(
            result.toStringAsFixed(3),
            style: GoogleFonts.tajawal(
                color: Colors.white, fontSize: 25, height: 2),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ValueListenableBuilder<Box<Operation>>(
            valueListenable: Boxes.getOperations().listenable(),
            builder: (context, box, _) {
              final operations = box.values.toList().cast<Operation>();
              final similarOps = operations.where(
                (element) =>
                    element.name == widget.name &&
                    element.startDate ==
                        DateTime(
                          controller.profileStartDate.value.year,
                          controller.profileStartDate.value.month,
                          controller.profileStartDate.value.day,
                        ) &&
                    element.endDate ==
                        DateTime(
                          controller.profileEndDate.value.year,
                          controller.profileEndDate.value.month,
                          controller.profileEndDate.value.day,
                        ),
              );
              temp = similarOps.first.value;
              return Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (similarOps.isNotEmpty) {
                        debugPrint("alreasy exists");
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            Widget cancelButton = TextButton(
                              child: const Text("Yes"),
                              onPressed: () {
                                Navigator.pop(context, "true");
                              },
                            );
                            Widget continueButton = TextButton(
                              child: const Text("No"),
                              onPressed: () {
                                Navigator.pop(context, "false");
                              },
                            );
                            return AlertDialog(
                              title: const Text("Alert"),
                              content: const Text(
                                  "This value already exist, Do you want to save your new value ?"),
                              actions: [
                                cancelButton,
                                continueButton,
                              ],
                            );
                          },
                        ).then((value) {
                          if (value == "true") {
                            debugPrint("am saving then....");
                            editOperation(similarOps.first, result)
                                .then((value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("value updated succesfully"),
                                backgroundColor: Colors.green,
                                duration: Duration(milliseconds: 2000),
                              ));
                            });
                          } else {
                            debugPrint("not saving then");
                          }
                        });
                      } else {
                        debugPrint("not existing and saving...");
                        addOperation(
                          result,
                          widget.name,
                          DateTime(
                            controller.profileStartDate.value.year,
                            controller.profileStartDate.value.month,
                            controller.profileStartDate.value.day,
                          ),
                          DateTime(
                            controller.profileEndDate.value.year,
                            controller.profileEndDate.value.month,
                            controller.profileEndDate.value.day,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("value saved succesfully"),
                          backgroundColor: Colors.green,
                          duration: Duration(milliseconds: 2000),
                        ));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Save",
                            style: GoogleFonts.tajawal(
                                color: Colors.white, fontSize: 25),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.save,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ],
    );
  }
}
