import 'package:flutter/material.dart';
import 'package:my_jenkins/global/event/event_bus.dart';
import 'package:my_jenkins/global/tool/logger.dart';
import 'package:my_jenkins/view/event/view_event.dart';
import 'package:my_jenkins/view/jobs_list_widget.dart';
import 'package:my_jenkins/view/views_widget.dart';

class ViewsPage extends StatefulWidget {
  final String title;

  ViewsPage({Key key, @required this.title}) : super(key: key);

  @override
  _ViewsPageState createState() => _ViewsPageState();
}

class _ViewsPageState extends State<ViewsPage> {
  _ViewsPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: JobsListWidget(),
      floatingActionButton: BottomSheetFloatingActionButton(),
    );
  }
}

class BottomSheetFloatingActionButton extends StatefulWidget {
  @override
  _BottomSheetFloatingActionButtonState createState() =>
      _BottomSheetFloatingActionButtonState();
}

class _BottomSheetFloatingActionButtonState
    extends State<BottomSheetFloatingActionButton> {
  PersistentBottomSheetController _bottomSheetController;
  var iconData = Icons.arrow_upward;

  _BottomSheetFloatingActionButtonState() {
    eventBus.on<SelectViewEvent>().listen((event) {
      _closeBottomSheet();
    });
  }

  _closeBottomSheet() {
    _bottomSheetController.close();
    _bottomSheetController = null;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (_bottomSheetController != null) {
          logger.d(
              '_BottomSheetFloatingActionButtonState#_bottomSheetController',
              _bottomSheetController);
          _closeBottomSheet();
        } else {
          _bottomSheetController = showBottomSheet(
              context: context,
              builder: (context) => Container(
                    child: ViewsWidget(),
                  ));
          setState(() {
            iconData = Icons.arrow_downward;
          });
          _bottomSheetController.closed.then((value) {
            logger.d('close bottom sheet', value);
            setState(() {
              iconData = Icons.arrow_upward;
            });
          });
        }
      },
      tooltip: 'Show Views',
      child: Icon(iconData),
    );
  }
}
