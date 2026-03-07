import 'package:flutter/material.dart';

class DurationCounter extends StatefulWidget {
  final Function(double) onChanged;
  const DurationCounter({super.key, required this.onChanged});

  @override
  State<DurationCounter> createState() => _DurationCounterState();
}

class _DurationCounterState extends State<DurationCounter> {
  double value = 1.0;

  void increment() {
    if(value>=4) return;
    setState(() {
      value += 0.5;
    });
    widget.onChanged(value);
  }

  void decrement() {
    if (value <= 0.5) return;
    setState(() {
      value -= 0.5;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value.toString(), 
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Hour(s)",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  onPressed: increment,
                  child: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: decrement,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  child: Icon(
                    Icons.minimize,
                    size: 30,
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
