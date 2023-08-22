import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/constant.dart';
import '../shared/component.dart';
import '../shared/cubit/home_cubit.dart';
import '../shared/cubit/home_state.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = HomeCubit.get(context).search;
        var length = HomeCubit.get(context).search.length;
        return Scaffold(
          appBar: defaultAppBar(context: context, title: 'Search'),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (state is LoadingGetSearchedPhotosState)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      color: Color.fromARGB(255, 80, 161, 122),
                      backgroundColor: Colors.greenAccent,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          onFieldSubmitted: (value) {
                            HomeCubit.get(context)
                                .getSearchData(value.toString());
                          },
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 86, 167,
                                        128)), // Change the color to your desired color
                              ),
                              labelStyle: TextStyle(color: mainColor),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color.fromARGB(255, 73, 145, 110),
                              ),
                              labelText: 'Search here!',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          cursorColor: mainColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        height: 55,
                        color: mainColor,
                        onPressed: () {
                          HomeCubit.get(context)
                              .getSearchData(searchController.text);
                        },
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                length > 0
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: gridItems(length, list, context),
                      )
                    : const Column(
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Search Items will be shown here!',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Icon(
                                Icons.search,
                                size: 30,
                              )
                            ],
                          ),
                        ],
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
