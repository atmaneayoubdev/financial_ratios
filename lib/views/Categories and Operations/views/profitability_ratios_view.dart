import 'package:financial_ratios/Helpers/data.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/views/operation_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';
import 'package:get/get.dart';

class ProfitibilityRatiosView extends StatefulWidget {
  const ProfitibilityRatiosView({Key? key}) : super(key: key);

  @override
  State<ProfitibilityRatiosView> createState() =>
      _ProfitibilityRatiosViewState();
}

class _ProfitibilityRatiosViewState extends State<ProfitibilityRatiosView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_outlined)),
                FittedBox(
                  child: Text(
                    "Profitability Ratios",
                    style: GoogleFonts.tajawal(
                      height: 2,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.account_circle_outlined)),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemCount: profitabilityRatios.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                        () => OperationsView(name: profitabilityRatios[index]));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
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
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: Offset(3, 3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        profitabilityRatios[index],
                        style: GoogleFonts.tajawal(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
