import 'package:flutter/material.dart';
import 'package:fox_note_app/model/category.dart';
import 'package:fox_note_app/model/note.dart';



// class CategoryCards extends StatelessWidget {
//   final int? selectedIndex;
//   final Function(int)? onPageChanged;
//   final PageController? controller;
//   const CategoryCards(
//       {Key? key, this.selectedIndex, this.onPageChanged, this.controller})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 110,
//       child: Column(
//         children: [
//           Expanded(
//             child: PageView(
//               controller: controller,
//               pageSnapping: true,
//               onPageChanged: onPageChanged,
//               children: List.generate(
//                   categoryList.length,
//                   (i) => Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           alignment: Alignment.center,
//                           child: Text(
//                             categoryList[i].name!,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w800, fontSize: 24),
//                           ),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(8)),
//                         ),
//                       )),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//                 categoryList.length,
//                 (i) => Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 500),
//                         color: selectedIndex == i ? Colors.green : Colors.grey,
//                         height: 3,
//                         width: selectedIndex == i ? 10 : 4,
//                       ),
//                     )),
//           ),
//         ],
//       ),
//     );
//   }
// }
