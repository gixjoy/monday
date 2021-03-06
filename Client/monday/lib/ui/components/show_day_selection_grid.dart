import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:monday/common/utils.dart';
import 'package:monday/model/time_condition_model.dart';

/*
This Route is the same as DaySelectionGrid, but with no tap functionalities.
It is only needed for showing days selected for a specific TimeConditionModel
condition got from Monday for a specific scene.
 */
class ShowDaySelectionGrid extends StatefulWidget {

  final TimeConditionModel timeCondition;
  final List<String> buttonsText;
  final Function(List<String>) onSelectionChanged;
  final double containerHeight;
  ShowDaySelectionGrid(this.timeCondition, this.buttonsText, this.containerHeight,
      {this.onSelectionChanged});

  @override
  State<StatefulWidget> createState() {
    return new ShowDaySelectionGridState();
  }
}

class ShowDaySelectionGridState extends State<ShowDaySelectionGrid> {

  String selectedChoice = "";

  buildDaysGrid(BuildContext context){
    List<String> selectedChoices = widget.timeCondition.days;
    List<Widget> months = List();
    widget.buttonsText.forEach((item) {
      months.add(
        Padding(
          padding: const EdgeInsets.all(2),
          child: ChoiceChip(
            label: Text(
              item,
              style: TextStyle(
                color: Colors.black
              ),
            ),
            selected: selectedChoices.contains(item),
            selectedColor: Colors.blueAccent,
            disabledColor: Colors.grey[800],
            backgroundColor: Colors.grey[800],
          )
        )
      );
    });
    selectedChoices.forEach((item){
      //print("DAY: " + item.toString());
    });
    return months;
  }

  @override
  Widget build(BuildContext context){
    GridView grid = new GridView.count(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      crossAxisCount: 4,
      children: buildDaysGrid(context),
      shrinkWrap: true,
      childAspectRatio: 3/2
    );
    return new Container(
      height: widget.containerHeight,
      width: 80,
      padding: EdgeInsets.only(top:10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 2,
          color: Colors.grey[600]
        ),
      ),
      //padding: const EdgeInsets.only(bottom:50),
      child: grid,
    );
  }
}