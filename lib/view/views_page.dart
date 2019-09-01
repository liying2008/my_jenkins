import 'package:flutter/material.dart';
import 'package:my_jenkins/global/event/event_bus.dart';
import 'package:my_jenkins/global/tool/logger.dart';
import 'package:my_jenkins/view/event/view_event.dart';
import 'package:my_jenkins/view/jobs_list_widget.dart';
import 'package:my_jenkins/view/views_widget.dart';

class ViewsPage extends StatefulWidget {
  final String title = 'Jobs List';

  ViewsPage({Key key}) : super(key: key);

  @override
  _ViewsPageState createState() => _ViewsPageState();
}

class _ViewsPageState extends State<ViewsPage> {
  var _view = 'all';

  _ViewsPageState() {
    eventBus.on<SelectViewEvent>().listen((event) {
      setState(() {
        _view = event.view.name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} - $_view"),
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
  BuildContext _context;

  _BottomSheetFloatingActionButtonState() {
    eventBus.on<SelectViewEvent>().listen((event) {
      _closeBottomSheet();
    });
  }

  _closeBottomSheet() {
    Navigator.pop(_context);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              _context = context;
              return Container(
                child: ViewsWidget(),
              );
            });
      },
      tooltip: 'Show Views',
      child: Icon(Icons.category),
    );
  }
}
