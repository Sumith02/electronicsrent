import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .24,
        color: Colors.cyan,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'CAMERA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 45.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          FadeAnimatedText(
                            'do IT!',
                            duration: Duration(seconds: 4),
                          ),
                          FadeAnimatedText(
                            'do it RIGHT!!',
                            duration: Duration(seconds: 4),
                          ),
                          FadeAnimatedText(
                            'do it RIGHT NOW!!!',
                            duration: Duration(seconds: 4),
                          ),
                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Neumorphic(
                style: NeumorphicStyle(
                  color: Colors.white,
                ),
                child: Text('dfdf'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
