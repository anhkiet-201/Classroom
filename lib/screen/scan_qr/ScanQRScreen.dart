import 'package:camera/camera.dart';
import 'package:class_room_chin/extension/DynamicColor.dart';
import 'package:class_room_chin/extension/Present.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:iconsax/iconsax.dart';

import '../../components/ScanQR.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  List<Barcode> barcodes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: ScanQR(
                onResult: (result) {
                  barcodes = result;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: Center(
                child: Visibility(
                    visible: barcodes.isNotEmpty,
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: barcodes.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: context.getDynamicColor.primary),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Row(
                              children: [
                                Text(
                                  '${barcodes[index].displayValue}',
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: context.getDynamicColor.primary),
                                  maxLines: 1,
                                ),
                                const SizedBox(width: 10,),
                                IconButton(onPressed: (){}, icon: Icon(Iconsax.copy, color: context.getDynamicColor.primary,))
                              ],
                            )
                          );
                        },
                      ),
                    )),
              ),
            )
          ],
        )
    );
  }
}
