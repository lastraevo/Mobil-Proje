import 'dart:convert';
import 'dart:io';
import 'package:malzemetkp/mongodb.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Mongo123.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Poppins'),
          home: Home(),
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

var editingController = TextEditingController();
var controllerad = TextEditingController();
var controlleradet = TextEditingController();
var controllerkategori = TextEditingController();
var controllerkonum = TextEditingController();
var cozellik1 = TextEditingController();
var cozellik11 = TextEditingController();
var cozellik2 = TextEditingController();
var cozellik21 = TextEditingController();
var cozellik3 = TextEditingController();
var cozellik31 = TextEditingController();
var cozellik4 = TextEditingController();
var cozellik41 = TextEditingController();
var cozellik5 = TextEditingController();
var cozellik51 = TextEditingController();
TextEditingController controller = TextEditingController();
List<Map<String, dynamic>> indexedmalzemeler = [];

class _HomeState extends State<Home> {
  String textfield = "";
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var ad = controllerad.text;
  var onay = false;
  var kategori = controllerkategori.text;
  int kkk = 0;
  String img = "";
  var hata = TextEditingController();
  int adett = 0;
  List<String> veri1 = [];
  int count = 0;

  void updateList(String value) {
    setState(() {});
  }

  final rakam = 0;

  File? image;

