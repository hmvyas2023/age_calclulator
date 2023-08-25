import 'package:age_calculator/age_calculator.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  bool errorDObcheck = false;
  String? dob_error;
  late String formattedDate;
  String day = "";

  DateDuration duration = DateDuration();
  DateDuration nextduration = DateDuration();

  TextEditingController dateController = TextEditingController();
  TextEditingController todaydateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dateController.text = "";

    formattedDate = DateFormat('dd-MM-yyyy').format(DateTime
        .now()); // format date in required form here we use yyyy-MM-dd that means time is removed
    print(
        formattedDate); //formatted date output using intl package =>  2022-07-04
    //You can format date as per your need

    setState(() {
      todaydateController.text =
          formattedDate; //set formatted date to TextField value.
    });
    errorDObcheck = false;
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Age Calculator',
          style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.bold,
            textStyle: TextStyle(
              color: Color(0xff333300),
            ),
          ),
        ),
        // actions: [
        //   //Image(height: 30,width: 30,image: AssetImage("images/logo2.png"))
        //   // IconButton(
        //   //     onPressed: () {},
        //   //     icon: Padding(
        //   //       padding: const EdgeInsets.only(right: 18.0),
        //   //       child: Icon(Icons.exit_to_app, color: Color(0xff333300)),
        //   //     ))
        // ],
      ),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(content: Text("Tap back again to leave")),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(width: 18),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff1F6E8C),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: theight * 0.32,
                  width: twidth * 0.88,
                  child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Calculate Your Date Of Birth",
                      style: GoogleFonts.varelaRound(
                          color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: twidth * 0.78,
                      child: TextField(
                        style: GoogleFonts.alice(
                            color: Colors.white, fontSize: 30),
                        controller: dateController,
                        decoration: InputDecoration(
                            labelText: "Select date of date",
                            labelStyle: GoogleFonts.alice(
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: 3),
                            prefixIconConstraints:
                                BoxConstraints(maxHeight: 20, minWidth: 30),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            hintText: "Select Your Date of Birth",
                            hintStyle: TextStyle(
                                fontSize: 15,
                                letterSpacing: 2,
                                color: Colors.white)),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now());

                          if (pickedDate != null) {
                            print(
                                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                            formattedDate = DateFormat('dd-MM-yyyy').format(
                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              dateController.text =
                                  formattedDate; //set formatted date to TextField value.
                            });
                            errorDObcheck = false;

                            DateTime birthday = pickedDate;

                            //Find out your age on any given date
                            setState(() {
                              duration = AgeCalculator.age(birthday,
                                  today: DateTime.now());
                            });
                            print(
                                'Your age is $duration'); // Your age is Years: 33, Months: 1, Days: 26

                            // Find out when your next birthday will be on any given date
                            setState(() {
                              nextduration = AgeCalculator.timeToNextBirthday(
                                  birthday,
                                  fromDate: DateTime.now());
                            });

                            DateTime fromDate = DateTime.now();
                            DateTime tempDate = DateTime(fromDate.year + 1,
                                birthday.month, birthday.day);

                            print("++++++$tempDate");

                            setState(() {
                              day = DateFormat('EEEE').format(tempDate);
                            });

                            //
                            // String day =
                            //     DateFormat('EEEE').format(DateTime());
                            // // String day = DateFormat.d('EEEE')
                            // //     .format(DateTime(birthday.year + 1));
                            // //
                            print("days=============${day}");

                            print('You next birthday will be in $nextduration');
                            // You next birthday will be in Years: 0, Months: 0, Days: 3
                          }
                        },
                        readOnly: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: twidth * 0.78,
                      child: TextField(
                        style: GoogleFonts.alice(
                            color: Colors.white, fontSize: 30),
                        controller: todaydateController,
                        decoration: InputDecoration(
                          labelText: "today's date",
                          labelStyle: GoogleFonts.alice(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: 3),
                          errorText: errorDObcheck ? dob_error : null,
                          prefixIconConstraints:
                              BoxConstraints(maxHeight: 20, minWidth: 30),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("You are (Your age right now)",
                  style: GoogleFonts.alice(
                    letterSpacing: 1,
                  )),
            ),
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Mycontainer('${duration.years}', 0xff6370DD),
              Mycontainer('${duration.months}', 0xffCED497),
              Mycontainer('${duration.days}', 0xff72E1B4)
            ],
          ),
          SizedBox(
            width: twidth,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Year",
                  style: GoogleFonts.alice(color: Colors.black38),
                ),
                Text(
                  "Month",
                  style: GoogleFonts.alice(color: Colors.black38),
                ),
                Text(
                  "Days",
                  style: GoogleFonts.alice(color: Colors.black38),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
              color: Colors.black38, thickness: 2, endIndent: 15, indent: 15),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(width: 18),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff84A7A1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: theight * 0.22,
                  width: twidth * 0.88,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 25),
                              child: Text(
                                'Next Birthday',
                                style: GoogleFonts.alice(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                      child: dateController.text != ""
                                          ? Text(
                                              "${nextduration.months}",
                                              style: GoogleFonts.alice(
                                                  color: Color(0xff333300),
                                                  fontSize: 30),
                                            )
                                          : Text("")),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                      child: dateController.text != ""
                                          ? Text(
                                              "${nextduration.days}",
                                              style: GoogleFonts.alice(
                                                  color: Color(0xff333300),
                                                  fontSize: 30),
                                            )
                                          : Text("")),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 28),
                                  child: Text(
                                    "Month",
                                    style: GoogleFonts.alice(
                                        color: Colors.black38),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Days",
                                    style: GoogleFonts.alice(
                                        color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 80, 0, 10),
                            child: dateController.text != ""
                                ? Text("Your birthday is on ",
                                    style: GoogleFonts.alice(
                                      color: Colors.black,
                                    ))
                                : Text(""),
                          ),
                          Text(
                            '$day',
                            style: GoogleFonts.alice(
                                color: Color(0xff333300),
                                fontSize: 22,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )

                      // Image(
                      //     width: 150,
                      //     height: 150,
                      //     image: AssetImage("images/birthday.jpg"))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Mycontainer(String s, int color) {
    return Container(
      decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: 90,
      height: 90,
      child: Center(
          child: dateController.text != ""
              ? Text(s,
                  style: GoogleFonts.alice(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ))
              : Text("")),
    );
  }
}
