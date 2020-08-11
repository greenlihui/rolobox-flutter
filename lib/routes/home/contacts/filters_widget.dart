import 'package:flutter/material.dart';

class FiltersForm {
  bool genderSelected;
  String genderValue;
  bool ageSelected;
  int ageLow;
  int ageHigh;

  bool eyeglassesSelected;
  bool eyeglassesValue;

  bool mustacheSelected;
  bool mustacheValue;

  bool beardSelected;
  bool beardValue;

  FiltersForm({
    this.genderSelected = false,
    this.genderValue = "Male",
    this.ageSelected = false,
    this.ageLow = 0,
    this.ageHigh = 0,
    this.eyeglassesSelected = false,
    this.eyeglassesValue = false,
    this.mustacheSelected = false,
    this.mustacheValue = false,
    this.beardSelected = false,
    this.beardValue = false,
  });

  @override
  String toString() {
    return 'FiltersForm{genderSelected: $genderSelected, genderValue: $genderValue, ageSelected: $ageSelected, ageLow: $ageLow, ageHigh: $ageHigh, eyeglassesSelected: $eyeglassesSelected, eyeglassesValue: $eyeglassesValue, mustacheSelected: $mustacheSelected, mustacheValue: $mustacheValue, beardSelected: $beardSelected, beardValue: $beardValue}';
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> mid = []..add(genderSelected ? {'Gender': genderValue} : {})
      ..add(ageSelected ? {'AgeRange': {"Low": ageLow, 'High': ageHigh}} : {})
      ..add(eyeglassesSelected ? {'Eyeglasses': eyeglassesValue} : {})
      ..add(mustacheSelected ? {'Mustache': mustacheValue} : {})
      ..add(beardSelected ? {'Beard': beardValue} : {});
    return mid.where((item) => item.keys.length != 0).toList();
  }
}

class FiltersWidget extends StatefulWidget {
  FiltersForm filterForm;

  FiltersWidget({Key key, @required this.filterForm}) : super(key: key);

  @override
  _FiltersWidgetState createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {

  final TextEditingController _lowController = TextEditingController();
  final TextEditingController _highController = TextEditingController();

  @override
  void initState() {
    _lowController.text = widget.filterForm.ageLow.toString();
    _highController.text = widget.filterForm.ageHigh.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: <Widget>[
          FlatButton(
            child: Text("Apply"),
            onPressed: () {
              Navigator.pop(context, widget.filterForm);
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CheckboxWithLabel(
              label: "GENDER",
              value: widget.filterForm.genderSelected,
              changed: (val) {
                setState(() => widget.filterForm.genderSelected = val);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RadioWithLabel<String>(
                  label: "Male",
                  value: "Male",
                  groupValue: widget.filterForm.genderValue,
                  changed: widget.filterForm.genderSelected
                      ? (val) {
                          setState(() => widget.filterForm.genderValue = val);
                        }
                      : null,
                ),
                RadioWithLabel<String>(
                  label: "Female",
                  value: "Female",
                  groupValue: widget.filterForm.genderValue,
                  changed: widget.filterForm.genderSelected
                      ? (val) {
                    setState(() => widget.filterForm.genderValue = val);
                  }
                      : null,
                ),
              ],
            ),
            Divider(),
            CheckboxWithLabel(
              label: "AGE",
              value: widget.filterForm.ageSelected,
              changed: (val) {
                setState(() => widget.filterForm.ageSelected = val);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      enabled: widget.filterForm.ageSelected,
                      controller: _lowController,
                      onChanged: (val) => widget.filterForm.ageLow = int.parse(val),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        isDense: true,
                        labelText: "Low",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('to'),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: TextField(
                      enabled: widget.filterForm.ageSelected,
                      controller: _highController,
                      onChanged: (val) => widget.filterForm.ageHigh = int.parse(val),
                      decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(),
                        labelText: "High",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            CheckboxWithLabel(
              label: "EYEGLASSES",
              value: widget.filterForm.eyeglassesSelected,
              changed: (val) {
                setState(() => widget.filterForm.eyeglassesSelected = val);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RadioWithLabel<bool>(
                  label: "YES",
                  value: true,
                  groupValue: widget.filterForm.eyeglassesValue,
                  changed: widget.filterForm.eyeglassesSelected
                      ? (val) {
                          setState(() => widget.filterForm.eyeglassesValue = val);
                        }
                      : null,
                ),
                RadioWithLabel<bool>(
                  label: "No",
                  value: false,
                  groupValue: widget.filterForm.eyeglassesValue,
                  changed: widget.filterForm.eyeglassesSelected
                      ? (val) {
                          setState(() => widget.filterForm.eyeglassesValue = val);
                        }
                      : null,
                ),
              ],
            ),
            Divider(),
            CheckboxWithLabel(
              label: "MUSTACHE",
              value: widget.filterForm.mustacheSelected,
              changed: (val) {
                setState(() => widget.filterForm.mustacheSelected = val);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RadioWithLabel<bool>(
                  label: "YES",
                  value: true,
                  groupValue: widget.filterForm.mustacheValue,
                  changed: widget.filterForm.mustacheSelected
                      ? (val) {
                          setState(() => widget.filterForm.mustacheValue = val);
                        }
                      : null,
                ),
                RadioWithLabel<bool>(
                  label: "No",
                  value: false,
                  groupValue: widget.filterForm.mustacheValue,
                  changed: widget.filterForm.mustacheSelected
                      ? (val) {
                          setState(() => widget.filterForm.mustacheValue = val);
                        }
                      : null,
                ),
              ],
            ),
            Divider(),
            CheckboxWithLabel(
              label: "BEARD",
              value: widget.filterForm.beardSelected,
              changed: (val) {
                setState(() => widget.filterForm.beardSelected = val);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RadioWithLabel<bool>(
                  label: "YES",
                  value: true,
                  groupValue: widget.filterForm.beardValue,
                  changed: widget.filterForm.beardSelected
                      ? (val) {
                          setState(() => widget.filterForm.beardValue = val);
                        }
                      : null,
                ),
                RadioWithLabel<bool>(
                  label: "No",
                  value: false,
                  groupValue: widget.filterForm.beardValue,
                  changed: widget.filterForm.beardSelected
                      ? (val) {
                          setState(() => widget.filterForm.beardValue = val);
                        }
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RadioWithLabel<T> extends StatelessWidget {
  final String label;
  final T value;
  final T groupValue;
  final ValueChanged<T> changed;

  RadioWithLabel({
    Key key,
    @required this.label,
    @required this.value,
    @required this.groupValue,
    @required this.changed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: <Widget>[
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: changed,
          ),
          Text(label),
        ],
      ),
    );
  }
}

class CheckboxWithLabel extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool> changed;

  CheckboxWithLabel({
    Key key,
    @required this.label,
    this.value: false,
    @required this.changed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: value,
            onChanged: changed,
          ),
          Text(label),
        ],
      ),
    );
  }
}
