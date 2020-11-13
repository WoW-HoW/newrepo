import 'package:flutter/material.dart';
import 'dart:async';
import 'package:volume/volume.dart';

class Volu extends StatefulWidget {
  @override
  _VoluState createState() => _VoluState();
}

class _VoluState extends State<Volu> {
  AudioManager audioManager;
  int maxVol, currentVol;
  ShowVolumeUI showVolumeUI = ShowVolumeUI.HIDE;

  @override
  void initState() {
    super.initState();
    audioManager = AudioManager.STREAM_MUSIC;
    initAudioStreamType();
    updateVolumes();
  }

  Future<void> initAudioStreamType() async {
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  updateVolumes() async {
    // get Max Volume
    maxVol = await Volume.getMaxVol;
    // get Current Volume
    currentVol = await Volume.getVol;
    setState(() {});
  }

  setVol(int i) async {
    await Volume.setVol(i, showVolumeUI: showVolumeUI);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              (currentVol != null || maxVol != null)
                  ? Slider(
                value: currentVol / 1.0,
                divisions: maxVol,
                max: maxVol / 1.0,
                min: 0,
                onChanged: (double d) {
                  setVol(d.toInt());
                  updateVolumes();},): Container(),
            ],
          ),
        ),
      ),
    );
  }
}
