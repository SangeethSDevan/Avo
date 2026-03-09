import 'package:avo/core/cubit/session/session_cubit.dart';
import 'package:avo/core/cubit/session/session_state.dart';
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
            return Center(child: Text("#WAITING_FOR_PARTNER"));
          }
          if(state is SessionQuit){
            return Center(child: Text(state.message));
          }
          return Center(child: Text("#SESSION"));
        },
      ),
    );
  }
}
