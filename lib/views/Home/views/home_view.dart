import 'package:financial_ratios/Helpers/profile_controller.dart';
import 'package:financial_ratios/constants.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/views/liquidity_ratios_view.dart';
import 'package:financial_ratios/views/Home/widgets/stagred_widget.dart';
import 'package:financial_ratios/views/Landing/views/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProfileDateController controller =
      Get.put<ProfileDateController>(ProfileDateController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      "Home",
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 3,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const LiquidityRatiosView());
                        },
                        child: const StagredWidget(
                          name: 'Liquidity',
                        ),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 3,
                      child: InkWell(
                        onTap: () {
                          //Get.to(() => const ActivityRaiosView());
                        },
                        child: const StagredWidget(
                          name: 'Activity',
                        ),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 3,
                      child: InkWell(
                        onTap: () {
                          //Get.to(() => const ProfitibilityRatiosView());
                        },
                        child: const StagredWidget(
                          name: 'Profitability',
                        ),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 3,
                      child: InkWell(
                        onTap: () {
                          //Get.to(() => const SolvencyRatiosView());
                        },
                        child: const StagredWidget(
                          name: 'Solvency',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
