import 'package:flutter/material.dart';

class AppStateProvider extends StatefulWidget{

  final Widget child;

  const AppStateProvider({Key key, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
  
  static _InheritedAppState of(BuildContext context){
    return context.inheritFromWidgetOfExactType(_InheritedAppState) as _InheritedAppState;
  }
}

class _AppState extends State<AppStateProvider> {

  String name = "";

  void updateName(String newName){
    setState(() {
      name = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedAppState(appState: this, child: widget.child);
  }
}

class _InheritedAppState extends InheritedWidget{

  final _AppState appState;

  _InheritedAppState({this.appState, Widget child }) :  super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

}


void main() => runApp(AppStateProvider(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'A simple stuff'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    final stateContainer = AppStateProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Say your name',
            ),
            Text(
              '${stateContainer.appState.name}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          stateContainer.appState.updateName("${stateContainer.appState.name} anothertime");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

