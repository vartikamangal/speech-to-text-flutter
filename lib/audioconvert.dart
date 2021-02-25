import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech;
  bool _isListening =false;
  String _text='press the button and start speaking';
  @override
  void initState() {
    super.initState();
    _speech=stt.SpeechToText();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _Listen,
          child: Icon(_isListening ? Icons.mic :Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Text(
            _text
          ),
        ),
      ),
    );
  }
  void _Listen() async{
    if(!_isListening){
      bool available=await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val')
      );
      if(available){
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) =>setState((){
            _text=val.recognizedWords;
            if(val.hasConfidenceRating && val.confidence>0){
            }
          }),
        );
      }
    }
    else{
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
