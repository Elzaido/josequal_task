// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:josequal_task/shared/component.dart';
import '../modules/search.dart';
import '../shared/constant.dart';
import '../shared/cubit/home_cubit.dart';
import '../shared/cubit/home_state.dart';

class HomeLayout extends StatelessWidget {
  final PageStorageBucket bucket = PageStorageBucket();

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: ((context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: cubit.titles[cubit.currentIndex],
              isHome: true),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            },
            child: Icon(Icons.search),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          HomeCubit.get(context).currentIndex = 0;
                          HomeCubit.get(context)
                              .changeNav(HomeCubit.get(context).currentIndex);
                          defaultToast(
                              massage: '*NOTE: Images need to be cached',
                              state: ToastStates.WARNING);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: HomeCubit.get(context).currentIndex == 0
                                  ? mainColor
                                  : Colors.grey,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: HomeCubit.get(context).currentIndex == 0
                                    ? mainColor
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          HomeCubit.get(context).currentIndex = 2;
                          HomeCubit.get(context)
                              .changeNav(HomeCubit.get(context).currentIndex);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: HomeCubit.get(context).currentIndex == 2
                                  ? mainColor
                                  : Colors.grey,
                            ),
                            Text(
                              'Favorite',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: HomeCubit.get(context).currentIndex == 2
                                    ? mainColor
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
