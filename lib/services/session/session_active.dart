import 'package:avo/services/home/components/timer_counter.dart';
import 'package:flutter/cupertino.dart';

class SessionActivePage extends StatelessWidget {
  const SessionActivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TimerCounter(),
          )
        ],
      ),
    );
  }
}