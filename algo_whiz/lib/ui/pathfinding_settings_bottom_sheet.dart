import 'package:algo_whiz/utils/colors.dart';
import 'package:algo_whiz/viewmodel/pathfinding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PathFindingSettingsBottomSheetWidget extends StatefulWidget {
  final PathFindingViewModel model;

  const PathFindingSettingsBottomSheetWidget({Key key, this.model})
      : super(key: key);

  @override
  _PathFindingSettingsBottomSheetWidgetState createState() =>
      _PathFindingSettingsBottomSheetWidgetState();
}

class _PathFindingSettingsBottomSheetWidgetState
    extends State<PathFindingSettingsBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PathFindingViewModel>(
        builder: (BuildContext context, PathFindingViewModel value,
                Widget child) =>
            Container(
                padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Speed Control",
                                      style: Theme.of(context)
                                          .textTheme
                                          .body1
                                          .copyWith(fontSize: 16)),
                                  Slider(
                                    value: value.animationSpeedFactor,
                                    onChanged: (speed) {
                                      value.animationSpeedFactor = speed;
                                      value.setAnimationSpeedinSeconds(speed);
                                    },
                                    min: 0,
                                    max: 1,
                                    label: "${value.animationSpeedFactor}",
                                  ),
                                ]),
                          ),
                          Text("Node Color Key",
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(fontSize: 16)),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: colorPurpleNavy,
                                    border: Border.all(
                                        color: colorDarkJungleGreen, width: 1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text("Visited Node",
                                      style: Theme.of(context).textTheme.body2),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: colorElectricLime,
                                      border: Border.all(
                                          color: colorOliveGreen, width: 1),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text("Path Node",
                                      style: Theme.of(context).textTheme.body2),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: colorDarkJungleGreen, width: 0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text("Unvisited Node",
                                      style: Theme.of(context).textTheme.body2),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 20),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: colorDarkJungleGreen,
                                    border: Border.all(
                                        color: colorDarkJungleGreen, width: 0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text("Wall Node",
                                      style: Theme.of(context).textTheme.body2),
                                )
                              ],
                            ),
                          )
                        ]),
                  ],
                )));
  }
}
