import 'package:class_room_chin/bloc/home/home_bloc.dart';
import 'package:class_room_chin/components/CustomImage.dart';
import 'package:class_room_chin/components/CustomRefreshIndicator.dart';
import 'package:class_room_chin/components/SnackBar.dart';
import 'package:class_room_chin/constants/Colors.dart';
import 'package:class_room_chin/constants/FirebaseConstants.dart';
import 'package:class_room_chin/screen/class_details/ClassroomDetails.dart';
import 'package:class_room_chin/screen/create_class/CreateClassroom.dart';
import 'package:class_room_chin/screen/join_class/JoinClassroom.dart';
import 'package:class_room_chin/screen/profile/ProfileScreen.dart';
import 'package:class_room_chin/utils/Extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
                flexibleSpace: FlexibleSpaceBar(
                  background: SafeArea(
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
                                color: context.getDynamicColor().surfaceVariant,
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
                          ).mainTag('inputBar'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            onTap: (){
                              navigatorPush(context, const ProfileScreen()).then((value){
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
                            .mainTag('avt')
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
                        .mainTag('option')
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
                    ShowSnackbar(context, type: SnackBarType.notification, content: 'Refresh Successful!');
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
                      child: const Center(child: Text('Empty'))
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
          itemBuilder: (context, index) =>Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(onPressed: (s){}, icon: Icons.edit,label: 'Edit',backgroundColor: context.getDynamicColor().background,),
                SlidableAction(onPressed: (s){}, icon: Icons.delete, label: 'Delete', backgroundColor: context.getDynamicColor().background,)
              ],
            ),
            child: Container(
              height: 160,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: context.getDynamicColor().surfaceVariant,
                borderRadius: const BorderRadius.all(Radius.circular(15))
              ),
              child: InkWell(
                onTap: () {
                  navigatorPush(context, ClassroomDetails(classrooms[index]));
                },
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
                              ).mainTag('title${classrooms[index].classID}'),
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
                        child: AspectRatio(
                          aspectRatio: 14/9,
                          child: const CustomImage(
                            'https://images.unsplash.com/photo-1596401057633-54a8fe8ef647?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dmlldG5hbXxlbnwwfHwwfHw%3D&w=1000&q=80',
                            fit: BoxFit.cover,
                          ).mainTag('img${classrooms[index].classID}'),
                        )
                      //Lottie.asset('lotties/${_lotties[index]}'),
                    )
                  ],
                ),
              ),
            ),
          )
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

