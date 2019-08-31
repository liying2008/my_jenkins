import 'package:flutter/material.dart';
import 'package:flutter_jenkins_client/view.dart';
import 'package:my_jenkins/global/event/event_bus.dart';
import 'package:my_jenkins/global/tool/jenkins_client.dart';
import 'package:my_jenkins/global/tool/logger.dart';
import 'package:my_jenkins/view/event/view_event.dart';

class ViewsWidget extends StatefulWidget {
  ViewsWidget({Key key}) : super(key: key);

  @override
  _ViewsWidgetState createState() => _ViewsWidgetState();
}

class _ViewsWidgetState extends State<ViewsWidget> {
  var _loadingText = '';
  var _views = <View>[];

  _ViewsWidgetState() {
    _getAllViews();
  }

  void _getAllViews() async {
    logger.i('_ViewsWidgetState#_getAllViews()');
    try {
      var views = await jenkinsClient.getViews();
      logger.i('_ViewsWidgetState#_getAllViews()#views: $views');
      setState(() {
        views.forEach((name, view) {
          _views.add(view);
        });
        _loadingText = '';
      });
    } catch (e) {
      logger.i('_ViewsWidgetState#_getAllViews()#e: $e');
      setState(() {
        _loadingText = 'ERROR!';
      });
    }
  }

  _selectView(index) {
    logger.i('_ViewsWidgetState#_selectView(): $index');
    eventBus.fire(SelectViewEvent(_views[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: const Color(0x80000000),
            offset: new Offset(0.0, 10.0),
            blurRadius: 20.0,
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _views.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                title: Text(_views[index].name),
                leading: Icon(Icons.category),
                subtitle: Text(_views[index].description ?? ''),
                onTap: () {
                  _selectView(index);
                }),
          );
        },
      ),
    );
  }
}
