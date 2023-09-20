import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_use_riverpod/model/moviesmodel.dart';
import 'package:movie_app_use_riverpod/pages/bottom_bar_page/bottom_bar_page.dart';
import 'package:movie_app_use_riverpod/pages/detail_page/detail_page.dart';
import 'package:movie_app_use_riverpod/provider/search_movie_page.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

var searchcontroller = TextEditingController();

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    List<MovieModel> searchlist = ref.watch(searchListmoviePageProvider);

    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 24, top: 38, right: 28, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xffFFFFFF),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                ),
                const Text('Search',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
                const Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xffFFFFFF),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 29, right: 15),
            child: TextField(
              style: TextStyle(color: Color(0xffFFFFFF)),
              controller: searchcontroller,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xff3A3F47),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xff67686D),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Color(0xff67686D),
                    fontFamily: 'Poppins',
                  )),
              onChanged: (value) {
                ref
                    .read(searchListmoviePageProvider.notifier)
                    .searchList(value);
              },
            ),
          ),
          Expanded(
            child: (searchlist.isEmpty)
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/vector1.png',
                            color: const Color(0xffFF8700),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'we are sorry, we can not find the movie :(',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color(0xffEBEBEF)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: searchlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, top: 24),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://image.tmdb.org/t/p/w500${searchlist[index].moviesurl}",
                                  width: 95,
                                  height: 120,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailMovie(
                                      searchlist[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 250,
                                  child: Text(
                                    searchlist[index].title,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xffFFFFFF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_border,
                                      color: Color(0xffFF8700),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${searchlist[index].rating}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffFF8700)),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.movie_sharp,
                                      color: Color(0xffFFFFFF),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Action',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffFFFFFF)),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Color(0xffFFFFFF),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      searchlist[index].releasedate ?? '',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffFFFFFF)),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.timer,
                                      color: Color(0xffFFFFFF),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '139 minutes',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffFFFFFF)),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
