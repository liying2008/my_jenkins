import 'package:flutter/material.dart';
import 'package:flutter_jenkins_client/jenkins_client.dart';
import 'package:flutter_jenkins_client/view.dart';
import 'package:my_jenkins/global/constant/constants.dart';
import 'package:my_jenkins/global/tool/collections.dart';

class ViewsPage extends StatefulWidget {
  ViewsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ViewsPageState createState() => _ViewsPageState();
}

class _ViewsPageState extends State<ViewsPage> {
  var currentPanelIndex = -1; //设置 -1 默认全部闭合
  List<View> _views = [];
  final jenkinsClient = JenkinsClient(JENKINS_URL, USERNAME, PASSWORD);

  _ViewsPageState() {
    _getAllViews();
  }

  _getAllViews() async {
    var views = await jenkinsClient.getViews();
    views.forEach((name, view) {
      _views.add(view);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Text('Title'),
            new ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  currentPanelIndex =
                      (currentPanelIndex != panelIndex ? panelIndex : -1);
                });
              },
              children: mapIndexed(_views, (index, view) {
                var name = view.name;
                var url = view.url;
                return new ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return new ListTile(
                      title: new Text(name),
                    );
                  },
                  body: new Padding(
                    padding: EdgeInsets.all(30.0),
                    child: new ListBody(
                      children: <Widget>[
                        new Text(name),
                        new Text(url),
                      ],
                    ),
                  ),
                  isExpanded: currentPanelIndex == index,
                );
              }).toList(),
            ),
            new Text('Tail'),
//            new ListView.builder(
//                itemBuilder: (BuildContext context, int index){
//                  return new ListTile(
//                    leading: new Icon(Icons.add),
//                    title: new Text('111'),
//                  );
//                },
//              itemCount: 1,
//            ),
          ],
        ),
      ),
    );
  }
}
