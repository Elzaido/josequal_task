// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import '../../network/remote/end_points.dart';
import '../../shared/cubit/home_state.dart';
import '../../modules/favorite.dart';
import '../../modules/home.dart';
import '../../modules/search.dart';
import '../../network/remote/diohelper.dart';
import '../component.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  List<dynamic> photos = [];
  List<dynamic> search = [];
  int currentIndex = 0;

  List<Widget> screens = [
    const Home(),
    Search(),
    const Favorite(),
  ];

  List<String> titles = [
    'Home',
    'Search',
    'Favorite',
  ];

  void changeNav(int index) {
    if (index == 1) {
      emit(GoToSearchPage());
    } else {
      currentIndex = index;
      emit(ChangeNavState());
    }
  }

  void getPhotosData() {
    emit(LoadingGetPhotosState());
    if (photos.isEmpty) {
      DioHelper.getData(url: CURATED, query: {
        'per_page': '40',
      }).then((value) {
        photos = value.data['photos'];
        print(photos);
        emit(SuccessGetPhotosState());
      }).catchError((error) {
        print(error.toString());
        emit(ErrorGetPhotosState());
      });
    } else {
      emit(SuccessGetPhotosState());
    }
  }

  void getSearchData(value) {
    emit(LoadingGetSearchedPhotosState());
    DioHelper.getData(url: SEARCH, query: {'query': '$value', 'per_page': '10'})
        .then((value) {
      print(value.data.toString());
      search = value.data['photos'];
      emit(SuccessGetSearchedPhotosState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetSearchedPhotosState());
    });
  }

  late Database database;
  List<Map> favoriteList = [];

  createDB() {
    openDatabase('photo.db', version: 1, onCreate: (database, version) {
      print('DB Created');
      database
          .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, image TEXT, url TEXT)')
          .then((value) {
        print('Table created');
      }).catchError((error) {
        print('error when creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      print('DB Opened');

      getFromDB(database);
    }).then((value) {
      database = value;
      emit(SuccessCreateDBState());
      throw ('DB Created');
    });
  }

  // Insert some records in a transaction
  insertToDB({
    required String image,
    required String url,
  }) {
    database.transaction((txn) {
      return txn
          .rawInsert('insert into Tasks (image ,url) VALUES("$image","$url")');
    }).then((value) {
      print('$value inserted sucssesfully');
      emit(SuccessInsertToDBState());
      defaultToast(
          massage: 'Image added to favorite', state: ToastStates.SUCCESS);
      getFromDB(database);
    }).catchError((error) {
      emit(ErrorInsertToDBState());
      print('error when inserting data ${error.toString()}');
    });
  }

  void getFromDB(database) {
    favoriteList = [];
    emit(LoadingGetFromDBState());

    database.rawQuery('SELECT * FROM Tasks').then((value) {
      value.forEach((elements) {
        favoriteList.add(elements);
        print(favoriteList);
        emit(SuccessGetFromDBState());
      });
    }).catchError((error) {
      emit(ErrorGetFromDBState());
    });
  }

  void deleteFromDB({required int id}) async {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      defaultToast(
          massage: 'Image removed from favorite', state: ToastStates.ERROR);
      getFromDB(database);
      emit(SuccessDeleteFromDBState());
    });
  }

  Future<void> requestStoragePermission(String url) async {
    final PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      await downloadAndSaveImage(url);
    } else if (status.isDenied) {
      // Permission denied
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> downloadAndSaveImage(String imageUrl) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String fileName = imageUrl.split('/').last;
    final String filePath = '${appDir.path}/$fileName';

    try {
      await DioHelper.downloadImage(imageUrl: imageUrl, filePath: filePath);
      emit(SuccessDownloadImageState());
    } catch (e) {
      emit(ErrorDownloadImageState());
      print('Error downloading image: $e');
      // Handle download error
    }
  }
}
