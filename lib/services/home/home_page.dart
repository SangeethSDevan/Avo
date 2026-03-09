import 'package:avo/core/cubit/session/session_cubit.dart';
import 'package:avo/core/storage/hive/user_controller.dart';
import 'package:avo/services/home/components/duration_counter.dart';
import 'package:avo/services/session/session_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double counterValue = 1.0;

  @override
  Widget build(BuildContext context) {
    final userController = UserController();
    final user = userController.getUserData();
    return Scaffold(
      appBar: AppBar(title: const Text("Avo")),
      drawer: const Drawer(),
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
                        counterValue = value;
                        debugPrint("Duration: $counterValue");
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
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
                    const Text(
                      "**",
                      style: TextStyle(
                        fontSize: 180,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Hello ${user!.username}! 👋",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Ready to FOCUS?",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const Text(
                      "Start now!",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!context.read<SessionCubit>().isConnected())return;
                          context.read<SessionCubit>().findPartner(
                            counterValue,
                          );

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<SessionCubit>(),
                                child: const SessionPage(),
                              ),
                            ),
                          );
                        },
                        child: const Text("Let's LOCKIN"),
                      ),
                    ),
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
