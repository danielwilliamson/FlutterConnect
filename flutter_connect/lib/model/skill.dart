class Skills{
  int basicUIKnowledge;
  int stateManagement;
  int data;
  int asynchronous;
  int advancedUI;
  int advancedTopics;


  Skills.fromJson(Map<String, dynamic> json) {
    this.basicUIKnowledge = json["Basic UI Knowledge"];
    this.stateManagement = json["State Management"];
    this.data = json["Data"];
    this.asynchronous = json["Asynchronous"];
    this.advancedUI = json["Advanced UI"];
    this.advancedTopics = json["Advanced Topics"];
  }
}