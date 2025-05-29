// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
// import 'package:soma_app/features/playlist/controller/playlist_screen_controller.dart';
//
// import '../../../core/constants/assets.dart';
// import '../../../core/constants/color_constant.dart';
// import '../../../core/global/custom_image_view.dart';
// import '../../video_play/controller/video_play_controller.dart';
// import '../../video_play/screen/video_play_screen.dart';
// import '../controller/pain_tracker_controller.dart';
// import '../modal/get_pain_tracker_modal.dart';
//
// class FirstViewTile extends StatelessWidget {
//   final PainTrackerScreenController? controller;
//   final String? image;
//   final PainData? data;
//   final String? bgImages;
//   const FirstViewTile(
//       {Key? key, this.controller, this.image, this.data, this.bgImages})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (GetInstance().isRegistered<VideoPLayController>()) {
//           Get.delete<VideoPLayController>();
//         }
//         pushWithNavBar(
//           context,
//           MaterialPageRoute(
//             builder: (context) => VideoPlayScreen(
//               title: data?.title ?? '',
//               videos: data?.videos ?? [],
//             ),
//           ),
//         ).then((value) {
//           // controller?.getPainTrackerApi(false);
//         });
//       },
//       child: Container(
//         width: 265,
//         height: 288,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             // image: AssetImage(image ?? ''),
//             image: data?.images != null
//                 ? NetworkImage(data?.images ?? "")
//                 : AssetImage(bgImages ?? ''),
//           ),
//         ),
//         padding: const EdgeInsets.only(
//           left: 20,
//           right: 20,
//           top: 20,
//           bottom: 15,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const CustomImageView(
//                   imagePath: AssetIcons.heartWhiteIcons,
//                   width: 20,
//                   height: 20,
//                   fit: BoxFit.cover,
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   // '140 going',
//                   '${data?.likeCount ?? 0} going',
//                   style: GoogleFonts.openSans(
//                     fontSize: 15,
//                     color: AppColorConstant.white,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Text(
//               // 'Exploring the Breath',
//               data?.title ?? '',
//               style: GoogleFonts.openSans(
//                 fontSize: 16,
//                 color: AppColorConstant.white,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             const SizedBox(height: 5),
//             data?.totalDuration != null
//                 ? Text(
//                     // '10 min Beginner',
//                     '${formatDuration(data?.totalDuration ?? "")} Beginner',
//                     style: GoogleFonts.openSans(
//                       fontSize: 15,
//                       color: AppColorConstant.white,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   )
//                 : const SizedBox(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 (data?.videos ?? []).isEmpty
//                     ? const SizedBox(
//                         width: 18,
//                         height: 18,
//                       )
//                     : (data?.videos ?? []).isNotEmpty &&
//                             (data?.videos ?? [])[0].planType == 'free'
//                         ? const SizedBox(
//                             width: 18,
//                             height: 18,
//                           )
//                         : const CustomImageView(
//                             imagePath: AssetIcons.lockIcon,
//                             width: 18,
//                             height: 18,
//                             fit: BoxFit.cover,
//                           ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
