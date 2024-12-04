import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/movie/models/movie_model.dart';
import 'package:movie_app/movie/providers/movie_get_discover_provider.dart';
import 'package:movie_app/movie/providers/movie_get_now_playing_provider.dart';
import 'package:movie_app/movie/providers/movie_get_top_rated_provider.dart';
import 'package:movie_app/widget/item_movie_widget.dart';
import 'package:provider/provider.dart';

enum TypeMovie { discover, topRated, nowPlaying  }

class MoviePaginationPage extends StatefulWidget {
  const MoviePaginationPage({super.key, required this.type});

  final TypeMovie type;

  @override
  State<MoviePaginationPage> createState() => _MoviePaginationPageState();
}

class _MoviePaginationPageState extends State<MoviePaginationPage> {
  final PagingController<int, MovieModel> _pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      switch (widget.type) {
        case TypeMovie.discover:
          context.read<MovieGetDiscoverProvider>().getDiscoverWithPaging(
              context,
              pagingController: _pagingController,
              page: pageKey);

          break;
        case TypeMovie.topRated:
          context.read<MovieGetTopRatedProvider>().getTopRatedWithPaging(
              context,
              pagingController: _pagingController,
              page: pageKey);

          break;
        case TypeMovie.nowPlaying:
          context.read<MovieGetNowPlayingProvider>().getNowPlayingPaging(
              context,
              pagingController: _pagingController,
              page: pageKey);

          break;  
      }

      context.read<MovieGetDiscoverProvider>().getDiscoverWithPaging(context,
          pagingController: _pagingController, page: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (_) {
          switch (widget.type) {
            case TypeMovie.discover:
              return Text('Discover Movies');
            case TypeMovie.topRated:
              return Text('Top Rated Movies');
            case TypeMovie.nowPlaying:
              return Text('Now Playing Movies');
          }
        }),
      ),
      body: PagedListView.separated(
        padding: const EdgeInsets.all(16.0),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieModel>(
            itemBuilder: (context, item, index) => ItemMovieWidget(
                movie: item,
                widthBackdrop: double.infinity,
                heightBackdrop: 260,
                widthPoster: 80,
                heightPoster: 140)),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
