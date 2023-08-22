import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/component.dart';
import '../shared/cubit/home_state.dart';
import '../shared/cubit/home_cubit.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    // blocBuilder written 1 time only
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = HomeCubit.get(context).favoriteList;
          var listLength = HomeCubit.get(context).favoriteList.length;

          return list.isNotEmpty
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: gridFavoriteItems(listLength, list, context),
                  ))
              : const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No favorite images yet!',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 30,
                      )
                    ],
                  ),
                );
        });
  }
}
