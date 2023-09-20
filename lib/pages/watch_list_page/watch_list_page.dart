import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_use_riverpod/model/dbmoviemodel.dart';
import 'package:movie_app_use_riverpod/model/moviesmodel.dart';
import 'package:movie_app_use_riverpod/pages/bottom_bar_page/bottom_bar_page.dart';
import 'package:movie_app_use_riverpod/provider/watch_list_movie_provider.dart';

class WatchPage extends ConsumerStatefulWidget {
  const WatchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WatchPageState();
}

class _WatchPageState extends ConsumerState<WatchPage> {
  @override
  Widget build(BuildContext context) {
    List<DbMovieModel> watchlist =
        ref.watch(watchListmoviePageProvider).watchlist;
    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 38, right: 18, bottom: 10),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                ),
                const Text('Watch list',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600)),
                Consumer(
                  builder: (context, ref, child) {
                    return PopupMenuButton(
                      offset: Offset(0, 25),
                      shadowColor: const Color(0xffFFFFFF),
                      color: const Color(0xff1E1E1E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.sort,
                        color: Color(0xffFFFFFF),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: const Text(
                            'Top rating',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          onTap: () {
                            ref
                                .read(watchListmoviePageProvider.notifier)
                                .sortDecsendRatingWatchList();
                          },
                        ),
                        PopupMenuItem(
                          child: const Text(
                            'Low rating',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          onTap: () {
                            ref
                                .read(watchListmoviePageProvider.notifier)
                                .sortAccsendingRatingWatchList();
                          },
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: (watchlist.isEmpty)
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/images/group.png',
                                color: const Color(0xff0296E5),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'There is no movie yet!',
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
                : Consumer(
                    builder: (context, ref, child) => ListView.builder(
                      itemCount: watchlist.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, top: 24),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${watchlist[index].moviesurl}',
                                  scale: 5,
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
                                    width: 200,
                                    child: Text(
                                      watchlist[index].title,
                                      style: const TextStyle(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
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
                                        "${watchlist[index].rating}",
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
                                        watchlist[index].releasedate ?? '',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
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
          ),
        ],
      ),
    );
  }
}
