import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/stock/home.store.dart';
import 'package:shop_v2/utils/theme/gradient.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final homeStore = GetIt.instance<HomeStore>();
    return Stack(
      children: [
        buildBodyBack(
          colorX: Colors.pink.shade700,
          colorY: Colors.pinkAccent.shade100,
          x: Alignment.topCenter,
          y: Alignment.bottomCenter,
        ),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(AppLocalizations.of(context)!.news),
                centerTitle: true,
              ),
            ),
            StreamBuilder(
              stream: homeStore.productsList,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0.5,
                      crossAxisSpacing: 0.5,
                      children: snapshot.data!
                          .map(
                            (doc) => StaggeredGridTile.count(
                              crossAxisCellCount: doc.x,
                              mainAxisCellCount: doc.y,
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: doc.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
