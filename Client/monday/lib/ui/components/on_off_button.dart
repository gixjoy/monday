import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:monday/controller/light_controller.dart';
import 'package:monday/controller/outlet_controller.dart';

const String _kFontFam = 'Monday';

class OnOffButton extends StatefulWidget{

  String deviceId;
  String deviceType;
  String switchStatus;//true=ON
  OnOffButton(this.deviceId, this.deviceType, this.switchStatus);

  @override
  State<StatefulWidget> createState() {
    return new OnOffButtonState();
  }
}

class OnOffButtonState extends State<OnOffButton>{

  Color switchColor;
  IconData icon;

  @override
  Widget build(BuildContext context){
    if(widget.switchStatus == "1") {
      switchColor = Colors.blue[700];
      icon = const IconData(0xf205, fontFamily: _kFontFam);
    }
    else {
      switchColor = Colors.grey[200];
      icon = const IconData(0xf204, fontFamily: _kFontFam);
    }
    return Container(
      width: 80,
      child: IconButton(
        onPressed: () async {
          String switchStatus = "";
          switch(widget.deviceType){
            case("light"):
              switchStatus = await LightController.updateSwitchOnMonday(
                context, widget.deviceId);
              break;
            case("outlet"):
              switchStatus = await OutletController.updateSwitchOnMonday(
                context, widget.deviceId);
              break;
          }
          if (switchStatus != null) {
            if (switchStatus == "0") {
              switchColor = Colors.grey;
              widget.switchStatus = "0";
            }
            else {
              switchColor = Colors.green;
              widget.switchStatus = "1";
            }
          }
          else
            switchColor = Colors.grey;
          setState(() {});
        },
        icon: Icon(
          icon,
          size: 35,
          color: switchColor,
        ),
      ),
    );
  }
}