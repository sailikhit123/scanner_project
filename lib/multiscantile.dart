// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'contiscan.dart';

class MultiQrTile extends StatelessWidget {
  const MultiQrTile({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
                                  width: 111,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.black,
                                  ),
                                  child: InkWell(
                                    onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QRViewExample(),
            ));
          },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            'assets/images/infinitescan.png',
                                            height: 75),
                                        Center(
                                          child: Text(
                                            'Multi-Scan',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                );
  }

  }