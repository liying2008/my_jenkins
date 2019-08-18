import 'package:flutter/material.dart';
import 'package:flutter_jenkins_client/view.dart';
import 'package:my_jenkins/global/tool/collections.dart';
import 'package:my_jenkins/global/tool/jenkins_client.dart';
import 'package:my_jenkins/global/tool/logger.dart';
import 'package:my_jenkins/view/jobs_list_widget.dart';

class ViewsWidget extends StatefulWidget {
  ViewsWidget({Key key}) : super(key: key);

  @override
  _ViewsWidgetState createState() => _ViewsWidgetState();
}

class _ViewsWidgetState extends State<ViewsWidget> {
  var _currentPanelIndex = -1; //设置 -1 默认全部闭合
  var _loadingText = 'Loading...';
  var _activeView = '';
  List<View> _views = [];

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

  void _onViewClick(panelIndex, isExpanded) {
    logger.d(
        '_ViewsWidgetState#_onViewClick(): panelIndex=$panelIndex, isExpanded=$isExpanded');
    setState(() {
      _currentPanelIndex = (_currentPanelIndex != panelIndex ? panelIndex : -1);
      if (_currentPanelIndex != -1) {
        _activeView = _views[_currentPanelIndex].name;
      } else {
        _activeView = '';
      }
      logger.d(
          '_ViewsWidgetState#_onViewClick(): _currentPanelIndex=$_currentPanelIndex, _activeView=$_activeView');
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
              var description =
                  view.description != null ? view.description : '';
              return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(name),
                    subtitle: Text(Uri.decodeComponent(description)),
                    onTap: () {
                      _onViewClick(index, isExpanded);
                    },
                  );
                },
                body: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
                  child: JobsListWidget(
                      view: name, show: _activeView == name),
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
