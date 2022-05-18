import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:privatechat/widgets/preferences/preferenceScreenButtons.dart';
import 'package:privatechat/widgets/preferences/countries_list.dart';
import 'package:privatechat/widgets/preferences/partners_sexuality.dart';
import 'package:privatechat/widgets/preferences/partners_gender.dart';

class PreferenceWidget extends StatefulWidget {
  @override
  State<PreferenceWidget> createState() => _PreferenceWidgetState();
}

class _PreferenceWidgetState extends State<PreferenceWidget> {
  String dropDownValue = 'India';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10),
      height: height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Choose the country you want',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: Color(0xffFE9AAB),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'to search your partner in',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: Color(0xffFE9AAB),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: height * 0.045,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<dynamic>(
                    style: GoogleFonts.poppins(
                      color: Color(0xffFE9AAB),
                    ),
                    buttonPadding: EdgeInsets.only(left: 20),
                    dropdownMaxHeight: height * 0.3,
                    dropdownDecoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Color(0xffFE9AAB),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    buttonDecoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Color(0xffFE9AAB),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    hint: Text(
                      'Select Country',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xffFE9AAB),
                      ),
                    ),
                    items: countriesList,
                    value: dropDownValue,
                    onChanged: (value) {
                      setState(() {
                        dropDownValue = value as String;
                      });
                    },
                    buttonHeight: height * 0.045,
                    buttonWidth: 200,
                    itemHeight: height * 0.045,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xffFE9AAB),
                    ),
                    iconOnClick: Icon(
                      Icons.keyboard_arrow_up,
                      color: Color(0xffFE9AAB),
                    ),
                  ),
                ),
                SizedBox(
                  width: width / 25,
                ),
                Container(
                  height: height * 0.045,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.5,
                      color: const Color(0xffFE9AAB),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: GestureDetector(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.gps_fixed,
                            color: const Color(0xffFF647C),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Nearby',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xffFF647C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                preferenceScreenButtons(
                  height: height,
                  width: width,
                  text: 'Nearby',
                ),
                SizedBox(
                  width: width / 25,
                ),
                preferenceScreenButtons(
                  height: height,
                  width: width,
                  text: 'Video Games',
                ),
                SizedBox(
                  width: width / 25,
                ),
                preferenceScreenButtons(
                    height: height, width: width, text: 'Memes')
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              'Choose Partner\'s Gender',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Color(
                    0xffFE9AAB,
                  ),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 35,
            ),
            Partners_gender(height: height, width: width),
            SizedBox(
              height: 40,
            ),
            Text(
              'Choose Partner\'s sexuality',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Color(
                    0xffFE9AAB,
                  ),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            partners_sexuality(height: height, width: width),
            SizedBox(height: 30),
            SizedBox(
              height: height / 20,
              width: width / 2.35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffff647c),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  print(height);
                  print(width);
                },
                child: Text(
                  'Okay',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
