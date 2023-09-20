import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/genre_model/freezedcatagorymodel.dart';
import 'package:flutter_application_1/provider/genre_movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class CreateGenreMovies extends ConsumerStatefulWidget {
  CreateGenreMovies({this.genrename, super.key});
  CatagoryModel? genrename;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateGenreMoviesState();
}

final TextEditingController _ganaranameController = TextEditingController();

class _CreateGenreMoviesState extends ConsumerState<CreateGenreMovies> {
  @override
  void initState() {
    super.initState();
    _ganaranameController.text = widget.genrename?.genre ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 200),
          width: 500,
          child: Column(
            children: [
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
                    controller: _ganaranameController,
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
                          _ganaranameController.clear();
                        },
                        icon: const Icon(Icons.clear, color: Colors.black),
                      ),
                      labelText: 'Genre Name',
                      labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
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
                      // var randomid = const Uuid().v1();
                      CatagoryModel genermovie = CatagoryModel(
                        genre: _ganaranameController.text,
                        id: widget.genrename == null
                            ? const Uuid().v1()
                            : widget.genrename?.id ?? const Uuid().v1(),
                      );

                      (widget.genrename == null)
                          ? ref
                              .read(genreNameProvider.notifier)
                              .addGeneraNameToList(genermovie)
                          : ref
                              .read(genreNameProvider.notifier)
                              .updatedGenreName(genermovie);
                      Navigator.pop(context);
                    },
                    child: Text(
                      (widget.genrename == null)
                          ? 'Create Genre'
                          : "Update Genre",
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
    );
  }
}
