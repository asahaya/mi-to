import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '03_chart.dart';
import '03_stream.dart';

int sunAmount = 0;
int monAmount = 0;
int tueAmount = 0;
int wedAmount = 0;
int thuAmount = 0;
int friAmount = 0;
int satAmount = 0;
List<int> youbi_amount_List = [0, 0, 0, 0, 0, 0, 0];

final user = FirebaseAuth.instance.currentUser;
// final Stream<QuerySnapshot> _usersStream =
//     FirebaseFirestore.instance.collection('users').snapshots();
final Stream<QuerySnapshot<Map<String, dynamic>>> usersStreamA =
    FirebaseFirestore.instance.collection('users').snapshots();
// final ur= Authc.signInWithGoogle.photoUrl;

class NewTabs {
  final String? title;
  final Color? color;
  NewTabs({this.title, this.color});
}

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation>
    with SingleTickerProviderStateMixin {
  final TextEditingController _fullNameCon = TextEditingController();
  final TextEditingController _comCon = TextEditingController();

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  List<bool> isSelected = [false, false, false, false, false, false, false];
  List<String> textList = ["月", "火", "水", "木", "金", "土", "日"];
  List<String> textYoubiList = ["", "", "", "", "", "", ""];
  DateTime selectedTime = DateTime(2023, 1, 1, DateTime.now().hour, 00);
  DateTime baseTime = DateTime(2023, 1, 1, DateTime.now().hour, 00);
  //tabController]
  final List<NewTabs> _tabsL = [
    NewTabs(title: "SUNDAY", color: Colors.yellow),
    NewTabs(title: "MONDAY", color: Colors.red),
    NewTabs(title: "TUESDAY", color: Colors.red),
    NewTabs(title: "WEDNESDAY", color: Colors.red),
    NewTabs(title: "THURSDAY", color: Colors.red),
    NewTabs(title: "FRIDAY", color: Colors.red),
    NewTabs(title: "SATURDAY", color: Colors.red)
  ];
  NewTabs? _myHundlar;
  TabController? _tabCon;
  String currentTitle = '';

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void initState() {
    super.initState();
    currentTitle = _tabsL[0].title!;
    _tabCon = TabController(length: 7, vsync: this);
    _myHundlar = _tabsL[0];
    _tabCon!.addListener(_handleSelected);
  }

  @override
  void dispose() {
    _tabCon!.dispose();
    super.dispose();
  }

  void _handleSelected() {
    setState(() {
      _myHundlar = _tabsL[_tabCon!.index];
      currentTitle = _myHundlar!.title ?? "";
    });
  }

  //
  double _sliderValue = 1;
  String _sliderLabelText = '選択しましょう';

  Color colorLevel = Colors.black;

  String sliderTextSwitch(double sl_value) {
    switch (sl_value.toInt()) {
      case 1:
        _sliderLabelText = 'LEVEL:1';
        colorLevel = Colors.blue;
        break;
      case 2:
        _sliderLabelText = 'LEVEL:2';
        colorLevel = Colors.green;
        break;
      case 3:
        _sliderLabelText = 'LEVEL:3';
        colorLevel = Colors.yellow;
        break;
      case 4:
        _sliderLabelText = 'LEVEL:4';
        colorLevel = Colors.purple.shade800;
        break;
      case 5:
        _sliderLabelText = 'LEVEL:5';
        colorLevel = Colors.red;
        break;
    }
    return _sliderLabelText;
  }

  Color sliderColorSwitch(double sl_value) {
    switch (sl_value.toInt()) {
      case 1:
        colorLevel = Colors.blue;
        break;
      case 2:
        colorLevel = Colors.green;
        break;
      case 3:
        colorLevel = Colors.yellow;
        break;
      case 4:
        colorLevel = Colors.purple.withOpacity(0.7);
        break;
      case 5:
        colorLevel = Colors.red;
        break;
    }
    return colorLevel;
  }

  Future<void> _add_or_update([DocumentSnapshot? docSS]) async {
    String mode = "追加";
    selectedTime = baseTime;
    _sliderLabelText = '';

    if (docSS != null) {
      mode = "更新";
      //c
      _fullNameCon.text = docSS['full_name'];
      _comCon.text = docSS['company'];
      _sliderValue = docSS['priorityLevel'];
      _sliderLabelText = sliderTextSwitch(_sliderValue);

      isSelected = [
        docSS['youbi'][0],
        docSS['youbi'][1],
        docSS['youbi'][2],
        docSS['youbi'][3],
        docSS['youbi'][4],
        docSS['youbi'][5],
        docSS['youbi'][6],
      ];
      textYoubiList = [
        docSS['youbi'][0] ? textList[0] : "",
        docSS['youbi'][1] ? textList[1] : "",
        docSS['youbi'][2] ? textList[2] : "",
        docSS['youbi'][3] ? textList[3] : "",
        docSS['youbi'][4] ? textList[4] : "",
        docSS['youbi'][5] ? textList[5] : "",
        docSS['youbi'][6] ? textList[6] : "",
      ];
      selectedTime = docSS['startTime'].toDate();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext cxt) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(cxt).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(2),
                    height: 50,
                    child: GridView.count(
                      crossAxisCount: 7,
                      primary: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                      children: List.generate(isSelected.length, (index) {
                        return TextButton(
                          onPressed: () {
                            setState(() {
                              isSelected[index] = !isSelected[index];
                            });
                          },
                          child: Text(
                            textList[index],
                            style: TextStyle(
                                color: isSelected[index]
                                    ? Colors.red
                                    : Colors.black),
                          ),
                        );
                      }),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("　開始時刻　　"),
                          Text(""),
                          Wrap(children: [
                            Text(
                              "※00:00-03:30は前曜日のリストに登録されます",
                              style: TextStyle(fontSize: 10),
                            )
                          ])
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            child: TextButton(
                              onPressed: () async {
                                await DatePicker.showTimePicker(context,
                                    showTitleActions: true,
                                    showSecondsColumn: false,
                                    onChanged: (date) {
                                  setState(() {
                                    selectedTime = date;
                                  });
                                }, onConfirm: (date) {
                                  setState(() {
                                    selectedTime = date;
                                  });
                                },
                                    currentTime: selectedTime,
                                    locale: LocaleType.jp);
                              },
                              child: Text(
                                selectedTime.hour.toString() +
                                    ":" +
                                    DateFormat('mm').format(selectedTime),
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("曜日選択"),
                                Row(
                                  children: [
                                    for (int i = 0; i < textList.length; i++)
                                      if (isSelected[i] == true)
                                        Text(
                                          "${textList[i]} ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _fullNameCon,
                    decoration: const InputDecoration(
                      labelText: '番組名を記入',
                    ),
                  ),
                  TextFormField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _comCon,
                    decoration: const InputDecoration(
                      labelText: '備考',
                    ),
                  ),
                  //
                  Row(
                    children: [
                      Text("優先度:"),
                      Text(_sliderLabelText.toString()),
                    ],
                  ),

                  Row(
                    children: [
                      Text('low'),
                      Expanded(
                        child: Slider(
                            min: 1,
                            max: 5,
                            divisions: 4,
                            value: _sliderValue,
                            onChanged: (double value) {
                              setState(() {
                                _sliderValue = value;
                                sliderTextSwitch(value);
                              });
                            }),
                      ),
                      Text('high'),
                    ],
                  ),
                  //
                  ElevatedButton(
                    onPressed: _sliderLabelText == "" ||
                            _fullNameCon.text == "" ||
                            isSelected.contains(true) == false
                        ? null
                        : () async {
                            final String? fullname = _fullNameCon.text;
                            final String? company = _comCon.text;
                            List<bool>? youbi = [
                              isSelected[0],
                              isSelected[1],
                              isSelected[2],
                              isSelected[3],
                              isSelected[4],
                              isSelected[5],
                              isSelected[6]
                            ];
                            textYoubiList = [
                              youbi[0] ? textList[0] : "",
                              youbi[1] ? textList[1] : "",
                              youbi[2] ? textList[2] : "",
                              youbi[3] ? textList[3] : "",
                              youbi[4] ? textList[4] : "",
                              youbi[5] ? textList[5] : "",
                              youbi[6] ? textList[6] : "",
                            ];

                            DateTime? shiteiTime = selectedTime;

                            if (fullname != null && company != null) {
                              if (mode == '追加') {
                                //c
                                //  var df1 = DateFormat('dd-MM-yyyy').parse('22-10-2019');
                                // var df2 = DateFormat('dd-MM-yyyy').parse('25-10-2019');
                                //  print(df1.isBefore(df2).toString());
                                var midnightLineTime =
                                    DateFormat('yyyy-MM-dd-HH-mm')
                                        .parse('2023-01-01-03-30');
                                // var settingTime=DateFormat('yyyy-MM-dd-HH-mm').parse('$shiteiTime');

                                bool midnightJudge = false;
                                midnightJudge =
                                    shiteiTime.isBefore(midnightLineTime);
                                print(midnightJudge);
                                //                               DateTime now = DateTime.now();
                                // DateFormat outputFormat = DateFormat('yyyy-MM-dd-Hm');
                                // String date = outputFormat.format(now);
                                // DateFormat outputHourFormat = DateFormat('HH');
                                // DateFormat outputMinuteFormat =
                                //     DateFormat('mm');

                                String reHour =
                                    DateFormat('HH').format(shiteiTime);
                                String reMinute =
                                    DateFormat("mm").format(shiteiTime);

                                //24:00-27:30
                                if (midnightJudge) {
                                  reHour = (int.parse(reHour) + 24).toString();

                                  textYoubiList = [
                                    youbi[0] ? textList[6] : "",
                                    youbi[1] ? textList[0] : "",
                                    youbi[2] ? textList[1] : "",
                                    youbi[3] ? textList[2] : "",
                                    youbi[4] ? textList[3] : "",
                                    youbi[5] ? textList[4] : "",
                                    youbi[6] ? textList[5] : "",
                                  ];
                                }

                                await _users.add({
                                  'full_name': fullname,
                                  'company': company,
                                  'youbi': youbi,
                                  'textYoubiList': textYoubiList,
                                  'startTime': shiteiTime,
                                  're_startTime': reHour + reMinute,
                                  'priorityLevel': _sliderValue,
                                  'uid': FirebaseAuth.instance.currentUser!.uid,
                                });
                                _sliderValue = 3;
                                ScaffoldMessenger.of(cxt).showSnackBar(SnackBar(
                                  backgroundColor: Colors.amber,
                                  content: Text(
                                    '${fullname}を追加しました',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ));
                              }
                              //c
                              if (mode == '更新') {
                                String reHour =
                                    DateFormat('HH').format(shiteiTime);
                                String reMinute =
                                    DateFormat("mm").format(shiteiTime);
                                await _users.doc(docSS!.id).update({
                                  'full_name': fullname,
                                  'company': company,
                                  'youbi': youbi,
                                  'textYoubiList': textYoubiList,
                                  'startTime': shiteiTime,
                                  'priorityLevel': _sliderValue,
                                  're_startTime': reHour + reMinute,
                                  'uid': FirebaseAuth.instance.currentUser!.uid,
                                });
                                ScaffoldMessenger.of(cxt).showSnackBar(SnackBar(
                                  backgroundColor: Colors.blueAccent,
                                  content: Text(
                                    '${fullname}を編集しました',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: const Color.fromARGB(
                                          255, 137, 56, 56),
                                    ),
                                  ),
                                ));
                              }
                              //reset
                              _fullNameCon.text = '';
                              _comCon.text = '';
                              youbi = [
                                false,
                                false,
                                false,
                                false,
                                false,
                                false,
                                false
                              ];

                              isSelected = [
                                false,
                                false,
                                false,
                                false,
                                false,
                                false,
                                false
                              ];
                              selectedTime =
                                  DateTime(2023, 1, 1, DateTime.now().hour, 00);
                              _sliderValue = 3;

                              Navigator.of(cxt).pop();
                            }
                          },
                    child: Text(mode == '追加' ? '追加' : '編集'),
                  ),
                ],
              ),
            );
          });
        });
  }

  //
  List<String> xxx = ["", "", "", "", "", "", ""];
  //   final user = FirebaseAuth.instance.currentUser;
  // String userUid = FirebaseAuth.instance.currentUser!.uid;
  //  String userUIDdata = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _deleteProduct(String productID) async {
    await _users.doc(productID).delete();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.grey,
      content: Text(
        '削除しました',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChartPage()),
                  );
                },
                icon: Icon(Icons.graphic_eq_rounded)),
            actions: [
              IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
            ],
            title: Text(
              currentTitle,
              style: TextStyle(letterSpacing: 10, fontFamily: 'bananas'),
            ),
            bottom: TabBar(
              controller: _tabCon,
              // dividerColor: Colors.blue,
              // indicatorColor: Colors.blue,
              labelStyle: const TextStyle(
                  fontFamily: 'bananas', letterSpacing: 0.01, fontSize: 10),
              tabs: const [
                Tab(text: "SUN"),
                Tab(text: "MON"),
                Tab(text: "TUE"),
                Tab(text: "WED"),
                Tab(text: "THU"),
                Tab(text: "FRI"),
                Tab(text: "SAT"),
              ],
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(child: seven_list_method(streamSUN, 'sun')),
                  Expanded(child: seven_list_method(streamMON, 'mon')),
                  Expanded(child: seven_list_method(streamTUE, 'tue')),
                  Expanded(child: seven_list_method(streamWED, 'wed')),
                  Expanded(child: seven_list_method(streamTHU, 'thu')),
                  Expanded(child: seven_list_method(streamFRI, 'fri')),
                  Expanded(child: seven_list_method(streamSAT, 'sat')),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: [
                        const Color(0xffe4a972).withOpacity(1.0),
                        Color.fromARGB(255, 41, 144, 162).withOpacity(1.0),
                      ],
                      stops: const [
                        0.0,
                        1.0,
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: _tabCon,
                      children: [
                        seven_list_method(usersStreamSUN, 'sun'),
                        seven_list_method(usersStreamMON, 'mon'),
                        seven_list_method(usersStreamTUE, 'tue'),
                        seven_list_method(usersStreamWED, 'wed'),
                        seven_list_method(usersStreamTHU, 'thu'),
                        seven_list_method(usersStreamFRI, 'fri'),
                        seven_list_method(usersStreamSAT, 'sat'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // );

          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.plus_one),
            label: Text('番組を追加する'),
            onPressed: () {
              _add_or_update();
            },
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> seven_list_method(
      Stream<QuerySnapshot<Map<String, dynamic>>> streamChoice,
      String youbi_select) {
    return StreamBuilder<QuerySnapshot>(
        stream: streamChoice,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamsnapshot) {
          //データがあるか
          if (streamsnapshot.hasError) {
            return Text('Something went wrong');
          }
          //通信、Scaffold1,データの破損
          if (streamsnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }
          if (streamsnapshot.data!.docs.length == 0) {
            return Center(child: Text('この曜日にはデータが登録されていません'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: streamsnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamsnapshot.data!.docs[index];

                      String dtdt = documentSnapshot['re_startTime'].toString();
                      bool heijitsu = false;

                      if (documentSnapshot[('youbi')][0] == true &&
                          documentSnapshot[('youbi')][0] == true &&
                          documentSnapshot[('youbi')][1] == true &&
                          documentSnapshot[('youbi')][2] == true &&
                          documentSnapshot[('youbi')][3] == true &&
                          documentSnapshot[('youbi')][4] == true) {
                        heijitsu = true;
                      } else {}
                      List<String> textYoubi = ["", "", "", "", "", "", ""];

                      for (int item = 0; item < isSelected.length; item++) {
                        if (documentSnapshot['youbi'][item] == true) {
                          textYoubi[item] += textList[item];
                          xxx[item] += textList[item];
                        }
                      }
                      //
                      List<String> displayYoubi = ["", "", "", "", "", "", ""];
                      for (int i = 0; i < textList.length; i++) {
                        if (documentSnapshot['youbi'][i] == true &&
                            heijitsu == false) {
                          displayYoubi[i] = textList[i];
                        }
                      }

                      switch (youbi_select) {
                        case 'sun':
                          youbi_amount_List[0] =
                              streamsnapshot.data!.docs.length;

                          break;
                        case 'mon':
                          youbi_amount_List[1] =
                              streamsnapshot.data!.docs.length;
                          break;
                        case 'tue':
                          youbi_amount_List[2] =
                              streamsnapshot.data!.docs.length;
                          break;
                        case 'wed':
                          youbi_amount_List[3] =
                              streamsnapshot.data!.docs.length;
                          break;
                        case 'thu':
                          youbi_amount_List[4] =
                              streamsnapshot.data!.docs.length;
                          break;
                        case 'fri':
                          youbi_amount_List[5] =
                              streamsnapshot.data!.docs.length;
                          break;
                        case 'sat':
                          youbi_amount_List[6] =
                              streamsnapshot.data!.docs.length;
                          break;
                        default:
                      }

                      // }
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              autoClose: true,
                              onPressed: (context) =>
                                  _add_or_update(documentSnapshot),
                              backgroundColor: const Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'edit',
                            ),
                            SlidableAction(
                              autoClose: true,
                              onPressed: (context) =>
                                  _deleteProduct(documentSnapshot.id),
                              backgroundColor: const Color(0xFF000000),
                              foregroundColor: Colors.white,
                              icon: Icons.delete_forever_sharp,
                              label: 'delete',
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 3, bottom: 10),
                          // padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 65,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white,
                                    Colors.white24
                                    // Colors.yellow
                                  ]),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.9),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 200,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, left: 10, right: 10),
                                    child: SizedBox(
                                      height: 50,
                                      width: 10,
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: sliderColorSwitch(
                                                    documentSnapshot[
                                                        'priorityLevel']),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                          ),
                                          Center(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                ((documentSnapshot[
                                                            'priorityLevel'])
                                                        .toInt())
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'bananaS'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 65,
                                    child: Text(
                                      // DateFormat('HH:mm').format(
                                      dtdt.substring(0, 2) +
                                          ":" +
                                          dtdt.substring(2, 4)
                                      // )
                                      ,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        // fontFamily: 'bananaS'
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: 50,
                                      child: Center(
                                        child: Text(
                                          heijitsu
                                              ? "平日"
                                              : displayYoubi.join(""),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      )),
                                  Expanded(
                                    flex: 10,
                                    child: SizedBox(
                                      width: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            documentSnapshot['full_name'],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          documentSnapshot['company'] == ""
                                              ? SizedBox(
                                                  height: 0, child: Text(""))
                                              : Text(
                                                  documentSnapshot['company'],
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        });
  }
}
