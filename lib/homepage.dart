// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables
// ignore: sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sg_labs_scanner/multiscantile.dart';
import 'singlescantile.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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

  Future<void> startBarcodeScanStream() async {
    String contiScan;

    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', false, ScanMode.DEFAULT)!
        .listen((contiScan) => tags.add(contiScan));
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.aod), label: 'Scan Result'),
          BottomNavigationBarItem(
              icon: Icon(Icons.apps), label: 'Multi-Scan Output')
        ],
        currentIndex: _selectedIndex,
        onTap: onTapped,
        selectedItemColor: Color.fromARGB(255, 90, 225, 255),
        unselectedItemColor: Colors.grey,
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
                          SizedBox(width: 15),
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
                    SizedBox(width: 65),
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
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text('Scan result : $_scanBarcode\n',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
          Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text('Multi-Scan Output Here',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  RaisedButton(
                    color: Color.fromARGB(255, 30, 177, 221),
                    shape: StadiumBorder(),
                    onPressed: (() {
                    }),
                    child: Text('Export To Excel'),
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
