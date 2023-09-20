import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_use_riverpod/model/dbmoviemodel.dart';
import 'package:movie_app_use_riverpod/model/moviedetailmodel.dart';
import 'package:movie_app_use_riverpod/model/moviesmodel.dart';
import 'package:movie_app_use_riverpod/provider/review_movie_provider.dart';
import 'package:movie_app_use_riverpod/provider/watch_list_movie_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ResponsiveScreen extends ConsumerStatefulWidget {
  ResponsiveScreen(this.movie, {super.key});
  MovieModel movie;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResponsiveScreenState();
}

class _ResponsiveScreenState extends ConsumerState<ResponsiveScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(reviewsListmoviePageProvider.notifier)
          .movieReviews(widget.movie.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<MovieReviews> reviewlist = ref.watch(reviewsListmoviePageProvider);
    List<DbMovieModel> watchlist =
        ref.watch(watchListmoviePageProvider).watchlist;
    final TabController _tabController = TabController(length: 3, vsync: this);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 38, right: 26, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xffFFFFFF),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text('Detail',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                InkWell(
                  child: Image.asset('assets/images/Vector.png',
                      color: (ref
                              .read(watchListmoviePageProvider.notifier)
                              .checkMovieAddOrNotToList(widget.movie.id))
                          ? Colors.yellow
                          : Colors.white),
                  onTap: () {
                    DbMovieModel dbMovie = DbMovieModel(
                        moviesurl: widget.movie.moviesurl,
                        rating: widget.movie.rating,
                        overview: widget.movie.overview,
                        releasedate: widget.movie.releasedate,
                        Uuid: widget.movie.Uuid,
                        title: widget.movie.title,
                        id: widget.movie.id);
                    if (watchlist.contains(dbMovie)) {
                      ref
                          .read(watchListmoviePageProvider.notifier)
                          .removeMovieToWatchList(dbMovie);
                      var snackBar = const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Removed from watch list",
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      ref
                          .read(watchListmoviePageProvider.notifier)
                          .addToWatchList(dbMovie);

                      ref
                          .read(watchListmoviePageProvider.notifier)
                          .fetchWatchListIsar();
                      var snackBar = const SnackBar(
                        backgroundColor: Colors.black,
                        content: Text(
                          "Added to watch list",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${(widget.movie.backdropurl)}',
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 160, left: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${(widget.movie.moviesurl)}',
                            scale: 5,
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        margin: const EdgeInsets.only(top: 180, left: 10),
                        child: Text(
                          "${(widget.movie.title)}",
                          style: const TextStyle(
                              color: Color(0xffFFFFFF),
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 120, bottom: 55, right: 8),
                    // height: 24,
                    // width: 54,
                    decoration: BoxDecoration(
                        color: const Color(0xff252836),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 2.5, right: 2.5, top: 3, bottom: 3),
                      child: Row(
                        children: [
                          const Icon(Icons.star_border_outlined,
                              color: Color(0xffFF8700)),
                          Text(
                            "${(widget.movie.rating)}",
                            style: const TextStyle(
                              color: Color(0xffFF8700),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Color(0xffFFFFFF),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${(widget.movie.releasedate)}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFFFF)),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 16,
                width: 1,
                color: const Color(0xff696974),
              ),
              const SizedBox(
                width: 10,
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
                    '148 Minutes',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFFFF)),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 16,
                width: 1,
                color: const Color(0xff696974),
              ),
              const SizedBox(
                width: 10,
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
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFFFF)),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: const Color(0xff3A3F47),
              controller: _tabController,
              labelPadding: const EdgeInsets.symmetric(horizontal: 12),
              isScrollable: true,
              tabs: const [
                Tab(
                  child: Text(
                    'About Movie',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFFFFFF)),
                  ),
                ),
                Tab(
                  child: Text(
                    'Reviews',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFFFFFF)),
                  ),
                ),
                Tab(
                  child: Text(
                    'Cast',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFFFFFF)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 29, right: 29, top: 24),
                        child: Text(
                          // "${(widget.movie.overview)}",
                          '${(widget.movie.overview)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: (reviewlist.isEmpty)
                      ? const Center(
                          child: Text(
                            'No Reviews Found',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color(0xffEBEBEF)),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: reviewlist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 34, top: 18, right: 24, bottom: 12),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${(reviewlist[index].author.image)}',
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Container(
                                        child: Text(
                                          "${(reviewlist[index].author.rating ?? "")}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                              color: Color(0xff0296E5)),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text(
                                          "${(reviewlist[index].author.name)}",
                                          style: const TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: 270,
                                        child: Text(
                                          reviewlist[index].contant ?? '',
                                          style: const TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                GridView.builder(
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 39, top: 36, right: 51),
                      child: Column(
                        children: [
                          Container(
                            child: Image.asset('assets/images/cast1.png'),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Container(
                            child: const Text(
                              'Tom Holland',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffFFFFFF)),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