  Future pickimage(ImageSource asd) async {
    try {
      final image = await ImagePicker().pickImage(source: asd);
      if (image == null) return;
      final imageTemporary = File(image.path);

      setState((() => this.image = imageTemporary));
    } on PlatformException catch (e) {
    }
  }
  Map<String, Map<String, dynamic>> malzemeler = {};
  List<String> kategoriler = [];
  List<String> konumlar = [];
  @override
  bool kategoriopen = false;
  bool konumopen = false;
  @override
  Widget build(BuildContext context) {
    bool isSize = 1.sp > 1.7;
    return Scaffold(
      key: scaffoldkey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: isSize ? 4.h : 6.h,
        centerTitle: true,
        elevation: 10,
        foregroundColor: Color(0xffEEEEEE),
        backgroundColor: Color(0xFF222831),
        title: Text("Malzeme Takip Uygulaması"),
      ),
      body: Container(
        color: Color(0xFFF9F5EB),
        child: Center(
          child: FutureBuilder(
            future: Mongo123.getQueryData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot == null) {
                return Container();
              }
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                indexedmalzemeler = snapshot.data;

                print(snapshot.data);
                print('Deneme File : ${File("").path}');
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      onay == true
                          ? Container(
                              margin: EdgeInsets.only(
                                  left: 2.h, right: 2.h, top: 2.h, bottom: 2.h),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    textfield = value;
                                  });
                                },
                                controller: editingController,
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                        color: Color(0xff222831),
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                          color: Color(0xff222831),
                                          width: 0.2.h,
                                        )),
                                    labelText: "Ara",
                                    hintText: "Ara",
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Color(0xff222831),
                                      size: 15.sp,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    )),
                              ),
                            )
                          : SizedBox(height: 0.h),
                      Expanded(
                        child: ListView.builder(
                            itemCount: indexedmalzemeler.length,
                            itemBuilder: (context, index) {
                              if (!konumlar.contains(
                                  indexedmalzemeler[index]["konum"])) {
                                konumlar.add(indexedmalzemeler[index]["konum"]);
                                kategoriler
                                    .add(indexedmalzemeler[index]["Kategori"]);
                              }
                              Map<String, dynamic> ozellikler =
                                  indexedmalzemeler[index]["ozellikler"];
                              List<String> ozellikkeys =
                                  ozellikler.keys.toList();
                              List<dynamic> ozellikvalues =
                                  ozellikler.values.toList();
                              print(
                                  'denemeşer : ${indexedmalzemeler[index]["Adet"]}');
                              print(ozellikvalues);
                              
                              if (indexedmalzemeler[index]["Malzeme"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(textfield.toLowerCase()) ||
                                  indexedmalzemeler[index]["Kategori"]
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(textfield.toLowerCase()) ||
                                  indexedmalzemeler[index]["konum"]
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(textfield.toLowerCase())) {
                                return Container(
                                  child: Container(
                                    child: Card(
                                      margin: EdgeInsets.only(
                                          bottom: 0.9.h,
                                          left: 1.h,
                                          right: 1.h,
                                          top: 0.9.h),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 0.5.w,
                                          color: Color(0xff222831),
                                        ),
                                      ),
                                      color: index % 2 == 0
                                          ? Color(0xFFEAE3D2)
                                          : Color(0xffCECECE),
                                      child: Container(
                                        child: ExpansionTile(
                                            backgroundColor: Color(0xff00E90),
                                            leading: Icon(Icons.storage,
                                                size: isSize ? 15.sp : 25.sp,
                                                color: Color(0xff607EAA),
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 1)
                                                ]),
                                            title: Container(
                                                padding: EdgeInsets.only(
                                                    bottom: 1.w),
                                                margin: EdgeInsets.only(
                                                    bottom: 1.w),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0.5.w,
                                                            color: Color(
                                                                0xff222831)))),
                                                child: Text(
                                                  indexedmalzemeler[index]
                                                              ["Malzeme"] !=
                                                          null
                                                      ? indexedmalzemeler[index]
                                                          ["Malzeme"]
                                                      : "",
                                                  style: GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          color:
                                                              Color(0xFF222831),
                                                          fontSize: isSize
                                                              ? 8.sp
                                                              : 15.sp,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )),
                                            subtitle: Text(
                                              indexedmalzemeler[index]
                                                          ["Adet"] !=
                                                      null
                                                  ? "Kategori: ${indexedmalzemeler[index]["Kategori"]}  \nKonum:  ${indexedmalzemeler[index]["konum"]}"
                                                  : "",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Color(0xFF222831),
                                                      fontSize: isSize
                                                          ? 6.sp
                                                          : 10.sp)),
                                            ),
                                            trailing:
                                                File(indexedmalzemeler[index]
                                                                ["foto"])
                                                            .path !=
                                                        ""
                                                    ? ClipOval(
                                                        child: Image.file(
                                                          File(
                                                              '${indexedmalzemeler[index]["foto"]}'),
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 50,
                                                        height: 50,
                                                      ),
                                            children: [
                                              Container(
                                                height: isSize? (5.h * ozellikkeys.length) +1.h: (8.h * ozellikkeys .length) +1.h,
                                                child: ListView.builder(
                                                    itemCount:
                                                        ozellikkeys.length,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index2) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                border: Border(
                                                          top: BorderSide(
                                                            width: 0.5.w,
                                                            color: Color(
                                                                0xff222831),
                                                          ),
                                                        )),
                                                        child: Container(
                                                          height: isSize
                                                              ? 5.h
                                                              : 8.h,
                                                          child: ListTile(
                                                            title: Container(
                                                                height: 7.h,
                                                                child: Text(
                                                                  "${ozellikvalues[index2]} ",
                                                                  style: GoogleFonts.poppins(
                                                                      textStyle: TextStyle(
                                                                          fontSize: isSize? 5.sp: 8.sp)),
                                                                )),
                                                            leading: Container(
                                                              height: 7.h,
                                                              width: 35.w,
                                                              child: Text(
                                                                "${ozellikkeys[index2]} :",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        textStyle:
                                                                            TextStyle(
                                                                  fontSize:
                                                                      isSize
                                                                          ? 5.sp
                                                                          : 8.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              Container(
                                                height: isSize ? 6.h : 8.h,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                  top: BorderSide(
                                                    width: 0.5.w,
                                                    color: Color(0xff222831),
                                                  ),
                                                )),
                                                child: ListTile(
                                                    leading: Text(
                                                        "${indexedmalzemeler[index]["Adet"]}\nAdet",
                                                        style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: isSize ? 7.sp : 10.sp,
                                                                color: Color(
                                                                    0xff222831),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    trailing: Container(
                                                      width:
                                                          isSize ? 50.w : 70.w,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                              width: isSize? 6.w: 10.w,
                                                              height: isSize ? 6.w: 10.w,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  int kk = indexedmalzemeler[index]["Adet"];
                                                                  int cc = int.parse(controller.text);
                                                                  setState(() {
                                                                    Mongo123.ekle( kk, cc);
                                                                  });
                                                                  controller .text ="0";
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .task_alt,
                                                                  color: Colors
                                                                      .white,
                                                                  size: isSize
                                                                      ? 10.sp
                                                                      : 15.sp,
                                                                ),
                                                                style: ButtonStyle(
                                                                    padding: MaterialStateProperty.all(
                                                                        EdgeInsets
                                                                            .zero),
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            Colors.lightGreen)),
                                                              )),
                                                          SizedBox(
                                                            width: isSize ? 6.w: 10.w,
                                                            height: isSize? 6.w: 10.w,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  int adet1=indexedmalzemeler[index]["Adet"];
                                                                  int adet = (indexedmalzemeler[ index]["Adet"]);
                                                                  setState(() {
                                                                    Mongo123.ekle(adet, 1);
                                                                  });
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                              ),
                                                              style: ButtonStyle(
                                                                  padding: MaterialStateProperty.all(
                                                                      EdgeInsets
                                                                          .zero),
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(
                                                                          Color( 0xff7C99AC))),
                                                            ),
                                                          ),
                                                          Container(
                                                              margin: EdgeInsets.only(),
                                                              child: Container(
                                                                width: isSize? 10.w : 15.w,
                                                                child:
                                                                    TextField(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLength: 4,
                                                                  controller:
                                                                      controller,
                                                                  keyboardType:
                                                                      TextInputType.number,
                                                                  decoration: InputDecoration(
                                                                      counterText:"",
                                                                      labelText:"${kkk}",
                                                                      border: OutlineInputBorder(
                                                                          borderSide: BorderSide(color: Color(0xff222831)))),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: isSize ? 8.sp : 10.sp,
                                                                    color: Color( 0xff222831),
                                                                  ),
                                                                  onSubmitted:
                                                                      (text) {
                                                                    setState(
                                                                        () {
                                                                      int text1 =int.parse(  controller.text);
                                                                      kkk =text1;
                                                                      int adet = (indexedmalzemeler[index]["Adet"]);
                                                                    });
                                                                  },
                                                                ),
                                                              )),
                                                          SizedBox(
                                                            width: isSize? 6.w: 10.w,
                                                            height: isSize ? 6.w : 10.w,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                              int adet = (indexedmalzemeler[ index]["Adet"]);
                                                              setState(() {
                                                              Mongo123.ekle(adet, -1);
                                                              });
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                              ),
                                                              style: ButtonStyle(
                                                                  padding: MaterialStateProperty.all(
                                                                      EdgeInsets
                                                                          .zero),
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(
                                                                          Color(0xff7C99AC))),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: isSize? 6.w : 15.w,
                                                              height: isSize ? 6.w: 10.w,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (BuildContext
                                                                                context) =>
                                                                            AlertDialog(
                                                                                actionsAlignment: MainAxisAlignment.center,
                                                                                title: Text("Silmek istiyor musun?",
                                                                                  style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.bold)),
                                                                                ),
                                                                                actions: [
                                                                                  ElevatedButton(
                                                                                    onPressed: () {
                                                                                      setState(() {
                                                                                        Mongo123.userCollection.deleteOne(indexedmalzemeler[index]);
                                                                                      });
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Text(
                                                                                      "Evet",
                                                                                      style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.bold)),
                                                                                    ),
                                                                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Text(
                                                                                      "Hayır",
                                                                                      style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.bold)),
                                                                                    ),
                                                                                  )
                                                                                ]));
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .white,
                                                                  size: isSize ? 10.sp: 15.sp,
                                                                ),
                                                                style: ButtonStyle(
                                                                    padding: MaterialStateProperty.all( EdgeInsets.zero),
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all( Colors.redAccent)),
                                                              ))
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 2.w),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Color(0xff222831)),
          onPressed: () {
            setState(() {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    StatefulBuilder(builder: (context, setstate2) {
                  return AlertDialog(
                    shape: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.8.w)),
                    backgroundColor: Color(0xff222831),
                    content: Container(
                      height: isSize ? 55.h : 35.h,
                      child: Column(
                        children: [
                          Text(
                            "Malzeme Ekleyin",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: isSize ? 10.sp : 15.sp,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                              width: isSize ? 85.w : 70.w,
                              height: 2.5.h,
                              child: Container(
                                margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
                                color: Colors.blueGrey,
                              )),
                          Container(
                            height: isSize ? 46.h : 23.h,
                            width: 100.w,
                            child: ListView(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: 1.5.h, top: 0.5.h),
                                  child: TextField(
                                    controller: controllerad,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        prefixIcon: Icon(FontAwesomeIcons.list,
                                            color: Colors.white),
                                        labelText: 'Malzeme Adı:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    controller: controlleradet,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        labelText: 'Adet:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    controller: controllerkategori,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        labelText: 'Kategori:',
                                        prefixIcon: Icon(Icons.account_tree,
                                            color: Colors.white),
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    style: TextStyle(color: Colors.white),
                                    controller: controllerkonum,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        labelText: 'Konum:',
                                        prefixIcon: Icon(
                                            FontAwesomeIcons.locationDot,
                                            color: Colors.white),
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Text("Fotoğraf ekle:",
                                    style: TextStyle(
                                        fontSize: isSize ? 10.sp : 15.sp,
                                        color: Colors.white)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    image != null
                                        ? ClipOval(
                                            child: Image.file(
                                              image!,
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : CircleAvatar(),
                                    ElevatedButton(
                                        onPressed: () {
                                          pickimage(ImageSource.gallery);
                                        },
                                        child: Icon(Icons.add)),
                                    ElevatedButton(
                                        onPressed: () =>
                                            pickimage(ImageSource.camera),
                                        child: Icon(Icons.camera_alt_outlined)),
                                  ],
                                ),
                                Text("Özellikler",
                                    style: TextStyle(
                                        fontSize: isSize ? 10.sp : 15.sp,
                                        color: Colors.white)),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    controller: cozellik11,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        prefixIcon: Icon(
                                            FontAwesomeIcons.heading,
                                            color: Colors.white),
                                        labelText: 'Özellik-1:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    controller: cozellik1,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        prefixIcon: Icon(FontAwesomeIcons.inbox,
                                            color: Colors.white),
                                        labelText: 'Özellik-1:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    controller: cozellik21,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        prefixIcon: Icon(
                                            FontAwesomeIcons.heading,
                                            color: Colors.white),
                                        labelText: 'Özellik-2:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    controller: cozellik2,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        prefixIcon: Icon(FontAwesomeIcons.inbox,
                                            color: Colors.white),
                                        labelText: 'Özellik-2:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    controller: cozellik31,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        prefixIcon: Icon(
                                            FontAwesomeIcons.heading,
                                            color: Colors.white),
                                        labelText: 'Özellik-3:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    controller: cozellik3,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        prefixIcon: Icon(FontAwesomeIcons.inbox,
                                            color: Colors.white),
                                        labelText: 'Özellik-3:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    controller: cozellik41,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        prefixIcon: Icon(
                                            FontAwesomeIcons.heading,
                                            color: Colors.white),
                                        labelText: 'Özellik-4:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    controller: cozellik4,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        prefixIcon: Icon(FontAwesomeIcons.inbox,
                                            color: Colors.white),
                                        labelText: 'Özellik-4:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    controller: cozellik51,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        prefixIcon: Icon(
                                            FontAwesomeIcons.heading,
                                            color: Colors.white),
                                        labelText: 'Özellik-5:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 1.5.h),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: TextStyle(color: Colors.white),
                                    controller: cozellik5,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5.w)),
                                        prefixIcon: Icon(FontAwesomeIcons.inbox,
                                            color: Colors.white),
                                        labelText: 'Özellik-5:',
                                        labelStyle: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    isSize ? 7.sp : 10.sp))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: isSize ? 85.w : 70.w,
                              height: 2.5.h,
                              child: Container(
                                margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
                                color: Colors.blueGrey,
                              )),
                        ],
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                controllerad.text = "";
                                controllerkategori.text = "";
                                controllerkonum.text = "";
                                controlleradet.text = "";
                                cozellik1.text = "";
                                cozellik11.text = "";
                                cozellik2.text = "";
                                cozellik21.text = "";
                                cozellik3.text = "";
                                cozellik31.text = "";
                                cozellik4.text = "";
                                cozellik41.text = "";
                                cozellik5.text = "";
                                cozellik51.text = "";
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.redAccent,
                                  shadowColor: Colors.black,
                                  onPrimary: Colors.black,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(),
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  minimumSize: isSize
                                      ? Size(20.w, 5.h)
                                      : Size(22.w, 6.h))),
                          Container(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF42855B),
                                  onPrimary: Color(0xff393E46),
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                  minimumSize: isSize
                                      ? Size(30.w, 5.h)
                                      : Size(45.w, 6.h), //////// HERE
                                ),
                                onPressed: () async {
                                  Map<String, dynamic> ozellikler = {};

                                  print(kategori);
                                  if (controllerad.text == "" ||
                                      controllerkategori.text == "" ||
                                      controllerkonum.text == "") {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                                title: Text(
                                              "Malzeme Adı,Kategori ve Konum\n\nBoş olamaz lütfen tekrar girin!!!",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.redAccent),
                                            )));
                                  } else {
                                    if (cozellik51.text != "") {
                                      ozellikler[cozellik51.text] =
                                          cozellik5.text;
                                    }
                                    if (cozellik41.text != "") {
                                      ozellikler[cozellik41.text] =
                                          cozellik4.text;
                                    }
                                    if (cozellik31.text != "") {
                                      ozellikler[cozellik31.text] =
                                          cozellik3.text;
                                    }
                                    if (cozellik21.text != "") {
                                      ozellikler[cozellik21.text] =
                                          cozellik2.text;
                                    }
                                    if (cozellik11.text != "") {
                                      ozellikler[cozellik11.text] =
                                          cozellik1.text;
                                    }

                                    if (controlleradet.text == "") {
                                      controlleradet.text = "0";
                                    }
                                    if (image == null) {
                                      img = "";
                                    } else {
                                      img = image!.path;
                                    }

                                    await Mongo123.userCollection.insertOne({
                                      "Malzeme":
                                          controllerad.text.toUpperCase(),
                                      "Adet": int.parse(controlleradet.text),
                                      "Kategori":
                                          controllerkategori.text.toUpperCase(),
                                      "ozellikler": ozellikler,
                                      "konum":
                                          controllerkonum.text.toUpperCase(),
                                      "foto": img
                                    });
                                    setState(() {
                                      controllerad.text = "";
                                      controllerkategori.text = "";
                                      controllerkonum.text = "";
                                      controlleradet.text = "";
                                      cozellik1.text = "";
                                      cozellik11.text = "";
                                      cozellik2.text = "";
                                      cozellik21.text = "";
                                      cozellik3.text = "";
                                      cozellik31.text = "";
                                      cozellik4.text = "";
                                      cozellik41.text = "";
                                      cozellik5.text = "";
                                      cozellik51.text = "";
                                      img = "";
                                      image = null;
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  "Ekle",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              );
            });
          }),
      bottomNavigationBar: Container(
        height: isSize ? 4.h : 7.h,
        child: BottomAppBar(
            color: Color(0xff222831),
            shape: CircularNotchedRectangle(),
            notchMargin: 6,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      size: isSize ? 15.sp : 25.sp,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>MyApp() ));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: onay ? Colors.amber : Colors.white,
                      size: isSize ? 15.sp : 25.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        if (onay == true) {
                          onay = false;
                        } else {
                          onay = true;
                        }
                      });
                    },
                  ),
                ])),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class Veri {
  String? ad1;
  String? Kategori1;
  int? adet1 = 0;

  Veri(this.ad1, this.Kategori1, this.adet1);
}


