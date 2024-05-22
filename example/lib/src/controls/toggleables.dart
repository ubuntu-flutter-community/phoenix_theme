import 'package:flutter/material.dart';

class Toggleables extends StatefulWidget {
  const Toggleables({super.key});

  @override
  State<Toggleables> createState() => _ToggleablesState();
}

class _ToggleablesState extends State<Toggleables> {
  var _selected = <String>{};
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        SegmentedButton<String>(
          showSelectedIcon: false,
          emptySelectionAllowed: true,
          onSelectionChanged: (v) => setState(() => _selected = v),
          multiSelectionEnabled: true,
          segments: ['Ka', 'Me', 'Ha', 'Meh', 'Hah']
              .map((e) => ButtonSegment(value: e, label: Text(e)))
              .toList(),
          selected: _selected,
        ),
        Row(
          children: [
            Checkbox(value: true, onChanged: (_) {}),
            Checkbox(value: false, onChanged: (_) {}),
            const Checkbox(value: true, onChanged: null),
            const Checkbox(value: false, onChanged: null),
          ],
        ),
        Row(
          children: [
            Radio(
              value: true,
              groupValue: true,
              onChanged: (_) {},
            ),
            Radio(
              value: false,
              groupValue: true,
              onChanged: (_) {},
            ),
            const Radio(
              value: true,
              groupValue: true,
              onChanged: null,
            ),
            const Radio(
              value: false,
              groupValue: true,
              onChanged: null,
            ),
          ],
        ),
        Wrap(
          spacing: 10,
          children: [
            Switch(onChanged: (value) {}, value: true),
            Switch(onChanged: (value) {}, value: false),
            const Switch(value: true, onChanged: null),
            const Switch(value: false, onChanged: null),
          ],
        ),
      ],
    );
  }
}
