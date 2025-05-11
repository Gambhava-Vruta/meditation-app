import 'package:flutter/cupertino.dart';

import 'StringConst.dart';


class User {
  List<Map<String, dynamic>> userList = [];

  void addUserInList({required name,required city, required phoneNumber,required age, required email,required Gender,required Dob,required Isfavourite,required Password}) {
    Map<String, dynamic> map = {};
    map[NAME] = name;
    map[AGE] = age;
    map[EMAIL] = email;
    map[GENDER]=Gender;
    map[PHONENUMBER]=phoneNumber;
    map[DOB]=Dob;
    map['Isfavourite'];
    map[PASSWORD]=Password;
    map[CITY]=city;
    print(map);
    userList.add(map);
  }

  List<Map<String, dynamic>> getUserList() {
    return userList;
  }

  void updateUser(
      {required name,required city, required phoneNumber, required email, required id,required age,required Gender,required Dob,required Isfavourite,required Password}) {
    Map<String, dynamic> map = {};
    map[NAME] = name;
    map[EMAIL] = email;
    map[AGE] = age;
    map[GENDER]=Gender;
    map[PHONENUMBER]=phoneNumber;
    map[DOB]=Dob;
    map['Isfavourite'] = false;
    map[PASSWORD]=Password;
    map[CITY]=city;

    userList[id] = map;

  }

  void deleteUser(id) {
    userList.removeAt(id);
  }

  void searchDeatil({required searchData}) {
    for (var element in userList) {
      if (element[NAME]
          .toString()
          .toLowerCase()
          .contains(searchData.toString().toLowerCase()) ||
          element[EMAIL]
              .toString()
              .toLowerCase()
              .contains(searchData.toString().toLowerCase())) {
        Text(
            '${element[NAME]} . ${element[AGE]} . ${element[EMAIL]}');
      }
    }
  }
}

