// ignore_for_file: file_names

import 'package:financial_ratios/constants.dart';
import 'package:financial_ratios/views/Comparaison/views/comparaison.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'views/History/views/history_view.dart';
import 'views/Home/views/home_view.dart';

class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);
  static const String routeName = '/tab';

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.calculate, 1),
          buildNavBarItem(Icons.history, 2),
        ],
      ),
      body: _selectedIndex == 0
          ? const HomePage()
          : _selectedIndex == 1
              ? const ComparaisonView()
              : const HistoryView(),
    );
  }

  buildNavBarItem(IconData icon, int index) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: size.height * 0.08,
        width: size.width / 3,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
            color: _selectedIndex == index ? kPrimaryColor : Colors.transparent,
            width: _selectedIndex == index ? 3 : 0,
          )),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: _selectedIndex == index
                    ? kPrimaryColor
                    : Colors.grey.shade400,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                index == 0
                    ? "Home"
                    : index == 1
                        ? "Comparaison"
                        : "History",
                style: GoogleFonts.tajawal(
                  fontSize: 13,
                  color: _selectedIndex == index
                      ? kPrimaryColor
                      : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
