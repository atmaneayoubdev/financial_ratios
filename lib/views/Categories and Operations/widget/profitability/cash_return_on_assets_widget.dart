import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants.dart';
import '../image_widget.dart';

class CashReturnOnAssetsWidget extends StatefulWidget {
  const CashReturnOnAssetsWidget({Key? key}) : super(key: key);

  @override
  State<CashReturnOnAssetsWidget> createState() =>
      _CashReturnOnAssetsWidgetState();
}

class _CashReturnOnAssetsWidgetState extends State<CashReturnOnAssetsWidget> {
  double result = 0;
  TextEditingController cfo = TextEditingController();
  TextEditingController averageTotaleAssset = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ImageWidget(name: "cashReturnOnAsset"),
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
                controller: cfo,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  border: InputBorder.none,
                  hintText: "CFO",
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
                controller: averageTotaleAssset,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  border: InputBorder.none,
                  hintText: "Average total assets",
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
                  result = double.parse(cfo.text) /
                      double.parse(averageTotaleAssset.text);
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
