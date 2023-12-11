import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected; // Add this line

  const DatePicker({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.5,

      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children:[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                onTap: () async {
                  DateTime ? newDate = await showDatePicker(context: context,
                      initialDate:date,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100)
                  );
                  if(newDate == null) return;
                  setState(() => date = newDate);
                },
                child: Icon(Icons.calendar_today),
            ),
              ),
             Text('${date.year}/${date.month}/${date.day}' ,
             style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 20
             ),),
            ]


          ),
        ),

    );
  }
}
