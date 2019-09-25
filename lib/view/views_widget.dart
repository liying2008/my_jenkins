import 'package:flutter/material.dart';
import 'package:flutter_jenkins_client/model/view.dart';
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

  @override
  void initState() {
    _getAllViews();
    super.initState();
  }

  void _getAllViews() {
    logger.i('_ViewsWidgetState#_getAllViews()');
    jenkinsClient.getViews().then((views) {
      logger.i('_ViewsWidgetState#_getAllViews()#views: $views');
      setState(() {
        views.forEach((name, view) {
          _views.add(view);
        });
        _loadingText = '';
      });
    }).catchError((e) {
      logger.i('_ViewsWidgetState#_getAllViews()#e: $e');
      setState(() {
        _loadingText = 'ERROR!';
      });
    });
  }

  _selectView(index) {
    logger.i('_ViewsWidgetState#_selectView(): $index');
    eventBus.fire(SelectViewEvent(_views[index]));
  }

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);
    return ClipRRect(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        child: Container(
            color: Colors.white,
            child: Column(children: [
              ListTile(title: Center(child: Text("All Views"))),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _views.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        dense: true,
                        title: Text(_views[index].name),
                        leading: Icon(Icons.category),
                        subtitle: Text(_views[index].description ?? ''),
                        onTap: () {
                          _selectView(index);
                        });
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              )
            ])));
  }
}
