import 'package:api_testing/utils/app_constants.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/speech_to_text_provider.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SpeechToTextProvider>(context, listen: false).initSpeech();
    Provider.of<SpeechToTextProvider>(context, listen: false)
        .stopwatchProvider();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SpeechToTextProvider>(
        builder: (context, speechToTextProvider, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF161616),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    speechToTextProvider.formattedText,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Tab to Start",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  AvatarGlow(
                    // endRadius: 60.0,
                    child: Material(

                        // elevation: 8.0,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.purple,
                          child: Transform.scale(
                            scale: 4,
                            child: Image.asset(
                              speechToTextProvider.isListening == true
                                  ? AppConstant.glow
                                  : AppConstant.notGlow,
                              // width: 200,
                              // height: 200,
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        // If listening is active show the recognized words
                        speechToTextProvider.isListening
                            ? speechToTextProvider.lastWords
                            : speechToTextProvider.lastWords,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  if (speechToTextProvider.speechEnabled)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (!speechToTextProvider.isListening)
                          IconButton(
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              size: 80,
                              color: Colors.white,
                            ),
                            onPressed: () =>
                                speechToTextProvider.startListening(),
                          ),
                        if (speechToTextProvider.isListening)
                          IconButton(
                            icon: const Icon(
                              Icons.pause,
                              color: Colors.white,
                              size: 80,
                            ),
                            onPressed: () =>
                                speechToTextProvider.stopListening(),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
