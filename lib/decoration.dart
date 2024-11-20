import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DonationApp extends StatefulWidget {
  @override
  _DonationAppState createState() => _DonationAppState();
}

class _DonationAppState extends State<DonationApp> {
  late VideoPlayerController _bloodController;
  late VideoPlayerController _foodController;
  bool _isBloodVideoPlaying = true;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _bloodController = VideoPlayerController.asset('assets/helping.mp4')
      ..initialize().then((_) {
        setState(() {
          _isControllerInitialized = true;
        });
        _bloodController.play();
        _bloodController.setLooping(false);
        _bloodController.addListener(() {
          if (_bloodController.value.position ==
              _bloodController.value.duration) {
            _switchToFoodVideo();
          }
        });
      });

    _foodController = VideoPlayerController.asset('assets/krish.mp4')
      ..initialize();
  }

  void _switchToFoodVideo() {
    setState(() {
      _isBloodVideoPlaying = false;
    });
    _foodController.play();
    _foodController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Blood & Food Donation',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _isControllerInitialized
              ? (_isBloodVideoPlaying
                  ? VideoPlayer(_bloodController)
                  : VideoPlayer(_foodController))
              : Center(child: CircularProgressIndicator()),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _isControllerInitialized ? 1.0 : 0.0,
                  duration: Duration(seconds: 2),
                  child: Text(
                    _isBloodVideoPlaying
                        ? 'Donate Blood, Save Lives!'
                        : '',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.red,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: _isControllerInitialized ? 1.0 : 0.0,
                  duration: Duration(seconds: 2),
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bloodController.dispose();
    _foodController.dispose();
    super.dispose();
  }
}
