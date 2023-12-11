import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final Map<String, IconData> items;

  MyDropdownButton({required this.items});

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.items.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Icon(widget.items[_selectedValue]),
            SizedBox(width: 10),
            DropdownButton<String>(
              value: _selectedValue,
              underline: SizedBox(),
              icon: Icon(Icons.expand_more),
              onChanged: (newValue) {
                setState(() {
                  _selectedValue = newValue!;
                });
              },
              items: widget.items.entries
                  .map(
                    (entry) => DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.key ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
