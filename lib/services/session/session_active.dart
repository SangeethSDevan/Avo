import 'package:avo/services/home/components/timer_counter.dart';
import 'package:avo/services/session/components/session_card.dart';
import 'package:flutter/cupertino.dart';

class SessionActivePage extends StatelessWidget {
  final String partnerName;

  const SessionActivePage({
    super.key,
    required this.partnerName,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              flex: 3,
              child: TimerCounter(),
            ),

            const SizedBox(height: 20),
            Flexible(
              flex: 1,
              child: SessionCard(partnerName: partnerName),
            ),
          ],
        ),
      ),
    );
  }
}