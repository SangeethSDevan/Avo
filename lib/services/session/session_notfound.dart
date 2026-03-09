import 'package:flutter/material.dart';

class SessionNotfound extends StatelessWidget {
  const SessionNotfound({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hmm...",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Couldn't find anyone right now.",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Try again in a moment.",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "**",
                      style: TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("BACK HOME"),
            ),
          ),
        ],
      ),
    );
  }
}
