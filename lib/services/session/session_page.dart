import 'package:avo/core/cubit/session/session_cubit.dart';
import 'package:avo/core/cubit/session/session_state.dart';
import 'package:avo/services/session/session_found.dart';
import 'package:avo/services/session/session_notfound.dart';
import 'package:avo/services/session/session_waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Avo")),
      body: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, state) {
          if(state is SessionWaiting){
            return SessionWaitingPage();
          }
          if(state is SessionQuit){
            if(state.message == "#NOT_FOUND"){
              return SessionNotfound();
            }
          }
          if(state is SessionFound){
            return SessionFoundPage(partnerName: state.room.partner);
          }
          return Center(child: Text("#SESSION"));
        },
      ),
    );
  }
}
