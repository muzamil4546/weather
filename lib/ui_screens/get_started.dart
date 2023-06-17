import 'package:flutter/material.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/ui_screens/home.dart';
import 'package:weather/ui_screens/welcome.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {

    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: myConstants.primaryColor.withOpacity(.6),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/get-started.png"),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(
                          builder: (context)=> Home()));
                },
                child: Container(
                  height: 50,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: myConstants.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text('Get Started',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
