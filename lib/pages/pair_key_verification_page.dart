import 'package:deskpulse/services/deskpulse_service.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class PairKeyVerificationPage extends StatefulWidget {
  const PairKeyVerificationPage({
    super.key,
    required this.deskpulseService,
  });

  final DeskpulseService deskpulseService;

  @override
  State<PairKeyVerificationPage> createState() =>
      _PairKeyVerificationPageState();
}

class _PairKeyVerificationPageState extends State<PairKeyVerificationPage> {
  OtpFieldController otpController = OtpFieldController();
  String pairKey = "";
  bool isVerificationLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OTPTextField(
            controller: otpController,
            length: 4,
            width: MediaQuery.of(context).size.width,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 45,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 15,
            style: TextStyle(fontSize: 17),
            onChanged: (pin) {
              print("Changed: " + pin);
              setState(() {
                pairKey = pin;
              });
            },
            onCompleted: (pin) {
              print("Completed: " + pin);
              setState(() {
                pairKey = pin;
              });
            }),
      ),
      floatingActionButton: pairKey.isNotEmpty && pairKey.length >= 4
          ? FilledButton(
              onPressed: () async {
                setState(() {
                  isVerificationLoading = true;
                });
                try {
                  final res =
                      await widget.deskpulseService.verifyPairyKey(pairKey);
                  print(res);
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        e.toString().split(":").last,
                      ),
                    ),
                  );
                }

                setState(() {
                  isVerificationLoading = false;
                });
              },
              child: isVerificationLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text("Verify"),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
