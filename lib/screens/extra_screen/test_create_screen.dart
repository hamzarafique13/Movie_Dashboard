// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/genre_model/freezedcatagorymodel.dart';
// import 'package:flutter_application_1/provider/genre_movie_provider.dart';
// import 'package:flutter_application_1/provider/image_picker_provider.dart';
// import 'package:flutter_application_1/provider/movie_page_provider.dart';
// import 'package:flutter_application_1/services/firebase_firestorrage.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';

// import '../../model/movie_model/freezedmoviemodel.dart';

// final genrenameboolProvider = StateProvider<CatagoryModel?>((ref) => null);

// class CreateMovie extends ConsumerStatefulWidget {
//   CreateMovie({this.movie, super.key});
//   DbMovieModel? movie;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CreateMovieState();
// }

// class _CreateMovieState extends ConsumerState<CreateMovie> {
//   var date = DateTime.now();

//   bool isLoading = false;

//   String? selectedDate;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ratingController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _nameController.text = widget.movie?.name ?? '';
//     _ratingController.text = widget.movie?.rating ?? '';
//   }

//   datepicker(context) async {
//     DateTime? userSelectedDate = await showDatePicker(
//         context: context,
//         initialDate: date,
//         firstDate: DateTime(2000),
//         lastDate: DateTime(5000));
//     if (userSelectedDate == null) {
//       return;
//     } else {
//       setState(() {
//         date = userSelectedDate;
//         selectedDate = DateFormat("MMMM dd, yyyy").format(date);
//         print('Date $selectedDate');
//       });
//     }
//   }

//   // bool isLoading = true;
//   // File? pickedImage;
//   // Uint8List webImage = Uint8List(8);

//   void imagePickerOption() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(10.0),
//           topRight: Radius.circular(10.0),
//         ),
//         child: Container(
//           color: Colors.white,
//           height: 250,
//           width: 500,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Text(
//                   "Pic Image From",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 // Container(
//                 //   height: 55,
//                 //   child: ElevatedButton.icon(
//                 //     onPressed: () {
//                 //       pickImage(ImageSource.camera);
//                 //     },
//                 //     icon: Icon(Icons.camera),
//                 //     label: const Text("CAMERA"),
//                 //   ),
//                 // ),
//                 // const SizedBox(
//                 //   height: 10,
//                 // ),
//                 SizedBox(
//                     height: 55,
//                     child: ElevatedButton.icon(
//                       onPressed: () async {
//                         Navigator.pop(context);
//                         await ref.read(imageProvider.notifier).imagePicker();
//                       },
//                       icon: const Icon(Icons.image),
//                       label: const Text("GALLERY"),
//                     )),

//                 const SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                   height: 55,
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       // Get.back();
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.close),
//                     label: const Text("CANCEL"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final imageStorage = ref.watch(imageProvider);
//     List<CatagoryModel> genremoviename = ref.watch(genreNameProvider);
//     final genreboolprovider = ref.watch(genrenameboolProvider);

