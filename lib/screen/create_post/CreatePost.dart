import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key, required this.type});
  final CreatePostType type;
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> _xFile = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.type.title
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Visibility(
                        visible: _xFile.isNotEmpty,
                        child: AspectRatio(
                          aspectRatio: 14/9,
                          child: PageView.builder(
                            itemCount: _xFile.length,
                            itemBuilder: (_, index) {
                              return Image.file(
                                File(_xFile[index].path),
                                fit: BoxFit.cover,
                                errorBuilder: (_, e, s) => const Center(
                                    child:
                                    Text('This image type is not supported')),
                              );
                            },
                          ),
                        ),
                      ),
                      TextFormField(
                        maxLines: null,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Title'),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        maxLines: null,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Content...'),
                        style: const TextStyle(),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          var result = imagePicker.pickMultiImage();
                          _xFile = await result;
                          setState(() {});
                        },
                        icon: const Icon(Icons.image_outlined)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.send_outlined))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

enum CreatePostType {
  normal("Create normal post"), attendance("Create attendance post");
  final String title;
  const CreatePostType(this.title);
}
