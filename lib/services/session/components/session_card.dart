import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  final String partnerName;

  const SessionCard({super.key, required this.partnerName});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black,
              child: Text(
                partnerName.substring(0, 1),
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            SizedBox(width: 10),
            Text(
              partnerName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
