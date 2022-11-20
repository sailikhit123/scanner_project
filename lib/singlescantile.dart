// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'contiscan.dart';

class QrTile extends StatelessWidget {
  const QrTile({Key? key}) : super(key: key);
  

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
                                            'assets/images/contiscanx1.png',
                                            height: 75),
                                        Center(
                                          child: Text(
                                            'Single Scan',
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