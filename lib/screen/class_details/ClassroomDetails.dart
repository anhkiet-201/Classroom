import 'package:class_room_chin/components/CustomScaffoldWithAppBar.dart';
import 'package:class_room_chin/extension/DynamicColor.dart';
import 'package:class_room_chin/extension/HeroTag.dart';
import 'package:class_room_chin/extension/NavigatorContext.dart';
import 'package:class_room_chin/extension/Present.dart';
import 'package:class_room_chin/screen/about_class/AboutClassScreen.dart';
import 'package:class_room_chin/screen/classroom_qr_share/ClassroomQrShare.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../components/CustomImage.dart';
import '../../components/ImagesSlider.dart';
import '../../components/MessageView.dart';
import '../../components/SeeMoreText.dart';
import '../../components/SliverCollapsedAppbar.dart';
import '../../constants/Colors.dart';
import '../../constants/FirebaseConstants.dart';
import '../../models/Classroom.dart';
import '../create_post/CreatePost.dart';

class ClassroomDetails extends StatefulWidget {
  const ClassroomDetails(this.classroom, {Key? key}) : super(key: key);
  final Classroom classroom;

  @override
  State<ClassroomDetails> createState() => _ClassroomDetailsState();
}

class _ClassroomDetailsState extends State<ClassroomDetails> with Present<ClassroomDetails> {

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverCollapsedAppbar(
            titleText: widget.classroom.className,
            leading: IconButton(
              onPressed: () {
                context.finish();
              },
              icon: const Icon(Icons.close),
              style: IconButton.styleFrom(
                  backgroundColor: context
                      .getDynamicColor()
                      .onInverseSurface
                      .withOpacity(0.8)),
            ),
            background: Image.network(
              'https://images.unsplash.com/photo-1596401057633-54a8fe8ef647?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dmlldG5hbXxlbnwwfHwwfHw%3D&w=1000&q=80',
              fit: BoxFit.cover,
            ).subTag('img${widget.classroom.classID}'),
          ),
          SliverAppBar(
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            pinned: true,
            collapsedHeight: 60,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Row(
                  children: [
                    CustomImage(
                      AUTH.currentUser?.photoURL ?? '',
                      height: 50,
                      width: 50,
                      borderRadius: 25,
                    ).subTag('avt'),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: context.getDynamicColor().surfaceVariant,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                          maxLines: 1,
                          readOnly: true,
                          onTap: () => _showCreatePostBottomSheet(context),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Post a new post',
                              prefixIcon: Icon(Icons.edit)),
                          textInputAction: TextInputAction.search,
                        ),
                      ).subTag('inputBar'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          _showClassBottomSheet(context);
                        },
                        icon: const Icon(Iconsax.textalign_right))
                        .subTag('option')
                  ],
                ),
              ),
            ),
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: Column(
                children: [
                  for (int i = 0; i < 10; i++)
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    border: Border.all(
                                        color: context
                                            .getDynamicColor()
                                            .onSurface)),
                                child: CustomImage(
                                  AUTH.currentUser?.photoURL ?? '',
                                  height: 40,
                                  width: 40,
                                  borderRadius: 25,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Username',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_vert_rounded))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const ImagesSlider([
                            'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png',
                            'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png'
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          const SeeMoreText(
                              'This native SwiftUI state management allows two way databinding, which is performed using the Binding struct. This can lead to children directly mutating the state of their parents, and state updates that are completely untraced. The @State wrapper works best for basic state such as String or Int values stored directly on a View. For more complicated state, the @ObservedObject wrapper can be applied to a property of ObservableObject type. However, these properties are still stored directly on the View. This can be improved by using the @EnvironmentObject wrapper, which allows you to inject an ObservableObject into a parent view, and access it directly from any children, keeping a central location for the state of a view hierarchy. However, multiple environment objects may still be in use within the application, and may be mixed with state stored on views. Overall, it felt like a little bit of work needed doing to make state changes easy to manage for large scale applications. Redux is a pattern which performs this role with React, so I looked into adding it into SwiftUI.'),
                          SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                const Icon(Iconsax.message),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: InkWell(
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: context
                                                .getDynamicColor()
                                                .surfaceVariant,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(8))),
                                        child: const Text('Reply this post.'),
                                      ),
                                      onTap:() => showPresent(
                                        content: Container(
                                          color: Colors.blue,
                                        )
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _showPostBottomSheet(BuildContext context) => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (ct) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: SizedBox()),
                  const SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(ct).viewInsets.bottom,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      CustomImage(
                        AUTH.currentUser?.photoURL ?? '',
                        height: 30,
                        width: 30,
                        borderRadius: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Input your comment here...'),
                          maxLines: 3,
                          minLines: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Send',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ))
          ],
        );
      });

  _showClassBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        useRootNavigator: true,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                      child: GestureDetector(
                        child: const Icon(
                          Icons.qr_code_rounded,
                          size: 50,
                        ).mainTag('qr'),
                        onTap: () {
                          context.startActivity(
                              ClassroomQrShare(widget.classroom.classID));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Share this class',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: primaryColor,
                  thickness: 0.1,
                ),
                InkWell(
                  child: const SizedBox(
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Iconsax.info_circle),
                        SizedBox(
                          width: 10,
                        ),
                        Text('About this class')
                      ],
                    ),
                  ),
                  onTap: () {
                    context.startActivity(AboutClassScreen(widget.classroom));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  _showCreatePostBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        useRootNavigator: true,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: primaryColor, width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            child: const Icon(
                              Iconsax.edit,
                              size: 50,
                            ),
                          ),
                          onTap: () {
                            context.startActivity(
                                const CreatePost(
                                  type: CreatePostType.normal,
                                ),
                                type: NavigatorType.slide,
                                duration: const Duration(milliseconds: 300));
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Create normal post',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: primaryColor, width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            child: const Icon(
                              Icons.face_unlock_rounded,
                              size: 50,
                            ),
                          ),
                          onTap: () {
                            context.startActivity(
                                const CreatePost(
                                  type: CreatePostType.attendance,
                                ),
                                type: NavigatorType.slide,
                                duration: const Duration(milliseconds: 300));
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Create attendance post',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}

