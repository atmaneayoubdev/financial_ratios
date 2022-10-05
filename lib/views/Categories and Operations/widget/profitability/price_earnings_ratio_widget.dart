import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants.dart';
import '../image_widget.dart';

class PriceEarningsRatio extends StatefulWidget {
  const PriceEarningsRatio({Key? key}) : super(key: key);

  @override
  State<PriceEarningsRatio> createState() => _PriceEarningsRatioState();
}

class _PriceEarningsRatioState extends State<PriceEarningsRatio> {
  double result = 0;
  TextEditingController marketPriceOfStock = TextEditingController();
  TextEditingController earningsPerShare = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ImageWidget(name: "priceEarningsRatio"),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: kPrimaryColor,
                  )),
              child: TextField(
                controller: marketPriceOfStock,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  border: InputBorder.none,
                  hintText: "Market price of stock",
                  hintStyle:
                      GoogleFonts.tajawal(color: kPrimaryColor, fontSize: 20),
                ),
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: kPrimaryColor,
                  )),
              child: TextField(
                controller: earningsPerShare,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  border: InputBorder.none,
                  hintText: "Earnings per share",
                  hintStyle:
                      GoogleFonts.tajawal(color: kPrimaryColor, fontSize: 20),
                ),
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(16)),
          child: TextButton(
              onPressed: (() {
                setState(() {
                  result = double.parse(marketPriceOfStock.text) /
                      double.parse(earningsPerShare.text);
                });
              }),
              child: Text(
                "calculate",
                style: GoogleFonts.tajawal(color: Colors.white, fontSize: 25),
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          result.toString(),
          style: GoogleFonts.tajawal(color: kPrimaryColor, fontSize: 25),
        ),
      ],
    );
  }
}
