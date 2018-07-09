// import 'package:test/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // test("initialize assets" , (){
  //   var image = AssetImage('assets/dpad_b.png');
  //   expect(image.assetName, 'assets/dpad_b.png');   
  // });

  testWidgets("initialize assets", (WidgetTester tester){
    var image = Image.asset("assets/dpad_b.png", package: 'dpad');
    tester.pumpWidget(image);
  });
  
  
}
