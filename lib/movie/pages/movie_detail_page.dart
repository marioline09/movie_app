import 'package:flutter/material.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/movie/providers/movie_get_detail_provider.dart';
import 'package:movie_app/widget/item_movie_widget.dart';
import 'package:movie_app/widget/webview_widget.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<MovieGetDetailProvider>()..getDetail(context, id: id),
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _WidgetAppBar(context),
            _WidgetSummary(),
          ],
        ),
      ),
    );
  }
}

class _WidgetAppBar extends SliverAppBar {
  final BuildContext context;

  _WidgetAppBar(this.context);

  @override
  Color? get backgroundColor => Colors.white;

  @override
  // TODO: implement foregroundColor
  Color? get foregroundColor => Colors.black;

  @override
  // TODO: implement leading
  Widget? get leading => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
        ),
      );

  @override
  // TODO: implement actions
  List<Widget>? get actions => [
        Consumer<MovieGetDetailProvider>(
          builder: (_, provider, __) {
            final movie = provider.movie;

            if (movie != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WebViewWidget(
                            title: movie.title,
                            url: movie.homepage,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.public),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ];

  @override
  // TODO: implement expandedHeight
  double? get expandedHeight => 300;

  @override
  // TODO: implement flexibleSpace
  Widget? get flexibleSpace => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return ItemMovieWidget(
                movieDetail: movie,
                widthBackdrop: double.infinity,
                heightBackdrop: double.infinity,
                widthPoster: 100.0,
                heightPoster: 160.0);
          }

          return Container(
            color: Colors.black12,
            height: double.infinity,
            width: double.infinity,
          );
        },
      );
}

class _WidgetSummary extends SliverToBoxAdapter {
  TableRow _tableContent({required String title, required String content}) =>
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content),
        ),
      ]);

  Widget _content({required String title, required Widget body}) => Column(
        children: [
          Align(
            alignment: Alignment.center, // Align title to the center
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Horizontal padding for balanced spacing
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign:
                    TextAlign.center, // Ensure text is aligned to the center
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          body,
          const SizedBox(height: 16.0),
        ],
      );

  @override
  Widget? get child => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal:
                      16.0), // Padding on the left and right of the whole content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                      height:
                          20.0), // Add a SizedBox for spacing between image and content
                  _content(
                    title: 'Release Date',
                    body: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                          size: 32.0,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          movie.releaseDate.toString().split(' ').first,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _content(
                    title: 'Genres',
                    body: Wrap(
                      spacing: 6,
                      children: movie.genres
                          .map((genre) => Chip(
                                label: Text(genre.name),
                                backgroundColor: Colors
                                    .black12, // Set background color for the genre chip
                              ))
                          .toList(),
                    ),
                  ),
                  _content(title: 'Overview', body: Text(movie.overview)),
                  _content(
                    title: 'Summary',
                    body: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      border: TableBorder.all(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      children: [
                        _tableContent(
                          title: "Adult",
                          content: movie.adult ? "Yes" : "No",
                        ),
                        _tableContent(
                          title: "Popularity",
                          content: '${movie.popularity}',
                        ),
                        _tableContent(
                          title: "Status",
                          content: movie.status,
                        ),
                        _tableContent(
                          title: "Budget",
                          content: "${movie.budget}",
                        ),
                        _tableContent(
                          title: "Revenue",
                          content: "${movie.revenue}",
                        ),
                        _tableContent(
                          title: "Tagline",
                          content: movie.tagline,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(); // Return an empty container when no movie data is available
        },
      );
}
