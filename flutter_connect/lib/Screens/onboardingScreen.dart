import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  OnboardingScreenType currentScreen = OnboardingScreenType.basicWidget;
  PageController pageViewController;
  Map<OnboardingScreenType, int> selectedLevels =
      Map<OnboardingScreenType, int>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageViewController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    _handleNextTapped() async {
      await pageViewController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.ease);
    }

    return Scaffold(
        body: PageView.builder(
            itemCount: 7,
            controller: pageViewController,
            itemBuilder: (c, index) {
              OnboardingScreenType type = OnboardingScreenType.introduction;

              switch (index) {
                case 0:
                  type = OnboardingScreenType.introduction;
                  break;
                case 1:
                  type = OnboardingScreenType.basicWidget;
                  break;
                case 2:
                  type = OnboardingScreenType.stateManagement;
                  break;
                case 3:
                  type = OnboardingScreenType.data;
                  break;
                case 4:
                  type = OnboardingScreenType.asynchronous;
                  break;
                case 5:
                  type = OnboardingScreenType.advanceUI;
                  break;
                case 6:
                  type = OnboardingScreenType.advanvedTopics;
                  break;
              }

              return SingleScreen(type, (level) {
                selectedLevels.putIfAbsent(type, () => level);
                _handleNextTapped();
              });
            }));
  }
}

enum OnboardingScreenType {
  introduction,
  basicWidget,
  stateManagement,
  data,
  asynchronous,
  advanceUI,
  advanvedTopics
}

class SingleScreen extends StatefulWidget {
  final OnboardingScreenType type;
  final Function(int level) nextTapped;
  SingleScreen(this.type, this.nextTapped);

  @override
  _SingleScreenState createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 40, 0, 20),
      color: colorForType(),
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  titleForType(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: contentForType())
            ],
          ),
          if (widget.type == OnboardingScreenType.introduction)
            Positioned(
              right: 0,
              bottom: 20,
              child: FlatButton.icon(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () => widget.nextTapped(null),
                label: Container(),
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            )
        ],
      ),
    );
  }

  Color colorForType() {
    switch (widget.type) {
      case OnboardingScreenType.introduction:
        return Colors.blueAccent;
      case OnboardingScreenType.basicWidget:
        return Colors.deepOrangeAccent;
      case OnboardingScreenType.stateManagement:
        return Colors.orange;
      case OnboardingScreenType.data:
        return Colors.deepPurple;
      case OnboardingScreenType.asynchronous:
        return Colors.teal;
      case OnboardingScreenType.advanceUI:
        return Colors.indigo;
      case OnboardingScreenType.advanvedTopics:
        return Colors.lime;
      default:
        return Colors.purpleAccent;
    }
  }

  String titleForType() {
    switch (widget.type) {
      case OnboardingScreenType.introduction:
        return "Please answer the following questions on Flutter\n\nWe will use your answers to customize your experience";
      case OnboardingScreenType.basicWidget:
        return "Basic UI Knowledge";
      case OnboardingScreenType.stateManagement:
        return "State Management";
      case OnboardingScreenType.data:
        return "Processing Data";
      case OnboardingScreenType.asynchronous:
        return "Asynchronous";
      case OnboardingScreenType.advanceUI:
        return "Advanced UI";
      case OnboardingScreenType.advanvedTopics:
        return "Advanced Topics";
      default:
        return "";
    }
  }

  Widget contentForType() {
    if (widget.type == OnboardingScreenType.introduction) {
      return Container();
    }
    return QuestionSelectionWidget(widget.type, (levelSelected) {
      widget.nextTapped(levelSelected);
      print(levelSelected);
    });
  }
}

class QuestionSelectionWidget extends StatefulWidget {
  final OnboardingScreenType screenType;
  final Function(int level) didSelectLevel;

  QuestionSelectionWidget(this.screenType, this.didSelectLevel, {Key key})
      : super(key: key);

  _QuestionSelectionWidgetState createState() =>
      _QuestionSelectionWidgetState();
}

class _QuestionSelectionWidgetState extends State<QuestionSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: questionWidgetsFromQuestions(questionsForType()));
  }

  List<Widget> questionWidgetsFromQuestions(List<String> questionStrings) {
    List<Widget> questions = [];

    for (var i = 0; i < questionStrings.length; i++) {
      final question = questionStrings[i];
      questions.add(RaisedButton(
          color: Colors.white,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          onPressed: () => widget.didSelectLevel(i + 1),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              question,
              textAlign: TextAlign.center,
            ),
          )));

      if (i < questionStrings.length - 1) {
        questions.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_downward,
            color: Colors.white,
          ),
        ));
      }
    }

    return questions;
  }

  List<String> questionsForType() {
    switch (widget.screenType) {
      case OnboardingScreenType.basicWidget:
        return [
          'It Runs!',
          'I can position widgets in a Row or Column',
          'Building lists with dynamic content is easy!',
          'Global themes have been applied throughout the app',
          'I can overlay widgets ontop of each other',
        ];
      case OnboardingScreenType.stateManagement:
        return [
          'I know the difference between a StateLESS and StateFULL widget',
          'Changing the color of my FAB using setState() is simple',
          'Using Inherited Widget to update the data throughout my app is easy'
              'I have used other techniques such as Bloc or Provider',
        ];
      case OnboardingScreenType.data:
        return [
          'I have made API request before using dart:api',
          'Serializing JSON to my pre defined models was simple',
          'I can save key value pairs using SharedPreferences'
              'I have a fully functioning relational SQL database using sqflite',
        ];

      case OnboardingScreenType.asynchronous:
        return [
          'Never Used',
          'Have used async & await to grab information',
          'Utilised Futures and Streams',
          'Integrated FutureBuilders and StreamBuilders in my Widget tree to update the UI when new data becomes available'
        ];
      case OnboardingScreenType.advanceUI:
        return [
          'Never Used',
          'Created tween animations to make my UI pop!',
          'Used Hero widgets for transitioning between screens',
          'Know about Widgets Sliver counterparts to take the UX to the next level'
        ];
      case OnboardingScreenType.advanvedTopics:
        return [
          'Not for me yet',
          'Added Flutter into my existing iOS or Android App',
          'I\'m ahead of the game and have already created a website using FlutterWeb',
        ];
      default:
        return [];
    }
  }
}
