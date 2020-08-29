import 'dart:async';

import 'package:flutter/material.dart';

class mywiget{
  Future startTime(mycode,time) async{
    var duration = new Duration(seconds: time);
    return Timer(duration,mycode);
  }

  void Snacbar(_scaffoldKey,msg){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.blueGrey,
    ));
  }
}