//     // List<DbMovieModel> imagepicker = ref.watch(imagepickerprovider);
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text(
//         'Create Movie',
//       )),
//       backgroundColor: Colors.black12,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return (constraints.maxWidth < 500)
//                 ? SingleChildScrollView(
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 370,
//                           margin: const EdgeInsets.only(top: 20, left: 10),
//                           alignment: Alignment.center,
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     boxShadow: [
//                                       BoxShadow(
//                                           blurRadius: 10,
//                                           spreadRadius: 7,
//                                           offset: const Offset(1, 1),
//                                           color: Colors.grey.withOpacity(0.2))
//                                     ],
//                                   ),
//                                   child: TextField(
//                                     style: const TextStyle(color: Colors.black),
//                                     controller: _nameController,
//                                     decoration: InputDecoration(
//                                         filled: true,
//                                         fillColor: Colors.white,
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide: const BorderSide(
//                                                 color: Colors.black,
//                                                 width: 1.0)),
//                                         enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide: const BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1.0)),
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         suffixIcon: IconButton(
//                                           onPressed: () {
//                                             _nameController.clear();
//                                           },
//                                           icon: const Icon(Icons.clear,
//                                               color: Colors.black),
//                                         ),
//                                         labelText: 'Movie Name',
//                                         labelStyle: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black)),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     boxShadow: [
//                                       BoxShadow(
//                                           blurRadius: 10,
//                                           spreadRadius: 7,
//                                           offset: const Offset(1, 1),
//                                           color: Colors.grey.withOpacity(0.2))
//                                     ],
//                                   ),
//                                   child: TextField(
//                                     style: const TextStyle(color: Colors.black),
//                                     controller: _ratingController,
//                                     keyboardType: TextInputType.number,
//                                     decoration: InputDecoration(
//                                         filled: true,
//                                         fillColor: Colors.white,
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide: const BorderSide(
//                                                 color: Colors.black,
//                                                 width: 1.0)),
//                                         enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide: const BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1.0)),
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         suffixIcon: IconButton(
//                                           onPressed: () {
//                                             _ratingController.clear();
//                                           },
//                                           icon: const Icon(
//                                             Icons.clear,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         labelText: 'Reating',
//                                         labelStyle: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black)),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Container(
//                                       padding: const EdgeInsets.only(left: 8),
//                                       height: 55,
//                                       // width: 1400,
//                                       decoration: BoxDecoration(
//                                           boxShadow: [
//                                             BoxShadow(
//                                                 blurRadius: 10,
//                                                 spreadRadius: 7,
//                                                 offset: const Offset(1, 1),
//                                                 color: Colors.grey
//                                                     .withOpacity(0.2))
//                                           ],
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(6)),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             DateFormat("MMMM dd, yyyy")
//                                                 .format(date),
//                                             style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                           IconButton(
//                                             onPressed: () {
//                                               datepicker(context);
//                                             },
//                                             icon: const Icon(Icons.date_range),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         boxShadow: [
//                                           BoxShadow(
//                                               blurRadius: 10,
//                                               spreadRadius: 7,
//                                               offset: const Offset(1, 1),
//                                               color:
//                                                   Colors.grey.withOpacity(0.2))
//                                         ],
//                                       ),
//                                       height: 55,
//                                       child: ElevatedButton.icon(
//                                           onPressed: imagePickerOption,
//                                           style: ElevatedButton.styleFrom(
//                                               backgroundColor: Colors.white),
//                                           icon: const Icon(
//                                             Icons.add_a_photo_sharp,
//                                             color: Colors.black,
//                                           ),
//                                           label: const Text(
//                                             'UPLOAD IMAGE',
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           )),
//                                     ),
//                                   ),
//                                   Align(
//                                     alignment: Alignment.center,
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           margin:
//                                               const EdgeInsets.only(right: 10),
//                                           decoration: BoxDecoration(
//                                             boxShadow: [
//                                               BoxShadow(
//                                                   blurRadius: 10,
//                                                   spreadRadius: 7,
//                                                   offset: const Offset(1, 1),
//                                                   color: Colors.grey
//                                                       .withOpacity(0.2))
//                                             ],
//                                             border: Border.all(
//                                                 color: Colors.white, width: 3),
//                                             borderRadius:
//                                                 const BorderRadius.all(
//                                               Radius.circular(10),
//                                             ),
//                                           ),
//                                           child: ClipOval(
//                                               child: (imageStorage != null)
//                                                   ? Image.memory(imageStorage,
//                                                       height: 180,
//                                                       width: 150,
//                                                       fit: BoxFit.cover)
//                                                   : SizedBox(
//                                                       width: 150,
//                                                       height: 180,
//                                                       child: Image.network(
//                                                         widget.movie?.image ??
//                                                             "https://www.google.com/url?sa=i&url=https%3A%2F%2Fin.pinterest.com%2Fpin%2Fwhatsapp-dp-download-458-images-pics-wallpaper--1012184084973119192%2F&psig=AOvVaw3-X34GE4FtK_m6LE8weOP2&ust=1693984735006000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCNC6voX3koEDFQAAAAAdAAAAABAE",
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     )
//                                               // : Center(
//                                               //     child: CircularProgressIndicator(),
//                                               //   ),
//                                               ),
//                                         ),
//                                         Positioned(
//                                           bottom: 70,
//                                           right: 65,
//                                           child: IconButton(
//                                             onPressed: imagePickerOption,
//                                             icon: const Icon(
//                                               Icons.add_a_photo_outlined,
//                                               color: Colors.white,
//                                               size: 30,
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 30,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: SizedBox(
//                                   height: 55,
//                                   width: double.infinity,
//                                   child: TextButton(
//                                       style: TextButton.styleFrom(
//                                         backgroundColor: Colors.lightBlueAccent,
//                                       ),
//                                       onPressed: () async {
//                                         await buildShowDialog(context);
//                                         final firebasestorage =
//                                             FireStorageService();
//                                         var randomid = const Uuid().v1();
//                                         final imageurl =
//                                             await firebasestorage.uploadImage(
//                                                 imageStorage!, randomid);
//                                         DbMovieModel movie = DbMovieModel(
//                                           genremovie:
//                                               genreboolprovider?.genre ?? "",
//                                           name: _nameController.text,
//                                           rating: _ratingController.text,
//                                           image: imageurl,
//                                           id: widget.movie == null
//                                               ? const Uuid().v1()
//                                               : widget.movie!.id,
//                                           date: date,
//                                         );

//                                         (widget.movie == null)
//                                             ? ref
//                                                 .read(
//                                                     moviePageProvider.notifier)
//                                                 .addMovieToList(movie)
//                                             : ref
//                                                 .read(
//                                                     moviePageProvider.notifier)
//                                                 .updatedMovie(movie);
//                                         // ignore: use_build_context_synchronously
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text(
//                                         (widget.movie == null)
//                                             ? 'Create Movie'
//                                             : "Update Movie",
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       )),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : Row(
//                     children: [
//                       Container(
//                         width: 500,
//                         margin: const EdgeInsets.only(left: 300, top: 20),
//                         alignment: Alignment.center,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   width: 470,
//                                   height: 55,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Colors.white,
//                                     boxShadow: [
//                                       BoxShadow(
//                                           blurRadius: 10,
//                                           spreadRadius: 7,
//                                           offset: const Offset(1, 1),
//                                           color: Colors.grey.withOpacity(0.2))
//                                     ],
//                                   ),
//                                   child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: DropdownButton<CatagoryModel>(
//                                         underline: SizedBox(),
//                                         value: genremoviename.isNotEmpty
//                                             ? genremoviename[0]
//                                             : null, // Set an initial value or null
//                                         icon: const Icon(
//                                             Icons.keyboard_arrow_down),
//                                         items: genremoviename.map(
//                                             (CatagoryModel genreboolprovider) {
//                                           return DropdownMenuItem<
//                                               CatagoryModel>(
//                                             value: genreboolprovider,
//                                             child:
//                                                 Text(genreboolprovider.genre),
//                                           );
//                                         }).toList(),
//                                         onChanged: (CatagoryModel? newValue) {
//                                           ref
//                                               .read(genrenameboolProvider
//                                                   .notifier)
//                                               .state = newValue;
//                                         },
//                                       )),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     boxShadow: [
//                                       BoxShadow(
//                                           blurRadius: 10,
//                                           spreadRadius: 7,
//                                           offset: const Offset(1, 1),
//                                           color: Colors.grey.withOpacity(0.2))
//                                     ],
//                                   ),
//                                   child: TextField(
//                                     style: const TextStyle(color: Colors.black),
//                                     controller: _nameController,
//                                     decoration: InputDecoration(
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       focusedBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: const BorderSide(
//                                               color: Colors.black, width: 2.0)),
//                                       enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: const BorderSide(
//                                               color: Colors.white, width: 1.0)),
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10)),
//                                       suffixIcon: IconButton(
//                                         onPressed: () {
//                                           _nameController.clear();
//                                         },
//                                         icon: const Icon(Icons.clear,
//                                             color: Colors.black),
//                                       ),
//                                       labelText: 'Movie Name',
//                                       labelStyle: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     boxShadow: [
//                                       BoxShadow(
//                                           blurRadius: 10,
//                                           spreadRadius: 7,
//                                           offset: const Offset(1, 1),
//                                           color: Colors.grey.withOpacity(0.2))
//                                     ],
//                                   ),
//                                   child: TextField(
//                                     style: const TextStyle(color: Colors.black),
//                                     controller: _ratingController,
//                                     keyboardType: TextInputType.number,
//                                     decoration: InputDecoration(
//                                         filled: true,
//                                         fillColor: Colors.white,
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide: const BorderSide(
//                                                 color: Colors.black,
//                                                 width: 2.0)),
//                                         enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide: const BorderSide(
//                                                 color: Colors.white,
//                                                 width: 1.0)),
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         suffixIcon: IconButton(
//                                           onPressed: () {
//                                             _ratingController.clear();
//                                           },
//                                           icon: const Icon(
//                                             Icons.clear,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         labelText: 'Rating',
//                                         labelStyle: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black)),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Container(
//                                       padding: const EdgeInsets.only(left: 8),
//                                       height: 55,
//                                       // width: 1400,
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(6)),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             DateFormat("MMMM dd, yyyy")
//                                                 .format(date),
//                                             style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                           IconButton(
//                                             onPressed: () {
//                                               datepicker(context);
//                                             },
//                                             icon: const Icon(Icons.date_range),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: SizedBox(
//                                   height: 55,
//                                   width: 500,
//                                   child: ElevatedButton.icon(
//                                     onPressed: imagePickerOption,
//                                     style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.white),
//                                     icon: const Icon(
//                                       Icons.add_a_photo_sharp,
//                                       color: Colors.black,
//                                     ),
//                                     label: const Text(
//                                       'UPLOAD IMAGE',
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: SizedBox(
//                                   height: 55,
//                                   width: double.infinity,
//                                   child: TextButton(
//                                     style: TextButton.styleFrom(
//                                       backgroundColor: Colors.lightBlueAccent,
//                                     ),
//                                     onPressed: () async {
//                                       await buildShowDialog(context);

//                                       final firebasestorage =
//                                           FireStorageService();
//                                       var randomid = const Uuid().v1();

//                                       final imageurl = await firebasestorage
//                                           .uploadImage(imageStorage!, randomid);

//                                       DbMovieModel movie = DbMovieModel(
//                                         genremovie:
//                                             genreboolprovider?.genre ?? '',
//                                         name: _nameController.text,
//                                         rating: _ratingController.text,
//                                         image: imageurl,
//                                         id: widget.movie == null
//                                             ? const Uuid().v1()
//                                             : widget.movie!.id,
//                                         date: date,
//                                       );

//                                       (widget.movie == null)
//                                           ? ref
//                                               .read(moviePageProvider.notifier)
//                                               .addMovieToList(movie)
//                                           : ref
//                                               .read(moviePageProvider.notifier)
//                                               .updatedMovie(movie);
//                                       // ignore: use_build_context_synchronously
//                                       Navigator.pop(context);
//                                     },
//                                     child: Text(
//                                       (widget.movie == null)
//                                           ? 'Create Movie'
//                                           : "Update Movie",
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 40,
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Stack(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 border:
//                                     Border.all(color: Colors.white, width: 3),
//                                 borderRadius: const BorderRadius.all(
//                                   Radius.circular(10),
//                                 ),
//                               ),
//                               child: ClipOval(
//                                   child: (imageStorage != null)
//                                       ? Image.memory(imageStorage,
//                                           height: 300,
//                                           width: 200,
//                                           fit: BoxFit.cover)
//                                       : SizedBox(
//                                           height: 300,
//                                           width: 200,
//                                           child: Image.network(
//                                             widget.movie?.image ?? '',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         )),
//                             ),
//                             Positioned(
//                               bottom: 140,
//                               right: 90,
//                               child: IconButton(
//                                 onPressed: imagePickerOption,
//                                 icon: const Icon(
//                                   Icons.add_a_photo_outlined,
//                                   color: Colors.white,
//                                   size: 30,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }

// Future<void> buildShowDialog(BuildContext context) async {
//   await showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         Future.delayed(const Duration(seconds: 8), () {
//           Navigator.pop(context);
//         });
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       });
// }
