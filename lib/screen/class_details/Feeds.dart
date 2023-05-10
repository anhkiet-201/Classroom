import 'package:class_room_chin/App.dart';
import 'package:class_room_chin/components/CustomScaffoldWithAppBar.dart';
import 'package:class_room_chin/components/MessageView.dart';
import 'package:class_room_chin/components/PhotoView.dart';
import 'package:class_room_chin/constants/Colors.dart';
import 'package:class_room_chin/models/Classroom.dart';
import 'package:class_room_chin/screen/class_details/ClassroomDetails.dart';
import 'package:class_room_chin/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../components/CustomImage.dart';
import '../../constants/FirebaseConstants.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithAppbar(
        tag: 'title${chooseClass?.classID}',
        title: chooseClass?.className ?? '',
        secondaryAppbar: SliverAppBar(
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
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: TextFormField(
                        maxLines: 1,
                        readOnly: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Post a new post',
                            prefixIcon: Icon(Icons.edit)),
                        textInputAction: TextInputAction.search,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          elevation: 0,
        ),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              border: Border.all(color: primaryColor)),
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
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                child: const Text('Reply this post.'),
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    useRootNavigator: true,
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    builder: (ct) {
                                      return Stack(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.vertical(
                                                    top: Radius.circular(20))),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                  child: Center(
                                                    child: Container(
                                                      height: 5,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius: const BorderRadius.all(Radius.circular(5))
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(child: MessageView(mess)),
                                                const SizedBox(height: 70,)
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            bottom: MediaQuery.of(ct).viewInsets.bottom,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              width: MediaQuery.of(context).size.width,
                                              color: Colors.white,
                                              child: Row(
                                                children: [
                                                  CustomImage(
                                                    AUTH.currentUser?.photoURL ?? '',
                                                    height: 30,
                                                    width: 30,
                                                    borderRadius: 25,
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  Expanded(
                                                    child: TextFormField(),
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  TextButton(onPressed: (){}, child: Text('Send'))
                                                ],
                                              ),
                                            )
                                          )
                                        ],
                                      );
                                    });
                              },
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
        ));
  }
}

class ImagesSlider extends StatefulWidget {
  const ImagesSlider(this.images, {Key? key}) : super(key: key);
  final List<String> images;

  @override
  State<ImagesSlider> createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = (index + 1);
              });
            },
            itemBuilder: (_, index) {
              return GestureDetector(
                child: CustomImage(
                  widget.images[index],
                  fit: BoxFit.cover,
                ),
                onTap: (){
                  navigatorPush(context, PhotoView(widget.images[index]));
                },
              );
            },
            itemCount: widget.images.length,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Text(
                '$_currentIndex/${widget.images.length}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SeeMoreText extends StatefulWidget {
  const SeeMoreText(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  State<SeeMoreText> createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText>
    with TickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      child: SizedBox(
          height: _isExpanded ? null : 60,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.text,
                softWrap: true,
                maxLines: _isExpanded ? null : 2,
                overflow: _isExpanded ? null : TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              if (!_isExpanded)
                GestureDetector(
                  child: const Text(
                    'see more.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                )
            ],
          )),
    );
  }
}
