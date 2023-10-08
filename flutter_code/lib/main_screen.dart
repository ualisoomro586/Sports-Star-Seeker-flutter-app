// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'auth_service.dart';

// import 'dart:developer';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  bool babar_p = false;
  bool shahid_p = false;
  bool imran_p = false;
  bool sania_p = false;
  bool virat_p = false;
  File? _image;
  File? _image2;
  String fullbaseString = '';
  bool isLoading = false;
  String result = "No result";
  String age = '';
  String profession = '';
  String team = '';
  String tempresult = "";
  String tempage = "";
  String tempProfession = '';
  String tempTeam = '';
  String babar_azam = '0%';
  String virat_kohli = '0%';
  String sania_mirza = '0%';
  String imran_khan = '0%';
  String shahid_afridi = '0%';
  String babar_age = '29';
  String babar_team = "Pakistan";
  String babar_profession = 'Cricketer';
  String shahid_age = '46';
  String shahid_team = "Pakistan";
  String shahid_profession = 'Cricketer';
  String sania_age = '37';
  String sania_team = "India";
  String sania_profession = 'Tennis Player';
  String imran_age = '71';
  String imran_team = "Pakistan";
  String imran_profession = 'Cricketer';
  String virat_age = '35';
  String virat_team = "India";
  String virat_profession = 'Cricketer';
  String noresult = 'No result';

  // check internet connectivity wheter responce are comming or not
  Future<bool> checkInternetConnectivity() async {
    try {
      final response = await http.get(
        Uri.parse('http://usmansoomro.pythonanywhere/hello'),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  //Making Http request to server
  Future<void> _sendDataToServer() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.post(
          Uri.parse("https://usmansoomro.pythonanywhere.com/classify_image"),
          body: {'image_data': fullbaseString});
      if (response.statusCode == 200) {
        String jsondata = response.body;
        List<dynamic> jsonList = convert.json.decode(jsondata);
        if (jsonList.isNotEmpty) {
          String selectedClass = jsonList[0]['class'];

          List<double> classProbability =
              List<double>.from(jsonList[0]['class_probability']);

          // Printing class probabilities

          if (selectedClass == 'babar_azam') {
            tempresult = "Name: Babar Azam";
            tempage = "Age: " + babar_age;
            tempProfession = "Profession: " + babar_profession;
            tempTeam = "Team: " + babar_team;
            babar_p = true;
            shahid_p = false;
            imran_p = false;
            sania_p = false;
            virat_p = false;
          } else if (selectedClass == 'virat_kohli') {
            tempresult = "Virat Kohli";
            tempage = "Age: " + virat_age;
            tempProfession = "Profession: " + virat_profession;
            tempTeam = "Team: " + virat_team;
            virat_p = true;
            babar_p = false;
            shahid_p = false;
            imran_p = false;
            sania_p = false;
          } else if (selectedClass == 'shahid_afridi') {
            tempresult = "Name: Shahid Afridi";
            tempage = "Age: " + shahid_age;
            tempProfession = "Profession: " + shahid_profession;
            tempTeam = "Team: " + shahid_team;
            shahid_p = true;
            babar_p = false;
            imran_p = false;
            sania_p = false;
            virat_p = false;
          } else if (selectedClass == 'imran_khan') {
            tempresult = "Name: Imran Khan";
            tempage = "Age: " + imran_age;
            tempProfession = "Profession: " + imran_profession;
            tempTeam = "Team: " + imran_team;
            imran_p = true;
            babar_p = false;
            shahid_p = false;

            sania_p = false;
            virat_p = false;
          } else if (selectedClass == 'sania_mirza') {
            tempresult = "Name Sania Mirza";
            tempage = "Age: " + sania_age;
            tempProfession = "Profession: " + sania_profession;
            tempTeam = "Team: " + sania_team;
            sania_p = true;
            babar_p = false;
            shahid_p = false;
            imran_p = false;
            virat_p = false;
          } else {
            tempresult = "Nothing";
          }

          // final jsonResponse = convert.json.decode(response.body);
          // print(jsonResponse);

          // Clear loading state after receiving the response
          setState(() {
            age = tempage;
            profession = tempProfession;
            team = tempTeam;
            result = tempresult;
            _image2 = _image;
            babar_azam = classProbability[0].toString() + "%";
            imran_khan = classProbability[1].toString() + "%";
            sania_mirza = classProbability[2].toString() + "%";
            shahid_afridi = classProbability[3].toString() + "%";
            virat_kohli = classProbability[4].toString() + "%";
            isLoading = false;
          });
        } else {
          print("List is empty");
          setState(() {
            isLoading = false;
            noresult = "Error: Can't identify face or eyes properly";
            _image2 = null;
            babar_azam = '0%';
            shahid_afridi = '0%';
            sania_mirza = '0%';
            imran_khan = '0%';
            virat_kohli = '0%';

            babar_p = false;
            imran_p = false;
            shahid_p = false;
            sania_p = false;
            virat_p = false;
          });
        }
      } else {
        // Handle non-200 status codes if needed
        print("internal error");
        // Clear loading state on error
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        isLoading = false;
      });
    }
  }

  // Image picker method
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // change image to base64
      if (_image != null) {
        List<int> imageBytes = _image!.readAsBytesSync();

        fullbaseString =
            "data:image/jpeg;base64,${convert.base64Encode(imageBytes)}";

        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
        ].request();

        if (statuses[Permission.storage] == PermissionStatus.granted) {
          // ProDirectory root = await getTemporaryDirectory();
          Directory root = await getApplicationDocumentsDirectory();
          File f = File(root.path + '/file.txt');
          await f.writeAsString(fullbaseString).then((value) async {
            //await OpenFile.open('file.txt');
          });
        } else {
          // Handle the case where permission is denied
        }
      } else {
        print("No image Selectd");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Uint8List imageBytes = decodeBase64ToBytes(fullbaseString);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sports Star Seeker"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout_sharp),
              onPressed: () {
                AuthService().signOut(context);
              },
            ),
          ],
        ),
        drawer: const drawer(),
        body: Stack(children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Sport Persons",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: Column(children: [
                              Container(
                                width: 80,
                                height: 80,

                                decoration: const BoxDecoration(
                                  shape: BoxShape
                                      .circle, // Set the shape to circular
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/babar2.jpeg'), // Replace with your image asset
                                    fit: BoxFit
                                        .cover, // You can adjust the fit as needed
                                  ),
                                ),
                                // child: Image.asset("assets/babar2.jpeg"),
                              ),
                              const Text("Babar Azam")
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: Column(children: [
                              Container(
                                width: 80,
                                height: 80,

                                decoration: const BoxDecoration(
                                  shape: BoxShape
                                      .circle, // Set the shape to circular
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/virat4.jpeg'), // Replace with your image asset
                                    fit: BoxFit
                                        .cover, // You can adjust the fit as needed
                                  ),
                                ),
                                // child: Image.asset("assets/babar2.jpeg"),
                              ),
                              const Text("Virat Kholi")
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: Column(children: [
                              Container(
                                width: 80,
                                height: 80,

                                decoration: const BoxDecoration(
                                  shape: BoxShape
                                      .circle, // Set the shape to circular
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/sania1.jpeg'), // Replace with your image asset
                                    fit: BoxFit
                                        .cover, // You can adjust the fit as needed
                                  ),
                                ),
                                // child: Image.asset("assets/babar2.jpeg"),
                              ),
                              const Text("Sania Mirza")
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: Column(children: [
                              Container(
                                width: 80,
                                height: 80,

                                decoration: const BoxDecoration(
                                  shape: BoxShape
                                      .circle, // Set the shape to circular
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/imran4.jpeg'), // Replace with your image asset
                                    fit: BoxFit
                                        .cover, // You can adjust the fit as needed
                                  ),
                                ),
                                // child: Image.asset("assets/babar2.jpeg"),
                              ),
                              const Text("Imran Khan")
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: Column(children: [
                              Container(
                                width: 80,
                                height: 80,

                                decoration: const BoxDecoration(
                                  shape: BoxShape
                                      .circle, // Set the shape to circular
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/shahid1.jpeg'), // Replace with your image asset
                                    fit: BoxFit
                                        .cover, // You can adjust the fit as needed
                                  ),
                                ),
                                // child: Image.asset("assets/babar2.jpeg"),
                              ),
                              const Text("Shahid Afridi")
                            ]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      orientation == Orientation.portrait
                          ? Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                height: height * 0.25,
                                width: width * 0.45,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Colors.black, // Set the border color
                                      width: 2.0,
                                      // Set the border width
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons
                                          .upload_file, // Specify the icon you want to use
                                      size: 48.0, // Set the icon size
                                      color: Colors.black, // Set the icon color
                                    ),
                                    const Text(
                                      "Upload a Image",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 4),
                                    ElevatedButton(
                                        onPressed: _pickImage,
                                        child: const Text("Upload")),
                                    if (_image != null)
                                      Image.file(
                                        _image!,
                                        width: 60,
                                        height: 50,
                                      )
                                    else
                                      const Text('No image selected',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ))
                          : Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                height: height * 0.4,
                                width: width * 0.45,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Colors.black, // Set the border color
                                      width: 2.0, // Set the border width
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Upload a Image",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 4),
                                    ElevatedButton(
                                        onPressed: _pickImage,
                                        child: const Text("Upload")),
                                    if (_image != null)
                                      Image.file(
                                        _image!,
                                        width: 60,
                                        height: 50,
                                      )
                                    else
                                      const Text(
                                        'No image selected',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      )
                                  ],
                                ),
                              )),
                      orientation == Orientation.portrait
                          ? Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                height: height * 0.25,
                                width: width * 0.45,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Colors.black, // Set the border color
                                      width: 2.0, // Set the border width
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Result",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      if (_image2 != null)
                                        Column(children: [
                                          Image.file(
                                            _image2!,
                                            width: 60,
                                            height: 60,
                                          ),
                                          const SizedBox(height: 10),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  result,
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  age,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  profession,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  team,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ])
                                        ])
                                      else
                                        Column(children: [
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          Text(
                                            noresult,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),

                                      // Image.memory(_imagebytes,
                                      //     width: 100, height: 100),

                                      // Text('$fullbaseString'),
                                      SizedBox(height: 4),
                                    ],
                                  ),
                                ),
                              ))
                          : Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                height: height * 0.4,
                                width: width * 0.45,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Colors.black, // Set the border color
                                      width: 2.0, // Set the border width
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Result",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      if (_image2 != null)
                                        Column(children: [
                                          Image.file(
                                            _image2!,
                                            width: 50,
                                            height: 60,
                                          ),
                                          const SizedBox(height: 10),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  result,
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  age,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  profession,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  team,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ])
                                        ])
                                      else
                                        Column(children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            noresult,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                      const SizedBox(height: 4),
                                    ],
                                  ),
                                ),
                              ))
                    ]),
                    orientation == Orientation.portrait
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(35, 10, 10, 10),
                            child: ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () => _sendDataToServer(),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.greenAccent),
                                ),
                                child: const Text('Classify')),
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(35, 10, 10, 10),
                            child: ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () => _sendDataToServer(),
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      Size(width * 0.3, 50.0)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.greenAccent),
                                ),
                                child: const Text('Classify')),
                          ),
                    orientation == Orientation.portrait
                        ? Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              height: height * 0.3,
                              width: width * 9,
                              child: Table(
                                defaultColumnWidth: FixedColumnWidth(120.0),
                                border: TableBorder.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 2),
                                children: [
                                  const TableRow(children: [
                                    Column(children: [
                                      Text('Name',
                                          style: TextStyle(fontSize: 25.0))
                                    ]),
                                    Column(children: [
                                      Text('Probability',
                                          style: TextStyle(fontSize: 25.0))
                                    ]),
                                  ]),
                                  TableRow(children: [
                                    const Column(children: [
                                      Text(
                                        'Babar Azam',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                    Column(children: [
                                      babar_p
                                          ? Text(
                                              babar_azam,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(babar_azam)
                                    ]),
                                  ]),
                                  TableRow(children: [
                                    const Column(children: [
                                      Text('Virat Kohli',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold))
                                    ]),
                                    Column(children: [
                                      virat_p
                                          ? Text(virat_kohli,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold))
                                          : Text(virat_kohli)
                                    ]),
                                  ]),
                                  TableRow(children: [
                                    const Column(children: [
                                      Text('Sania Mirza',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold))
                                    ]),
                                    Column(children: [
                                      sania_p
                                          ? Text(sania_mirza,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold))
                                          : Text(sania_mirza)
                                    ]),
                                  ]),
                                  TableRow(children: [
                                    const Column(children: [
                                      Text('Imran Khan',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold))
                                    ]),
                                    Column(children: [
                                      imran_p
                                          ? Text(imran_khan,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold))
                                          : Text(imran_khan)
                                    ]),
                                  ]),
                                  TableRow(children: [
                                    const Column(children: [
                                      Text('Shahid Afridi',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold))
                                    ]),
                                    Column(children: [
                                      shahid_p
                                          ? Text(shahid_afridi,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold))
                                          : Text(shahid_afridi)
                                    ]),
                                  ]),
                                ],
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              height: height * 0.41,
                              width: width * 9,
                              child: Table(
                                defaultColumnWidth: FixedColumnWidth(120.0),
                                border: TableBorder.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 2),
                                children: [
                                  const TableRow(children: [
                                    Column(children: [
                                      Text('Name',
                                          style: TextStyle(fontSize: 25.0))
                                    ]),
                                    Column(children: [
                                      Text('Probability',
                                          style: TextStyle(fontSize: 25.0))
                                    ]),
                                  ]),
                                  TableRow(children: [
                                    const Column(children: [
                                      Text(
                                        'Babar Azam',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                    Column(children: [
                                      babar_p
                                          ? Text(
                                              babar_azam,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(babar_azam)
                                    ]),
                                  ]),
                                  TableRow(children: [
                                    const Column(children: [
                                      Text('Virat Kohli',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold))
                                    ]),
                                    Column(children: [
                                      virat_p
                                          ? Text(virat_kohli,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold))
                                          : Text(virat_kohli)
                                    ]),
                                  ]),
                                  TableRow(children: [
                                    const Column(children: [
                                      Text('Sania Mirza',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold))
                                    ]),
                                    Column(children: [
                                      sania_p
                                          ? Text(sania_mirza,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold))
                                          : Text(sania_mirza)
                                    ]),
                                  ]),
                                  TableRow(children: [
                                    const Column(children: [
                                      Text('Imran Khan',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold))
                                    ]),
                                    Column(children: [
                                      imran_p
                                          ? Text(imran_khan,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold))
                                          : Text(imran_khan)
                                    ]),
                                  ]),
                                  TableRow(children: [
                                    const Column(children: [
                                      Text('Shahid Afridi',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold))
                                    ]),
                                    Column(children: [
                                      shahid_p
                                          ? Text(shahid_afridi,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold))
                                          : Text(shahid_afridi)
                                    ]),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                  ]),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ]));
  }
}
