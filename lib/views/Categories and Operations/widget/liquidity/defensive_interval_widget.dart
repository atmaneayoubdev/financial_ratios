import 'package:financial_ratios/Helpers/boxes.dart';
import 'package:financial_ratios/Helpers/profile_controller.dart';
import 'package:financial_ratios/Models/operation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../constants.dart';
import '../image_widget.dart';

class DefensiveInterval extends StatefulWidget {
  const DefensiveInterval({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<DefensiveInterval> createState() => _DefensiveIntervalState();
}

class _DefensiveIntervalState extends State<DefensiveInterval> {
  final ProfileDateController controller = Get.put(ProfileDateController());

  double result = 0;
  TextEditingController quickRatioNumerator = TextEditingController();
  TextEditingController projectedExpenditures = TextEditingController();
  bool iscalculated = false;
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

  Future editOperation(Operation operation, double value) async {
    operation.value = value;
    operation.save();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ImageWidget(name: "defensiveInterval"),
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
                keyboardType: TextInputType.number,
                controller: quickRatioNumerator,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  border: InputBorder.none,
                  hintText: "Quick Ratio Numerator",
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
                    result = (365 * double.parse(quickRatioNumerator.text)) /
                        double.parse(projectedExpenditures.text);
                  });
                },
                keyboardType: TextInputType.number,
                controller: projectedExpenditures,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  border: InputBorder.none,
                  hintText: "Projected Expenditures",
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
              return GestureDetector(
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
                        editOperation(similarOps.first, result);
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
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
              );
            }),
      ],
    );
  }
}
