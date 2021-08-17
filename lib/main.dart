import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String lastname = "";
  int age = 0;
  String selectedGender = "";

  bool isOption1 = false;
  bool isOption2 = false;
  bool isOption3 = false;
  List<String> selectOption = [];

  void _setGender(String value) {
    print(value);
    setState(() {
      selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Form'),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(20.0),
              // Form
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // ชื่อ
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text("ชื่อ"),
                          TextFormField(
                            onChanged: (value) => setState(() {
                              name = value.toString();
                            }),
                          ),
                        ],
                      ),
                    ),
                    // นามสกุล
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: <Widget>[
                          Text("นามสกุล"),
                          TextFormField(
                            onChanged: (value) => setState(() {
                              lastname = value.toString();
                            }),
                          ),
                        ],
                      ),
                    ),
                    // อายุ
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: <Widget>[
                          Text("อายุ"),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) => setState(() {
                              age = int.parse(value);
                            }),
                          ),
                        ],
                      ),
                    ),
                    // เพศ
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: <Widget>[
                          Text("เพศ"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('Male'),
                              Radio(
                                  value: 'Male',
                                  groupValue: selectedGender,
                                  onChanged: (value) =>
                                      _setGender(value.toString())),
                              Text('Female'),
                              Radio(
                                  value: 'Female',
                                  groupValue: selectedGender,
                                  onChanged: (value) =>
                                      _setGender(value.toString()))
                            ],
                          ),
                        ],
                      ),
                    ),
                    // อาการ
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: <Widget>[
                          Text("อาหารป่วย"),
                          CheckboxListTile(
                              title: Text('ไอ'),
                              value: isOption1,
                              onChanged: (value) => {
                                    setState(() {
                                      isOption1 = !isOption1;
                                      if (isOption1) {
                                        selectOption.add('ไอ');
                                      } else {
                                        selectOption.remove('ไอ');
                                      }
                                      print(selectOption);
                                    })
                                  }),
                          CheckboxListTile(
                              title: Text('มีไข้'),
                              value: isOption2,
                              onChanged: (value) => {
                                    setState(() {
                                      isOption2 = !isOption2;
                                      if (isOption2) {
                                        selectOption.add('มีไข้');
                                      } else {
                                        selectOption.remove('มีไข้');
                                      }
                                      print(selectOption);
                                    })
                                  }),
                          CheckboxListTile(
                              title: Text('เจ็บหน้าอก'),
                              value: isOption3,
                              onChanged: (value) => {
                                    setState(() {
                                      isOption3 = !isOption3;
                                      if (isOption3) {
                                        selectOption.add('เจ็บหน้าอก');
                                      } else {
                                        selectOption.remove('เจ็บหน้าอก');
                                      }
                                      print(selectOption);
                                    })
                                  }),
                        ],
                      ),
                    ),
                    RaisedButton(
                      onPressed: () => {
                        if (name != '')
                          {
                            print(name),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Page1(
                                        name: name,
                                        lastname: lastname,
                                        gender: selectedGender,
                                        age: age,
                                        menu: selectOption)))
                          }
                      },
                      child: Text('Save'),
                    )
                  ],
                ),
              )),
        ));
  }
}

// หน้าที่1
class Page1 extends StatelessWidget {
  Page1(
      {required this.name,
      required this.lastname,
      required this.gender,
      required this.age,
      required this.menu});

  final String name;
  final String lastname;
  final String gender;
  final int age;
  final List<String> menu;

  final String description = 'Page2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานผลผู้ป่วย'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            covidDetect(menu),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Page2(
                    description: description,
                  )),
        ),
        child: Text('ยืนยัน'),
      ),
    );
  }

  Widget covidDetect(List<String> menu) {
    if (menu.length == 3) {
     return Container(
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network('https://cdn.pixabay.com/photo/2020/04/29/07/54/coronavirus-5107715_960_720.png', 
              width: 150,
              height: 250,
              ),
              Text(
                'คุณ $name $lastname อายุ $ageปี ,คุณติดโควิด',
                style: TextStyle(fontSize: 20),
              ),
            ],
          )));
    } else {
      return Container(
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network('https://cdn.pixabay.com/photo/2020/03/22/10/17/covid-19-4956579_960_720.png', 
              width: 150,
              height: 250,
              ),
              Text(
                'คุณ $name $lastname อายุ $ageปี ,คุณไม่ติดโควิด',
                style: TextStyle(fontSize: 20),
              ),
            ],
          )));
    }
  }
}

// หน้าที่2

class Page2 extends StatelessWidget {
  Page2({required this.description});

  final String description;
  final String pageName = 'Page 2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pageName),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15.0),
              child: Text(description),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Page3())),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.ac_unit,
                          color: Colors.blueGrey,
                        ),
                        Text('Page3')
                      ],
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                  color: Colors.amber,
                  onPressed: () => Navigator.pop(context),
                  child: Container(
                    width: 90,
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.blueGrey,
                        ),
                        Text('  back')
                      ],
                    ),
                  )),
            )
          ],
        )));
  }
}

// หน้าที่3

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('Page3'),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                  color: Colors.amber,
                  onPressed: () => Navigator.pop(context),
                  child: Container(
                    width: 90,
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.blueGrey,
                        ),
                        Text('  back')
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
