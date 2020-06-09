class ClassItems {
  String startTime;
  String endTime;
  String courseTitle;

  ClassItems(this.startTime,this.endTime,this.courseTitle);

}

int hr,min;

String timeFormat(hr,min){
  return "$hr:$min";
}

var dayList = [
  monClassList,
  tueClassList,
  wedClassList,
  thrClassList,
  friClassList,
];

var monClassList =
[
  ClassItems( timeFormat(10,00),timeFormat(10, 55) ,"Intro to Life Sciences"),
  ClassItems( timeFormat(11,00),timeFormat(11, 55) ,"Environment and Energy"),
  ClassItems( timeFormat(14,30),timeFormat(15, 55) ,"Intro to HDL")
];

var tueClassList =
[
  ClassItems( timeFormat(10,00),timeFormat(12, 55) ,"Intro to Data Structures"),
  ClassItems( timeFormat(14,30),timeFormat(15, 55) ,"Discrete Structures"),
  ClassItems( timeFormat(16,00),timeFormat(17, 25) ,"Differential Equation")
];

var wedClassList =
[
  ClassItems( timeFormat(9,00),timeFormat(9, 55) ,"Intro to Life Sciences"),
  ClassItems( timeFormat(10,00),timeFormat(10, 55) ,"Environment and Energy")
];

var thrClassList =
[
  ClassItems( timeFormat(9,00),timeFormat(9, 55) ,"Environment and Energy"),
  ClassItems( timeFormat(11,00),timeFormat(11, 55) ,"Intro to Life Sciences"),
  ClassItems( timeFormat(16,00),timeFormat(17, 25) ,"Intro to HDL")
];

var friClassList =
[
  ClassItems( timeFormat(14,30),timeFormat(15, 55) ,"Differential Equation"),
  ClassItems( timeFormat(16,00),timeFormat(17, 25) ,"Discrete Structures")
];

