import 'package:flutter/material.dart';

class SessionConfirmPage extends StatelessWidget {
  final String partnerName;
  const SessionConfirmPage({super.key, required this.partnerName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hang tight!",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text(
            "Your partner is warming up.",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white54,
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
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Waiting for your partner to accept.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "**",
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
