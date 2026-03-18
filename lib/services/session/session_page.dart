import 'package:avo/core/cubit/session/session_cubit.dart';
import 'package:avo/core/cubit/session/session_state.dart';
import 'package:avo/services/session/session_confirm.dart';
import 'package:avo/services/session/session_found.dart';
import 'package:avo/services/session/session_notfound.dart';
import 'package:avo/services/session/session_waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          bool exit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Confirm Quit?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(
                "Are you sure you want to go? Things were just getting interesting",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    "NO",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    "YES",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                ),
              ],
            ),
          );

          if (!context.mounted) return;

          if (exit) {
            context.read<SessionCubit>().sessionQuit();
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Avo")),
        body: BlocBuilder<SessionCubit, SessionState>(
          builder: (context, state) {
            if (state is SessionWaiting) {
              return SessionWaitingPage();
            }
            if (state is SessionQuit) {
              if (state.message == "#NOT_FOUND") {
                return SessionNotfound();
              }
            }
            if (state is SessionFound) {
              return SessionFoundPage(partnerName: state.room.partner.name);
            }
            if (state is SessionConfirm) {
              return SessionConfirmPage(partnerName: state.room.partner.name);
            }
            return Center(child: Text("#SESSION"));
          },
        ),
      ),
    );
  }
}
