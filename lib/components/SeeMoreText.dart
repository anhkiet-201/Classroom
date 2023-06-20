import 'package:flutter/material.dart';

class SeeMoreText extends StatefulWidget {
  const SeeMoreText(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  State<SeeMoreText> createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
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