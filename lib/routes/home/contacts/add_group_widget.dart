import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddGroupWidget extends StatefulWidget {
  @override
  _AddGroupWidgetState createState() => _AddGroupWidgetState();
}

class _AddGroupWidgetState extends State<AddGroupWidget> {
  Color pickerColor = Color(0xff009688);
  Color currentColor = Color(0xff009688);

  TextEditingController _groupLabelController = TextEditingController();

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void _pickColor() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
           child: BlockPicker(
             pickerColor: currentColor,
             onColorChanged: changeColor,
           ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Set'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _groupLabelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Group'),
        actions: <Widget>[
          FlatButton(
            child: Text('Add'),
            onPressed: () {
              print(_groupLabelController.value);
              print(currentColor.toString());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text('Group Name:'),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2,),
                        color: currentColor,
                      ),
                      padding: const EdgeInsets.all(16),
                    ),
                    onTap: () => _pickColor(),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text('Group Label:'),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _groupLabelController,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
