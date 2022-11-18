import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'continuousscanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  List<String> tags=[];

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
    print(tags);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
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
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            Center(
                              child: Text('SELECT SCANNER BY BARCODE',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  width: 111,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: InkWell(
                                    onTap: () => scanBarcodeNormal(),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            'assets/images/barcodelogo.png',
                                            height: 75),
                                        Center(
                                          child: Text(
                                            'Barcode',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 111,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
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
                                Container(
                                  width: 111,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: InkWell(
                                    onTap: () => scanBarcodeNormal(),
                                    child: Column(children: [
                                      Image.asset('assets/images/dualscan.png',
                                          height: 75),
                                      Center(
                                        child: Text(
                                          'April Tag',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    child: Text('SELECT SCANNER BY SCENARIO',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Container(
                        width: 111,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: InkWell(
                          onTap: () => scanBarcodeNormal(),
                          child: Column(
                            children: [
                              Image.asset('assets/images/barcodelogo.png',
                                  height: 75),
                              Center(
                                child: Text(
                                  'Single-Scan',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 111,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: InkWell(
                          onTap: () => QRViewExample(),
                          child: Column(children: [
                            Image.asset('assets/images/qrlogo.png', height: 75),
                            Center(
                              child: Text(
                                'Multi-Scan',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 5),
                          ]),
                        ),
                      ),
                      Container(
                        width: 111,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: InkWell(
                          onTap: () => startBarcodeScanStream(),
                          child: Column(children: [
                            Image.asset('assets/images/dualscan.png',
                                height: 75),
                            Center(
                              child: Text(
                                'Any-Scan',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 5),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text('Scan result : $_scanBarcode\n',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
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
                      child: Text('Multi-Scan Output Here',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  RaisedButton(
                    color: Color.fromARGB(255, 30, 177, 221),
                    shape: StadiumBorder(),
                    onPressed: (() {}),
                    child: Text('Export To Excel'),
                  ),
                  SizedBox(width: 30, height: 40),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.aod), label: 'Scan Result'),
            BottomNavigationBarItem(
                icon: Icon(Icons.apps), label: 'Multi-Scan Output')
          ],
          currentIndex: _selectedIndex,
          onTap: onTapped,
          selectedItemColor: Color.fromARGB(255, 90, 225, 255),
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
