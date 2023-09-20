import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/genre_model/freezedcatagorymodel.dart';
import 'package:flutter_application_1/provider/genre_movie_provider.dart';
import 'package:flutter_application_1/provider/image_picker_provider.dart';
import 'package:flutter_application_1/provider/movie_page_provider.dart';
import 'package:flutter_application_1/services/firebase_firestorrage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../model/movie_model/freezedmoviemodel.dart';

final genrenameProvider = StateProvider<CatagoryModel?>((ref) => null);

class CreateMovie extends ConsumerStatefulWidget {
  CreateMovie({this.movie, super.key});
  DbMovieModel? movie;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateMovieState();
}

class _CreateMovieState extends ConsumerState<CreateMovie> {
  var date = DateTime.now();
  int hours = 0;
  int minutes = 0;

  void updateTime(String input, {bool isHours = false}) {
    try {
      final value = int.parse(input);
      if (isHours) {
        hours = value;
      } else {
        minutes = value;
      }
    } catch (e) {
      // Handle invalid input here
      print('Invalid input: $input');
    }
  }

  DateTime createMovieTime() {
    // final now = DateTime.now();
    return DateTime(hours, minutes);
  }

  bool isLoading = false;

  String? selectedDate;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.movie?.name ?? '';
    _ratingController.text = widget.movie?.rating ?? '';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(genreNameProvider.notifier).fetchGenreNameFirebase();
    });
  }

  datepicker(context) async {
    DateTime? userSelectedDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(5000));
    if (userSelectedDate == null) {
      return;
    } else {
      setState(() {
        date = userSelectedDate;
        selectedDate = DateFormat("MMMM dd, yyyy").format(date);
        print('Date $selectedDate');
      });
    }
  }

  void imagePickerOption() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          color: Colors.white,
          height: 250,
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Pic Image From",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Container(
                //   height: 55,
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //       pickImage(ImageSource.camera);
                //     },
                //     icon: Icon(Icons.camera),
                //     label: const Text("CAMERA"),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        Navigator.pop(context);
                        await ref.read(imageProvider.notifier).imagePicker();
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("GALLERY"),
                    )),

                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Get.back();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageStorage = ref.watch(imageProvider);
    List<CatagoryModel> genremoviename = ref.watch(genreNameProvider);
    var genreboolprovider = ref.watch(genrenameProvider);

    // List<DbMovieModel> imagepicker = ref.watch(imagepickerprovider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 144, 138, 160),
        title: const Center(
          child: Text(
            'Create Movie',
          ),
        ),
      ),
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Row(
            children: [
              Container(
                width: 500,
                margin: const EdgeInsets.only(left: 300, top: 20),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 470,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: const Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ],
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<CatagoryModel>(
                                underline: const SizedBox(),
                                value: genreboolprovider,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: [
                                  const DropdownMenuItem<CatagoryModel>(
                                    value: null,
                                    child: Text('Select a Genre'),
                                  ),
                                  ...genremoviename
                                      .map((CatagoryModel genreboolprovider) {
                                    return DropdownMenuItem<CatagoryModel>(
                                      value: genreboolprovider,
                                      child: Text(genreboolprovider.genre),
                                    );
                                  }),
                                ],
                                onChanged: (CatagoryModel? newValue) {
                                  if (newValue != null) {
                                    genreboolprovider = newValue;
                                    ref.read(genrenameProvider.notifier).state =
                                        newValue;
                                  }
                                },
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 7,
                                    offset: const Offset(1, 1),
                                    color: Colors.grey.withOpacity(0.2))
                              ],
                            ),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: _nameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _nameController.clear();
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Colors.black),
                                ),
                                labelText: 'Movie Name',
                                labelStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              onChanged: (value) {
                                _nameController.value = TextEditingValue(
                                  text: value.capitalizeFirstLetter(),
                                  selection: _nameController.selection,
                                );
                              },
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: const Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ],
                          ),
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: _ratingController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _ratingController.clear();
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                  ),
                                ),
                                labelText: 'Rating',
                                labelStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.only(left: 8),
                              height: 55,
                              // width: 1400,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat("MMMM dd, yyyy").format(date),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      datepicker(context);
                                    },
                                    icon: const Icon(Icons.date_range),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 7,
                                      offset: const Offset(1, 1),
                                      color: Colors.grey.withOpacity(0.2))
                                ],
                              ),
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 1.0)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  // suffixIcon: IconButton(
                                  //   onPressed: () {
                                  //     _nameController.clear();
                                  //   },
                                  //   icon: const Icon(Icons.clear,
                                  //       color: Colors.black),
                                  // ),
                                  labelText: 'Hours',
                                  labelStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                onChanged: (value) {
                                  updateTime(value, isHours: true);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 7,
                                      offset: const Offset(1, 1),
                                      color: Colors.grey.withOpacity(0.2))
                                ],
                              ),
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 1.0)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  // suffixIcon: IconButton(
                                  //   onPressed: () {
                                  //     _nameController.clear();
                                  //   },
                                  //   icon: const Icon(Icons.clear,
                                  //       color: Colors.black),
                                  // ),
                                  labelText: 'Minutes',
                                  labelStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                onChanged: (value) {
                                  updateTime(value);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 55,
                          width: 500,
                          child: ElevatedButton.icon(
                            onPressed: imagePickerOption,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            icon: const Icon(
                              Icons.add_a_photo_sharp,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'UPLOAD IMAGE',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 55,
                          width: 300,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                            onPressed: () async {
                              await buildShowDialog(context);

                              final firebasestorage = FireStorageService();
                              var randomid = const Uuid().v1();

                              final imageurl = await firebasestorage
                                  .uploadImage(imageStorage!, randomid);

                              DbMovieModel movie = DbMovieModel(
                                genremovie: genreboolprovider?.genre ?? '',
                                name: _nameController.text,
                                rating: _ratingController.text,
                                image: imageurl,
                                time: '$hours:${minutes.toString()}',
                                id: widget.movie == null
                                    ? const Uuid().v1()
                                    : widget.movie!.id,
                                date: date,
                              );

                              (widget.movie == null)
                                  ? ref
                                      .read(moviePageProvider.notifier)
                                      .addMovieToList(movie)
                                  : ref
                                      .read(moviePageProvider.notifier)
                                      .updatedMovie(movie);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                            child: Text(
                              (widget.movie == null)
                                  ? 'Create Movie'
                                  : "Update Movie",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ClipOval(
                          child: (imageStorage != null)
                              ? Image.memory(imageStorage,
                                  height: 300, width: 200, fit: BoxFit.cover)
                              : SizedBox(
                                  height: 300,
                                  width: 200,
                                  child: Image.network(
                                    widget.movie?.image ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                )),
                    ),
                    Positioned(
                      bottom: 140,
                      right: 90,
                      child: IconButton(
                        onPressed: imagePickerOption,
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> buildShowDialog(BuildContext context) async {
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 8), () {
          Navigator.pop(context);
        });
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
