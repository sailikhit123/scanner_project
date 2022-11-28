
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sg_labs_scanner/multiscantile.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  List<String> tags = [];

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  String _scanBarcode = '0';

  @override
  void initState() {
    super.initState();
  }


  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.DEFAULT);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    tags.add(barcodeScanRes);

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 30, 30),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 30)),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                height: 235,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(children: [
                      SizedBox(height: 30),
                      Center(
                        child: Text('Select Scanner By Barcode',
                            style: GoogleFonts.notoSans(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          SizedBox(width: 30),
                          Container(
                            width: 111,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () => scanBarcodeNormal(),
                              child: Column(children: [
                                Image.asset('assets/images/qrlogo.png',
                                    height: 75),
                                Center(
                                  child: Text(
                                    'QR Code',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 5),
                              ]),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 111,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () => scanBarcodeNormal(),
                              child: Column(children: [
                                Image.asset('assets/images/barcodelogo.png',
                                    height: 75),
                                Center(
                                  child: Text(
                                    'Barcode',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 5),
                              ]),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 111,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () => scanBarcodeNormal(),
                              child: Column(children: [
                                Image.asset('assets/images/dualscan.png',
                                    height: 75),
                                Center(
                                  child: Text(
                                    'Hybrid Scan',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 5),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ]))
                  ],
                ),
                SizedBox(height: 40),
                Container(
                  child: Text('Select Scanner By Scenario',
                            style: GoogleFonts.notoSans(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    SizedBox(width: 85),
                    Container(
                      width: 111,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () => scanBarcodeNormal(),
                        child: Column(children: [
                          Image.asset('assets/images/contiscanx1.png',
                              height: 75),
                          Center(
                            child: Text(
                              'Single Scan',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 5),
                        ]),
                      ),
                    ),
                    SizedBox(width: 20),
                    MultiQrTile()
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    
                    child: Text('Scan result : $_scanBarcode\n',
                              style: GoogleFonts.notoSans(
                                  fontSize: 20, fontWeight: FontWeight.bold)),),
                )
              ],
            ),
          ),

          Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Barcode Type:')
                    ),
                  ),
                  SizedBox(width: 30, height: 40),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

