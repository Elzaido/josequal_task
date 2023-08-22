// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../modules/photo_details.dart';
import 'constant.dart';

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  required String title,
  bool isHome = false,
}) {
  return AppBar(
    backgroundColor: mainColor,
    title: isHome
        ? Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold),
            ),
          )
        : Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold),
          ),
    leading: !isHome
        ? IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : null,
  );
}

Widget gridItems(length, list, context) => GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 1 / 1.50,
    children: List.generate(
      length,
      (index) => photoItem(list[index], context),
    ));

Widget photoItem(data, context) => InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PhotoDatails(
                    photo: data['src']['portrait'],
                    url: data['url'],
                    fovrite: false,
                    id: 1,
                  )));
    },
    child: Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: NetworkImage(data['src']['portrait']),
                fit: BoxFit.cover)),
      ),
    ));

Widget gridFavoriteItems(length, List<Map> list, context) => GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 1 / 1.50,
    children: List.generate(
      length,
      (index) => favoriteItems(list[index], context),
    ));

Widget favoriteItems(Map list, context) => InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PhotoDatails(
                    photo: list['image'],
                    url: list['url'],
                    fovrite: true,
                    id: list['id'],
                  )));
    },
    child: Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: NetworkImage(list['image']), fit: BoxFit.cover)),
      ),
    ));

void defaultToast({
  required String massage,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 7,
        backgroundColor: choseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

// states of the Toast
enum ToastStates { SUCCESS, ERROR, WARNING }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.orange;
      break;
  }

  return color;
}
