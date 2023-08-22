import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/component.dart';
import '../shared/cubit/home_state.dart';
import '../shared/cubit/home_cubit.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // blocBuilder written 1 time only
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = HomeCubit.get(context).photos;
          var listLength = HomeCubit.get(context).photos.length;

          return list.isNotEmpty
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: gridItems(listLength, list, context),
                  ))
              : const Center(
                  child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 80, 161, 122),
                ));
        });
  }
}
