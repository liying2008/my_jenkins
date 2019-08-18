import 'package:flutter/material.dart';
import 'package:flutter_jenkins_client/jenkins_client.dart';
import 'package:flutter_jenkins_client/view.dart';
import 'package:my_jenkins/global/constant/constants.dart';
import 'package:my_jenkins/global/tool/collections.dart';
import 'package:my_jenkins/global/tool/logger.dart';

class ViewsWidget extends StatefulWidget {
  ViewsWidget({Key key}) : super(key: key);

  @override
  _ViewsWidgetState createState() => _ViewsWidgetState();
}

class _ViewsWidgetState extends State<ViewsWidget> {
  var _currentPanelIndex = -1; //设置 -1 默认全部闭合
  var _loadingText = 'Loading...';
  List<View> _views = [];
  final jenkinsClient = JenkinsClient(JENKINS_URL, USERNAME, PASSWORD);

  _ViewsWidgetState() {
    _getAllViews();
  }

  _getAllViews() async {
    logger.i('_ViewsWidgetState\$_getAllViews()');
    try {
      var views = await jenkinsClient.getViews();
      logger.i('_ViewsWidgetState\$_getAllViews()\$views: $views');
      setState(() {
        views.forEach((name, view) {
          _views.add(view);
        });
        _loadingText = '';
      });
    } catch (e) {
      logger.i('_ViewsWidgetState\$_getAllViews()\$e: $e');
      setState(() {
        _loadingText = 'ERROR!';
      });
    }
  }

  _onViewClick(panelIndex, isExpanded) {
    setState(() {
      _currentPanelIndex = (_currentPanelIndex != panelIndex ? panelIndex : -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(_loadingText),
          ),
          ExpansionPanelList(
            expansionCallback: _onViewClick,
            children: mapIndexed(_views, (index, view) {
              var name = view.name;
              var url = view.url;
              return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(name),
                  );
                },
                body: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
                  child: ListBody(
                    children: <Widget>[
                      Text(name),
                      Text(url),
                    ],
                  ),
                ),
                isExpanded: _currentPanelIndex == index,
              );
            }).toList(),
          ),
          Text('')
        ],
      ),
    );
  }
}
