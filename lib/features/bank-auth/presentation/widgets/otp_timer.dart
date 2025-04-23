  import 'dart:async';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import '../controllers/otp_controller.dart';

  class OtpTimer extends StatefulWidget {
    final VoidCallback onExpire;
    const OtpTimer({super.key, required this.onExpire});

    @override
    State<OtpTimer> createState() => _OtpTimerState();
  }

  class _OtpTimerState extends State<OtpTimer> {
    late Timer _timer;
    int _secondsRemaining = 60;
    final OtpController otpController = Get.find<OtpController>();

    @override
    void initState() {
      super.initState();
      _startTimer();
    }

    void _startTimer() {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsRemaining > 0) {
          setState(() {
            _secondsRemaining--;
          });
        } else {
          timer.cancel();
          otpController.markOtpAsExpired();
          widget.onExpire();
        }
      });
    }

    @override
    void dispose() {
      _timer.cancel();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Text(
        "Expires in $_secondsRemaining seconds",
        style: const TextStyle(color: Colors.red),
      );
    }
  }