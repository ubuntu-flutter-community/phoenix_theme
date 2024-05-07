import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../containers.dart';
import '../../controls.dart';
import '../../fonts.dart';
import '../../textfields.dart';
import '../color.dart';
import '../utils.dart';

final GlobalKey<ScaffoldState> themePageScaffoldKey = GlobalKey();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  HomePageState();

  int _selectedIndex = 0;

  final _items = <Widget, (Widget, Widget, String)>{
    const FontsView(): (
      const Badge(
        label: Text('123'),
        child: Icon(Icons.font_download_outlined),
      ),
      const Badge(
        label: Text('123'),
        child: Icon(Icons.font_download),
      ),
      'Fonts'
    ),
    const ControlsView(): (
      const Icon(Icons.radio_button_checked_outlined),
      const Icon(Icons.radio_button_checked),
      'Controls'
    ),
    const TextFieldsView(): (
      const Icon(Icons.text_fields_outlined),
      const Icon(Icons.text_fields),
      'TextFields'
    ),
    const ColorsView(): (
      const Icon(Icons.color_lens_outlined),
      const Icon(Icons.color_lens),
      'Palette'
    ),
    const ContainersView(): (
      const Icon(Icons.square_outlined),
      const Icon(Icons.square),
      'Containers'
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: themePageScaffoldKey,
      drawer: _Drawer(
        selectedIndex: _selectedIndex,
        onSelected: (index) {
          setState(() => _selectedIndex = index);
          Navigator.of(context).pop();
        },
        items: _items,
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Center(
          child: IconButton(
            onPressed: () => themePageScaffoldKey.currentState?.openDrawer(),
            icon: const Icon(Icons.menu),
          ),
        ),
        title: const Text('Phoenix Theme'),
        actions: [
          IconButton(
            onPressed: () => showSnack(context),
            icon: const Icon(Icons.add),
          ),
          ValueListenableBuilder(
            valueListenable: themeModeNotifier,
            builder: (context, themeMode, widget) {
              return PopupMenuButton<ThemeMode>(
                onSelected: (v) => themeModeNotifier.value = v,
                itemBuilder: (c) => ThemeMode.values
                    .map(
                      (e) => PopupMenuItem<ThemeMode>(
                        value: e,
                        child: Icon(
                          [
                            Icons.lightbulb,
                            Icons.light_mode,
                            Icons.dark_mode,
                          ].elementAt(ThemeMode.values.indexOf(e)),
                        ),
                      ),
                    )
                    .toList(),
                icon: Icon(
                  [
                    Icons.lightbulb,
                    Icons.light_mode,
                    Icons.dark_mode,
                  ].elementAt(ThemeMode.values.indexOf(themeMode)),
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: colorNotifier,
            builder: (context, color, widget) {
              return PopupMenuButton<Color>(
                onSelected: (v) => colorNotifier.value = v,
                itemBuilder: (c) => Colors.accents
                    .map(
                      (e) => PopupMenuItem<Color>(
                        value: e,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: e,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                icon: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Row(
              children: [
                NavigationRail(
                  destinations: [
                    for (final item in _items.entries)
                      NavigationRailDestination(
                        icon: item.value.$1,
                        selectedIcon: item.value.$2,
                        label: Text(item.value.$3),
                      ),
                  ],
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) =>
                      setState(() => _selectedIndex = index),
                ),
                const VerticalDivider(
                  width: 0.0,
                ),
                Expanded(
                  child: Center(
                    child: _items.entries.elementAt(_selectedIndex).key,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: _items.entries.elementAt(_selectedIndex).key,
                  ),
                ),
                const Divider(
                  height: 0.0,
                ),
                NavigationBar(
                  destinations: [
                    for (final item in _items.entries)
                      NavigationDestination(
                        icon: item.value.$1,
                        selectedIcon: item.value.$2,
                        label: item.value.$3,
                      ),
                  ],
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) =>
                      setState(() => _selectedIndex = index),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    required this.items,
    required this.onSelected,
    required this.selectedIndex,
  });

  final Map<Widget, (Widget, Widget, String)> items;
  final Function(int index) onSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text('Drawer Header'),
          ),
          for (var i = 0; i < items.length; i++)
            ListTile(
              selected: i == selectedIndex,
              leading: i == selectedIndex
                  ? items.entries.elementAt(i).value.$2
                  : items.entries.elementAt(i).value.$1,
              title: Text(items.entries.elementAt(i).value.$3),
              onTap: () => onSelected(i),
            ),
        ],
      ),
    );
  }
}
