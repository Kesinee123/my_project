import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget? mobile;
  final Widget? destop;
  final Widget? smallMobile;

  const Responsive({
    @required this.mobile,
    @required this.destop,
    this.smallMobile,
   
  });

  static bool isMobile(BuildContext context) =>
  MediaQuery.of(context).size.width < 768;

  static bool isDestop(BuildContext context) =>
  MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    if(_size.width >= 1200) {
      return destop!;
    }else if (_size.width >= 376 && _size.width <= 768 && mobile != null ){
       return mobile!;
    }else{
      return smallMobile!;
    }
  }
}