import 'package:avo/core/cubit/timer/timer_cubit.dart';
import 'package:avo/core/cubit/timer/timer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCounter extends StatelessWidget {
  const TimerCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        if (state is TimerError) {
          return Text("#TIMER_ERROR");
        } else if (state is TimerUpdate) {
          final Duration duration = Duration(milliseconds: state.remainingTime);

          String twoDigits(int n) => n.toString().padLeft(2, '0');

          final hours = twoDigits(duration.inHours);
          final minutes = twoDigits(duration.inMinutes.remainder(60));
          final seconds = twoDigits(duration.inSeconds.remainder(60));

          final totalDuration=state.duration*60*60*1000;

          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 240,
                height: 240,
                child: CircularProgressIndicator(
                  value: (state.remainingTime/totalDuration),
                  strokeWidth: 10,
                  color: Colors.black,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                '$hours : $minutes : $seconds',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40
                ),
              )
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
