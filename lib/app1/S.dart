// import 'package:flutter/material.dart';
// import 'package:matrimonial/string_const.dart';
//
// class Registration extends StatefulWidget {
//   Map<String,dynamic>? user_list ;
//   Registration({super.key,Map<String,dynamic>? user_list}){
//     this.user_list=user_list;
//   }
//
//   @override
//   State<Registration> createState() => _RegistrationState();
//
// }
//
// class _RegistrationState extends State<Registration> {
//   TextEditingController fname = TextEditingController();
//   TextEditingController lname = TextEditingController();
//   TextEditingController address = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController mobile = TextEditingController();
//   TextEditingController hobby = TextEditingController();
//   GlobalKey<FormState> _key = GlobalKey<FormState>();
//   List<String> cities = ['Ahmedabad', 'Surat', 'Rajkot', 'Vadodara'];
//   String? selectedCity;
//   String? gender;
//   DateTime? selectedDate;
//   bool isReading = false;
//   bool isMusic = false;
//   bool isTimePass = false;
//   bool isFavourite = false;
//   int findIndex(List<String> cities, selectedCity) {
//     for (int i = 0; i < cities.length; i++) {
//       if (selectedCity.toString().toLowerCase() ==
//           cities[i].toString().toLowerCase()) {
//         return i;
//       }
//     }
//     return 0;
//   }
//   @override
//   void initState() {
//     super.initState();
//     if(widget.user_list!=null){
//       fname.text=widget.user_list![FNAME];
//       lname.text=widget.user_list![LNAME];
//       address.text=widget.user_list![ADDRESS];
//       email.text=widget.user_list![EMAIL];
//       mobile.text=widget.user_list![MOBILE];
//       selectedCity=widget.user_list![CITY];
//       isFavourite=widget.user_list![ISFAVOURITE];
//     }
//     selectedCity = widget.user_list != null
//         ? cities[findIndex(cities, widget.user_list![CITY])]
//         : cities[0];
//     // gender=(gender==null?'Male':widget.user_list![GENDER]);
//     // selectedDate=(selectedDate==null?DateTime.timestamp():widget.user_list![DOB]);
//     // isReading=(isReading?false:widget.user_list![ISREADIG]);
//     // isTimePass=(isTimePass?false:widget.user_list![isTimePass]);
//     // isMusic=(isMusic?false:widget.user_list![isMusic]);
//   }
//   @override
//   Widget build(BuildContext context) {
//     final W = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.redAccent,
//         title: Text("Registration",style: TextStyle(color: Colors.white,fontSize: 25),),
//       ),
//       body: Form(
//         key: _key,
//         child: Center(
//           child: Container(
//             // color: Colors.lightBlueAccent,
//             width: W*0.7,
//             height: h*0.85,
//             child: ListView(
//               children: [
//                 SizedBox(height: 10,),
//                 // Image.network('https://w7.pngwing.com/pngs/519/22/png-transparent-wedding-ring-engagement-ring-wedding-ring-white-ring-text.png'),
//                 Center(child: Text("Personal information ",style: TextStyle(fontSize: 25,color: Colors.deepPurpleAccent),)),
//                 SizedBox(height: 10,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: fname,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Enter First Name";
//                           }
//                         },
//                         decoration: InputDecoration(
//                           hintText: "First Name",
//                           labelText: "first Name",
//                           labelStyle: TextStyle(color: Colors.redAccent),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10,),
//                     Expanded(
//                       child: TextFormField(
//                         controller: lname,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Enter Last Name";
//                           }
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Last Name",
//                           labelText: "Last Name",
//                           labelStyle: TextStyle(color: Colors.redAccent),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 TextFormField(
//                   controller: address,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Enter Address";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Address",
//                     labelText: "Address",
//                     labelStyle: TextStyle(color: Colors.redAccent),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//                 TextFormField(
//                   controller: email,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Enter Email";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Email",
//                     labelText: "Email",
//                     labelStyle: TextStyle(color: Colors.redAccent),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//                 TextFormField(
//                   controller: mobile,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Enter Mobile";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Mobile",
//                     labelText: "Mobile",
//                     labelStyle: TextStyle(color: Colors.redAccent),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//                 DropdownButtonFormField<String>(
//                   value: selectedCity,
//                   items: cities.map((city) => DropdownMenuItem<String>(
//                     value: city,
//                     child: Text(city),
//                   )).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedCity = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please select a city";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     prefixText: "City: ",
//                     prefixStyle: TextStyle(color: Colors.redAccent),
//
//                     labelStyle: TextStyle(color: Colors.redAccent),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     Text(
//                       "Gender :",
//                       style: TextStyle(color: Colors.redAccent,fontSize: 17),
//                     ),
//                     SizedBox(width: 10,),
//                     Text("Male"),
//                     Radio(value: 'Male', groupValue: gender, onChanged: (value) {
//                       setState(() {
//                         gender=value;
//                       });
//                     },),
//                     SizedBox(width: 10,),
//                     Text("Female"),
//                     Radio(value: 'Female', groupValue: gender, onChanged: (value) {
//                       setState(() {
//                         gender=value;
//                       });
//                     },),
//                     if (gender == null) // Show error if gender is not selected
//                       const Padding(
//                         padding: EdgeInsets.only(top: 5),
//                         child: Text(
//                           "Please select gender",
//                           style: TextStyle(color: Colors.red, fontSize: 12),
//                         ),
//                       ),
//                     SizedBox(height: 10),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   readOnly: true,
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(1900), // Earliest allowed date
//                       lastDate: DateTime.now(), // Latest allowed date
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         selectedDate = pickedDate;
//                       });
//                     }
//                   },
//                   validator: (value) {
//                     if (selectedDate == null) {
//                       return "Please select your date of birth";
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Date of Birth",
//                     labelText: "DOB",
//                     labelStyle: TextStyle(color: Colors.redAccent),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   controller: TextEditingController(
//                     text: selectedDate == null
//                         ? ''
//                         : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Hobbies :",
//                         style: TextStyle(color: Colors.redAccent, fontSize: 17),
//                       ),
//                       SizedBox(width: 10,),
//                       Expanded(
//                         child: Column(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Checkbox(
//                                     value: isReading,
//                                     onChanged: (bool? value){
//                                       setState(() {
//                                         isReading=value!;
//                                       });
//                                     }
//                                 ),
//                                 Text("Reading"),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Checkbox(
//                                     value: isMusic,
//                                     onChanged: (bool? value){
//                                       setState(() {
//                                         isMusic=value!;
//                                       });
//                                     }
//                                 ),
//                                 Text("Music"),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Checkbox(
//                                     value: isTimePass,
//                                     onChanged: (bool? value){
//                                       setState(() {
//                                         isTimePass=value!;
//                                       });
//                                     }
//                                 ),
//                                 Text("Time Pass"),
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ]
//                 ),
//                 // TextFormField(
//                 //   controller: hobby,
//                 //   validator: (value) {
//                 //     if (value!.isEmpty) {
//                 //       return "Enter Hobbies";
//                 //     }
//                 //   },
//                 //   decoration: InputDecoration(
//                 //     hintText: "Hobby",
//                 //     labelText: "Hobby",
//                 //     labelStyle: TextStyle(color: Colors.redAccent),
//                 //     border: OutlineInputBorder(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //     ),
//                 //   ),
//                 // ),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                       ),
//                       onPressed: (){
//                         Map<String,dynamic> user = {};
//                         user[FNAME]=fname.text;
//                         user[LNAME]=lname.text;
//                         user[ADDRESS]=address.text;
//                         user[EMAIL]=email.text;
//                         user[MOBILE]=mobile.text;
//                         user[CITY]=selectedCity;
//                         user[GENDER]=gender;
//                         user[DOB]=selectedDate;
//                         user[ISREADIG]=isReading;
//                         user[ISMUSIC]=isMusic;
//                         user[ISTIMEPASS]=isTimePass;
//                         user[ISFAVOURITE]=isFavourite;
//                         user[AGE]=DateTime.now().year-selectedDate!.year;
//                         print('-------------------$user-----------------');
//                         if(_key.currentState!.validate()){
//                           Navigator.pop(context,user);
//                         }
//                       },child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Text("Submit",style: TextStyle(fontSize: 17,color: Colors.white),),
//                     ),)),
//                     SizedBox(width: 10,),
//                     Expanded(child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.redAccent,
//                       ),
//                       onPressed: (){
//                         _key.currentState!.reset();
//                         gender=null;
//                       },child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Text("Reset",style: TextStyle(fontSize: 17,color: Colors.white),),
//                     ),)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }