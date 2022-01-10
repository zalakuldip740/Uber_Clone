import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key? key,
    required this.message,
  })  : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        // Third of the size of the screen
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                    visible: message == 'Check Your Internet Connection.'
                        ? true
                        : false,
                    child: Ink.image(
                      image: const AssetImage('assets/nonet.jpg'),
                      height: MediaQuery.of(context).size.height / 2,
                    )),
                Text(
                  message,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
