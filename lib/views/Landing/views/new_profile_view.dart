import 'package:financial_ratios/Helpers/boxes.dart';
import 'package:financial_ratios/Helpers/profile_controller.dart';
import 'package:financial_ratios/Models/profile.dart';
import 'package:financial_ratios/constants.dart';
import 'package:financial_ratios/tab-view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class NewProfileView extends StatefulWidget {
  const NewProfileView({Key? key}) : super(key: key);

  @override
  State<NewProfileView> createState() => _NewProfileViewState();
}

class _NewProfileViewState extends State<NewProfileView> {
  final ProfileDateController controller =
      Get.put<ProfileDateController>(ProfileDateController(), permanent: true);

  DateTimeRange? _selectedDateRange;
  bool isNotSelectted = false;

  void _show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kPrimaryColor, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: kPrimaryColor, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      // Rebuild the UI
      debugPrint(result.start.toString());
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

  Future addProfile(DateTime startDate, DateTime endDate) async {
    final profle = Profile()
      ..startDate = startDate
      ..endDate = endDate;
    final box = Boxes.getProfiles();
    box.add(profle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              " Please choose the date range then press 'Done' ",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: isNotSelectted ? Colors.red : Colors.transparent),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white10,
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(11),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isNotSelectted = false;
                  });
                  _show();
                },
                child: const FittedBox(
                  child: Icon(
                    Icons.date_range,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            if (_selectedDateRange != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "From :  ${_selectedDateRange!.start.day}/${_selectedDateRange!.start.month}/${_selectedDateRange!.start.year}",
                    style: GoogleFonts.tajawal(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "To :  ${_selectedDateRange!.end.day}/${_selectedDateRange!.end.month}/${_selectedDateRange!.end.year}",
                    style: GoogleFonts.tajawal(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                if (_selectedDateRange != null) {
                  addProfile(_selectedDateRange!.start, _selectedDateRange!.end)
                      .then((value) {
                    controller.updateDateRange(
                      _selectedDateRange!.start,
                      _selectedDateRange!.end,
                    );
                    Get.off(() => const TabView());
                  });
                } else {
                  setState(() {
                    isNotSelectted = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please select the date range",
                        style: GoogleFonts.tajawal(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.3,
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
                    "Done",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: GoogleFonts.tajawal(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
