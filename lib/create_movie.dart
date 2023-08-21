import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/provider/image_picker_provider.dart';
import 'package:flutter_application_1/provider/movie_page_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'model/freezedmoviemodel.dart';

class CreateMovie extends ConsumerStatefulWidget {
  CreateMovie({this.movie, super.key});
  DbMovieModel? movie;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateMovieState();
}

class _CreateMovieState extends ConsumerState<CreateMovie> {
  var date = DateTime.now();

  String? imageurl;
  String? selectedDate;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ratingController = TextEditingController();

  void initState() {
    super.initState();
    _nameController.text = widget.movie?.name ?? '';
    _ratingController.text = widget.movie?.rating ?? '';
    _titleController.text = widget.movie?.title ?? '';
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

  // File? pickedImage;
  // Uint8List webImage = Uint8List(8);

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
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
                  Container(
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          Navigator.pop(context);
                          imageurl = await ref
                              .read(imageProvider.notifier)
                              .imagePicker();
                        },
                        icon: const Icon(Icons.image),
                        label: const Text("GALLERY"),
                      )),

                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                        // Navigator.pop(context);
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageStorage = ref.watch(imageProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Create Movie')),
      backgroundColor: Colors.black,
      body: Row(
        children: [
          Container(
            width: 500,
            margin: EdgeInsets.only(left: 300, top: 20),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _titleController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _nameController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          hintText: 'Title',
                          hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  // margin: const EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _nameController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          hintText: 'Movie Name',
                          hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _ratingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _ratingController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        hintText: 'Reating',
                        hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 8),
                        height: 55,
                        // width: 1400,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                '${DateFormat("MMMM dd, yyyy").format(date)}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
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
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55,
                    child: ElevatedButton.icon(
                        onPressed: imagePickerOption,
                        icon: const Icon(Icons.add_a_photo_sharp),
                        label: const Text('UPLOAD IMAGE')),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        var randomid = Uuid().v1();
                        DbMovieModel movie = DbMovieModel(
                          title: _titleController.text,
                          name: _nameController.text,
                          rating: _ratingController.text,
                          image: imageurl!,
                          // id: Uuid().v1(),
                          id: randomid,
                          //widget.movie == null
                          // Uuid().v1(),
                          // widget.movie!.id,
                          date: date,
                        );

                        // (movie == null)
                        ref
                            .read(moviepageProvider.notifier)
                            .addMovieToList(movie);
                        ref
                            .read(moviepageProvider.notifier)
                            .updatedMovie(movie);
                        Navigator.pop(context);
                      },
                      child: Text(
                        (widget.movie == null)
                            ? 'Create Movie'
                            : "Update Movie",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
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
                    border: Border.all(color: Colors.indigo, width: 3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ClipOval(
                      child: (imageurl != null)
                          ? Image.memory(imageStorage!,
                              height: 300, width: 200, fit: BoxFit.cover)
                          : Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
                              height: 300,
                              width: 200,
                              fit: BoxFit.cover,
                            )
                      // : Center(
                      //     child: CircularProgressIndicator(),
                      //   ),
                      ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: imagePickerOption,
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
