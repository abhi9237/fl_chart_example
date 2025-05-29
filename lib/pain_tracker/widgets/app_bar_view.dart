import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/color_constant.dart';


class PainTrackerAppBarView extends StatelessWidget {

  const PainTrackerAppBarView({super.key,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: size.height * 0.15,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //       color: AppColorConstant.lightGrey.withOpacity(0.1),
        //       offset: const Offset(0, 2))
        // ],
      ),
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: 60,
            color: Colors.white,
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   top: 20,
          //   child: SafeArea(
          //     child: CommonDrawerButton(
          //       scaffoldKey: scaffoldKey ?? GlobalKey<SliderDrawerState>(),
          //     ),
          //   ),
          // ),
          Positioned(
            left: 0,
            right: 0,
            bottom: size.height * 0.005,
            child: Text(
              'Fl Chart Example',
              style: GoogleFonts.openSans(
                fontSize: 23,
                color: AppColorConstant.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
