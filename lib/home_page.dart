// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/create_movie.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
// }

// class _HomePageState extends ConsumerState<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff1E1E1E),
//       body: ListView.builder(
//         // itemCount: watchlist.length,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(left: 20, top: 24),
//             child: Row(
//               children: [
//                 Container(
//                   height: 150,
//                   width: 200,
//                   decoration: BoxDecoration(color: Colors.lightBlue),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 200,
//                       child: const Text(
//                         // watchlist[index].title,
//                         'Spider man',
//                         style: TextStyle(
//                             color: Color(0xffFFFFFF),
//                             fontSize: 16,
//                             fontFamily: 'Poppins',
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 4,
//                     ),
//                     Row(
//                       children: const [
//                         Icon(
//                           Icons.star_border,
//                           color: Color(0xffFF8700),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           // "${watchlist[index].rating}",
//                           '5.78',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xffFF8700)),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 4,
//                     ),
//                     Row(
//                       children: const [
//                         Icon(
//                           Icons.movie_sharp,
//                           color: Color(0xffFFFFFF),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           'Action',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xffFFFFFF)),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 4,
//                     ),
//                     Row(
//                       children: const [
//                         Icon(
//                           Icons.calendar_month_outlined,
//                           color: Color(0xffFFFFFF),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           // watchlist[index].releasedate ?? '',
//                           '2023-07-19',
//                           style: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xffFFFFFF)),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 4,
//                     ),
//                     Row(
//                       children: const [
//                         Icon(
//                           Icons.timer,
//                           color: Color(0xffFFFFFF),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           '139 minutes',
//                           style: TextStyle(
//                               fontSize: 12,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xffFFFFFF)),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Container(
//                       child: IconButton(
//                         icon: Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {},
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       child: IconButton(
//                         icon: Icon(
//                           Icons.delete_forever,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {},
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (BuildContext) => CreateMovie(),
//             ),
//           );
//         },
//         tooltip: 'Add',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
