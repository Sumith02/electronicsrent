import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BannerWidget extends StatelessWidget {
  final String imageUrl;
  final String title;

  const BannerWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .24,
        color: Colors.cyan,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 140.0,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                            ),
                          ),
                        ),
                      ],
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                        oppositeShadowLightSource: true,
                        color: const Color.fromARGB(255, 166, 159, 159),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          imageUrl,
                          width: 150,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SlidingBannerWidget extends StatelessWidget {
  const SlidingBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .24,
      child: PageView(
        children: [
          BannerWidget(
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/electronicsrent-aa920.appspot.com/o/banner%2F360_F_496471319_DbtjoUvKqyy2e9OfgBnK5mm2AXhKpa9m.jpg?alt=media&token=33634ba7-48cc-45ed-9a1c-addae90546b4',
            title: 'CAMERA',
          ),
          BannerWidget(
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/electronicsrent-aa920.appspot.com/o/categories%2Ficons8-laptop-48.png?alt=media&token=c83a67c9-eec5-4e31-aaff-034ba4fba2f0',
            title: 'LAPTOP',
          ),
          BannerWidget(
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/electronicsrent-aa920.appspot.com/o/banner%2F360_F_496471319_DbtjoUvKqyy2e9OfgBnK5mm2AXhKpa9m.jpg?alt=media&token=33634ba7-48cc-45ed-9a1c-addae90546b4',
            title: 'DRONE',
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: SlidingBannerWidget(),
      ),
    ),
  ));
}
