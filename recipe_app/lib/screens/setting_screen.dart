import 'package:flutter/material.dart';
import 'package:recipe_app/components/home_drawer.dart';
import 'package:recipe_app/models/settings.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
    required this.onSettingsChanged,
    required this.settings,
  });

  final Settings settings;
  final void Function(Settings) onSettingsChanged;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final Settings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    void Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      ),
      drawer: const HomeDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  "Sem Glúten",
                  "Só exibe refeições sem glúten",
                  settings.isGlutenFree,
                  (value) => setState(() {
                    settings.isGlutenFree = value;
                  }),
                ),
                _createSwitch(
                  "Sem Lactose",
                  "Só exibe refeições sem lactose",
                  settings.isLactoseFree,
                  (value) => setState(() {
                    settings.isLactoseFree = value;
                  }),
                ),
                _createSwitch(
                  "Vegano",
                  "Só exibe refeições veganas",
                  settings.isVegan,
                  (value) => setState(() {
                    settings.isVegan = value;
                  }),
                ),
                _createSwitch(
                  "Vegetariano",
                  "Só exibe refeições vegetarianas",
                  settings.isVegetarian,
                  (value) => setState(() {
                    settings.isVegetarian = value;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
