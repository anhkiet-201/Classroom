import 'package:class_room_chin/bloc/home/home_bloc.dart';
import 'package:class_room_chin/components/CustomImage.dart';
import 'package:class_room_chin/components/CustomRefreshIndicator.dart';
import 'package:class_room_chin/constants/Colors.dart';
import 'package:class_room_chin/constants/FirebaseConstants.dart';
import 'package:class_room_chin/screen/create_class/CreateClassroom.dart';
import 'package:class_room_chin/screen/join_class/JoinClassroom.dart';
import 'package:class_room_chin/screen/profile/ProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../components/Loading.dart';
import '../../components/animation/ChangeWidgetAnimation.dart';
import '../../models/Classroom.dart';
import '../../utils/Utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final RefreshController _refreshController = RefreshController();
  List<Classroom> classrooms = [];


  @override
  void initState() {
    context.read<HomeBloc>().add(HomeFetchRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, isInner) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 150 + MediaQuery.of(context).padding.top,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: SafeArea(
                      child: InkWell(
                        child: Ink(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [

                              // const SizedBox(height: 20,),
                              Text(
                                'Hey ${FirebaseAuth.instance.currentUser?.displayName ?? ""}',
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              // const SizedBox(height: 20,),
                              const Text(
                                'Which skill are you looking to \nacquire today?',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      )),
                  collapseMode: CollapseMode.pin,
                ),
              ),
              SliverAppBar(
                surfaceTintColor: Colors.transparent,
                automaticallyImplyLeading: false,
                pinned: true,
                collapsedHeight: 75,
                flexibleSpace: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: 20,
                      right: 20),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: TextFormField(
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type something',
                                  prefixIcon: Icon(Icons.search)),
                              textInputAction: TextInputAction.search,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const ProfileScreen())).then((value){
                                setState(() {

                                });
                              });
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            child: CustomImage(
                              AUTH.currentUser?.photoURL ?? '',
                              height: 50,
                              width: 50,
                              borderRadius: 25,
                            )
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) => Container(
                                    height: 200,
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _bottomSheetButton(
                                            onClick: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                      const JoinClassroom()))
                                                  .then((value)=>Navigator.maybePop(context));
                                            },
                                            icon: Iconsax.add_circle,
                                            text: 'Join classroom'),
                                        _bottomSheetButton(
                                            onClick: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          CreateClassroom()))
                                                  .then((value) => Navigator.maybePop(context));
                                            },
                                            icon: Iconsax.add_circle,
                                            text: 'Create classroom'),
                                      ],
                                    ),
                                  ));
                            },
                            icon: const Icon(Iconsax.textalign_right))
                      ],
                    ),
                  ),
                ),
                elevation: 0,
              ),
            ];
          },
          body: ChangeWidgetAnimation(
              child: BlocConsumer<HomeBloc, HomeState>(
                listener: (context,state){
                  // if(state is HomeFetchSuccessful){
                  //
                  // }

                  if(state is HomeRefreshSuccessful){
                    _refreshController.refreshCompleted();
                    ShowSnackbar(context, title: "Notification!", content: 'Refresh Successful!');
                  }

                },
                listenWhen: (_,state){
                  return true;
                },
                builder: ( context, state) {
                  if(state is HomeFetchLoading) {
                    return const Loading();
                  }

                  if(state is HomeFetchFailure){
                    return Text('fetch error');
                  }

                  if(state is HomeRefreshSuccessful){
                    classrooms = state.classrooms;
                  }

                  if(state is HomeFetchSuccessful){
                    classrooms = state.classrooms;
                  }

                  if(classrooms.isEmpty){
                    return _refesh(
                      child: Center(child: Text('Empty'))
                    );
                  }
                  return _refesh(
                    child:  _content(context, classrooms)
                  );
                },
              )
          )
      ),
    );
  }

  Widget _refesh({required Widget child}){
    return RefreshConfiguration(
      child: SmartRefresher(
        header: CustomRefreshIndicator(),
        controller: _refreshController,
        child:child,
        onRefresh: (){
          context.read<HomeBloc>().add(HomeRefresh());
        },
      ),
    );
  }

  ListView _content(BuildContext context, List<Classroom> classrooms) {
    return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: classrooms.length,
          padding: const EdgeInsets.only(top: 0, bottom: 100),
          itemBuilder: (context, index) => Container(
            height: 160,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border:
              Border(bottom: BorderSide(color: primaryColor, width: 0.5)),
            ),
            child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              classrooms[index].className,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tern: ${classrooms[index].tern.isEmpty ? 'Unknown' : classrooms[index].tern}', maxLines: 1, overflow: TextOverflow.ellipsis,),
                                Text('Description: ${classrooms[index].description.isEmpty ? '...' : classrooms[index].description}',maxLines: 2, overflow: TextOverflow.ellipsis,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      //child: SizedBox(),
                      child: SvgPicture.asset(
                        'assets/images/education.svg',
                        fit: BoxFit.scaleDown,
                      )
                    //Lottie.asset('lotties/${_lotties[index]}'),
                  )
                ],
              ),
            ),
          ),
        );
  }

  IconButton _bottomSheetButton(
      {required Function onClick,
        required IconData icon,
        required String text}) {
    return IconButton(
      onPressed: () => onClick(),
      icon: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
      style: IconButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}

