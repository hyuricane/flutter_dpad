# dpad

DPad View for flutter

## Getting Started

to include in flutter yaml

```
  dpad:
    git: git://github.com/hyuricane/flutter_dpad.git
```

sample in code: 

```
import 'package:dpad/dpad.dart';

...

        child: new Dpad(
            keyPadDown: (DpadState state){
                debugPrint("keyDown: $state ");
            },
            keyPadUp: (DpadState state, bool cancelled){
                debugPrint("keyUp: $state " + (cancelled ? " canceled" : ""));
            },
            centerRatio: 0.3, // optional
            idleImg: AssetImage('asset/downImg.png'), // optional
            leftImg: AssetImage('asset/leftImg.png'), // optional
            rightImg: AssetImage('asset/rightImg.png'), // optional
            upImg: AssetImage('asset/upImg.png'), // optional
            downImg: AssetImage('asset/downImg.png'), // optional
            okImg: AssetImage('asset/okImg.png'), // optional
            okPressedImg: AssetImage('asset/okPressedImg.png'), // optional
        ),

```