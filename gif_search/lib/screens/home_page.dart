import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../stores/api/api.store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ApiStore apiStore = GetIt.instance<ApiStore>();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiStore.getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif',
          height: 40.0,
        ),
        backgroundColor: Colors.black,
      ),
      body: Observer(
        builder: (_) {
          switch (apiStore.status) {
            case FutureStatus.pending:
              return const Center(child: CircularProgressIndicator());
            case FutureStatus.rejected:
              return Center(child: SelectableText(apiStore.errorMessage));
            case FutureStatus.fulfilled:
              final dataList = apiStore.apiData;
              if (dataList.isEmpty) {
                return const Center(child: Text('Nenhum dado encontrado'));
              } else {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  itemCount: apiStore.apiData.length,
                  itemBuilder: (context, index) {
                    final data = dataList[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        data['images']['fixed_height']['url'],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: BottomAppBar(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  key: ValueKey('GifsSearch'),
                  controller: searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search_outlined),
                    ),
                    label: Text('Buscar Gifs'),
                    labelStyle: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
