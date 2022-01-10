import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child:  const Center(
          child: CircularProgressIndicator(
            strokeWidth: 5,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}
//Image.asset("assets/no_internet_connection.jpg")