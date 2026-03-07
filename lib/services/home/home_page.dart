import 'package:avo/core/storage/hive/user_controller.dart';
import 'package:avo/model/user_model.dart';
import 'package:avo/services/home/components/duration_counter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double counterValue = 1.0;

  final _userController=UserController();
  late final UserModel? user;

  @override
  void initState() {
    super.initState();
    user = _userController.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Avo")),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: DurationCounter(
                      onChanged: (value) {
                        setState(() {
                          counterValue = value;
                          debugPrint("Method called");
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Streak",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "5*",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Hello ${user!.username}!👋",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    Text(
                      "Ready to FOCUS?",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800
                      ),
                    ),
                    Text(
                      "Start now!",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          debugPrint(counterValue.toString());
                        }, 
                        child: Text("Let's LOCKIN")
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
