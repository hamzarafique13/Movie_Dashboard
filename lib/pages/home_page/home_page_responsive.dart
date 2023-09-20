import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_use_riverpod/model/dbmoviemodel.dart';
import 'package:movie_app_use_riverpod/model/moviesmodel.dart';
import 'package:movie_app_use_riverpod/pages/detail_page/detail_page.dart';
import 'package:movie_app_use_riverpod/pages/home_page/home_page.dart';
import 'package:movie_app_use_riverpod/pages/search_page/search_page.dart';
import 'package:movie_app_use_riverpod/provider/popular_movie_provider.dart';
import 'package:movie_app_use_riverpod/provider/watch_list_movie_provider.dart';
import 'package:movie_app_use_riverpod/provider/toprated_movie_provider.dart';
import 'package:movie_app_use_riverpod/provider/treading_movie_provider.dart';
import 'package:movie_app_use_riverpod/provider/upcoming_movie_provider.dart';

class HomePageResponsive extends ConsumerStatefulWidget {
  const HomePageResponsive({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomePageResponsiveState();
}

class _HomePageResponsiveState extends ConsumerState<HomePageResponsive>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(treadingMovieListProvider.notifier).trendinglist();
      ref.read(upComingmoviePageProvider.notifier).upcominglist();
      ref.read(topRatedlistmoviePageProvider.notifier).topratedlist();
      ref.read(popularlistmoviePageProvider.notifier).popularlist();
      ref.read(treadingMovieListProvider.notifier).fetchMovieFromIsar();
      ref.read(topRatedlistmoviePageProvider.notifier).fetchMovieFromIsar();
      ref.read(popularlistmoviePageProvider.notifier).fetchMovieFromIsar();
      ref.read(upComingmoviePageProvider.notifier).fetchMovieFromIsar();
      ref.read(watchListmoviePageProvider.notifier).fetchWatchListIsar();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<MovieModel> treadinglist = ref.watch(treadingMovieListProvider);
    List<MovieModel> upcominglist = ref.watch(upComingmoviePageProvider);
    List<MovieModel> topratedlist = ref.watch(topRatedlistmoviePageProvider);
    List<MovieModel> popularlist = ref.watch(popularlistmoviePageProvider);
    List<DbMovieModel> watchlist =
        ref.watch(watchListmoviePageProvider).watchlist;

    final TabController _tabController = TabController(length: 4, vsync: this);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff1E1E1E),
          title: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              alignment: Alignment.topLeft,
              child: const Text(
                'What do you want to watch?',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffFFFFFF)),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 34),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: const Color(0xff1E1E1E),
              child: Container(
                height: 52,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 24, right: 24, bottom: 21),
                decoration: BoxDecoration(
                  color: const Color(0xff3A3F47),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 11, top: 15),
                          child: const Text(
                            'Search',
                            style: TextStyle(
                              color: Color(0xff67686D),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10, top: 15),
                          child: const Icon(Icons.search,
                              color: Color(0xff67686D)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 32,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 300,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: treadinglist.length,
              itemBuilder: (BuildContext context, index) {
                return Stack(
                  children: [
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(right: 20, left: 34),
                        height: 240,
                        width: 160,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          child: Column(
                            children: [
                              Image.network(
                                'https://image.tmdb.org/t/p/w500${treadinglist[index].moviesurl}',
                                scale: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailMovie(treadinglist[index]),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 25,
                      child: Text(
                        "${index + 1}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..color = const Color(0xff0296E5)
                                ..strokeWidth = 0.3,
                              fontSize: 96,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 25,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: const Color(0xff1E1E1E),
                        child: Icon(
                          Icons.bookmark,
                          color: (ref
                                  .read(watchListmoviePageProvider.notifier)
                                  .checkMovieAddOrNotToList(
                                      treadinglist[index].id))
                              ? Colors.yellow
                              : Colors.white,
                        ),
                        onTap: () {},
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 32,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: const Color(0xff3A3F47),
              controller: _tabController,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 12),
              tabs: const [
                Tab(
                  child: Text(
                    'Now playing',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Upcoming',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Top rated',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Popular',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 300, // Set the height of the TabBarView container
            child: TabBarView(
              controller: _tabController,
              children: [
                GridWidget(
                  moviesList: treadinglist,
                ),
                GridWidget(
                  moviesList: upcominglist,
                ),
                GridWidget(
                  moviesList: topratedlist,
                ),
                GridWidget(
                  moviesList: popularlist,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
