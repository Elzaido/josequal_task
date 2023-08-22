import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../shared/component.dart';
import '../shared/cubit/home_cubit.dart';

class PhotoDatails extends StatelessWidget {
  const PhotoDatails(
      {super.key,
      required this.photo,
      required this.url,
      required this.fovrite,
      required this.id});

  final String photo;
  final String url;
  final bool fovrite;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'Photo Details'),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(photo))),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(
                            0, -1), // This controls the elevation from the top
                      ),
                    ],
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          fovrite
                              ? Expanded(
                                  child: MaterialButton(
                                      onPressed: () {
                                        HomeCubit.get(context)
                                            .deleteFromDB(id: id);
                                        Navigator.pop(context);
                                      },
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Remove from Favorite',
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                color: Colors.white),
                                          )
                                        ],
                                      )),
                                )
                              : Expanded(
                                  child: MaterialButton(
                                      onPressed: () {
                                        HomeCubit.get(context)
                                            .insertToDB(image: photo, url: url);
                                      },
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Add to Favorite',
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                color: Colors.white),
                                          )
                                        ],
                                      )),
                                ),
                          Expanded(
                            child: MaterialButton(
                                onPressed: () {
                                  downloadFile(photo);
                                },
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.download,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'download Photo',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: Colors.white),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      )) // Your child widgets here
                  )),
        ],
      ),
    );
  }
}

void downloadFile(String url) async {
  var time = DateTime.now().microsecondsSinceEpoch;
  var path = "/storage/emulated/0/Download/image-$time.jpg";
  var file = File(path);
  var res = await get(Uri.parse(url));
  file.writeAsBytes(res.bodyBytes).then((value) {
    defaultToast(
        massage: 'Image Downloaded, check your gallery after a minute',
        state: ToastStates.SUCCESS);
  }).catchError((error) {
    defaultToast(massage: 'Something wrong happens!', state: ToastStates.ERROR);
  });
}
