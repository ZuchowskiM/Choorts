import 'dart:async';
import 'package:flutter/services.dart';
import 'package:quiver/async.dart';

class MetronomeSound {

  Metronome _metronome = new Metronome.epoch(new Duration(milliseconds: (60000/80).round()));
  late StreamSubscription _subscription;
  double _tempo = 80;

  void setTempo(double tempo){
    this._tempo = tempo;
  }

  void play(){

    _metronome = new Metronome.epoch(new Duration(milliseconds: (60000/_tempo).round()));
    _subscription = _metronome.listen((event) {
     
      SystemSound.play(SystemSoundType.click);
                                          
    });
  }

  void stop(){
    _subscription.cancel();
  }


}