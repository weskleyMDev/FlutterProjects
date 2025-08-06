import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_v2/stores/stock/home.store.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final homeStore = GetIt.instance<HomeStore>();

    Widget buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade700, Colors.pinkAccent.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );

    return Stack(
      children: [
        buildBodyBack(),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('News'),
                centerTitle: true,
              ),
            ),
            StreamBuilder(
              stream: homeStore.productsList,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  print(snapshot.data);
                  return SliverToBoxAdapter(child: Center(child: Container()));
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
