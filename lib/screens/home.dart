// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:unitrade_website/authentication/register.dart';
import 'package:unitrade_website/authentication/sign_in.dart';
import 'package:unitrade_website/screens/company/photo_gallery_grid.dart';
import 'package:unitrade_website/screens/footer.dart';
import 'package:unitrade_website/services/database.dart';
import 'package:unitrade_website/shared/dropdown_buttons.dart';
import 'package:unitrade_website/shared/home_page_text.dart';
import 'package:unitrade_website/shared/string.dart';
import 'package:unitrade_website/shared/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:unitrade_website/contact_us/contact_us.dart';
import 'package:unitrade_website/shared/extension.dart';
import 'package:carousel_pro/carousel_pro.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final String uid;
  MyHomePage({this.title, this.uid});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _tabController;
  String paragraphOne, paragraphTwo;
  double columnDistance = 15.0;
  double rowDistance = 10.0;
  List<dynamic> userRoles = [];
  HomePageText homePageText = new HomePageText();

  //Scroll animation
  ScrollController _scrollController;
  double _scrollPosition = 12;
  double _opacity = 1;
  double _containerHeight = 1500.0;
  double _tabBorderRadius = 0;
  List _isHovering = [false, false, false, false, false];
  List<AssetImage> sliderImage = [
    AssetImage('assets/images/home/photo_1.jpg'),
    AssetImage('assets/images/home/photo_2.jpg'),
    AssetImage('assets/images/home/photo_3.jpg'),
  ];
  List<double> _tabHeightsList = [1500.0, 750.0, 750.0, 750.0, 1200.0];
  GlobalKey actionKey;
  //Floating drop down menu variables
  OverlayEntry _floatingDropdown;
  bool _currentOverlay = false;
  double _menuHeight, _menuWidth, xPosition, yPosition;

  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListner);
    actionKey = LabeledGlobalKey(SISTER_COMPANIES);
    super.initState();
    _getCurrentUser();
    getNewLines();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    //calculating opacity according to screen size
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            //Top page container
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          //Home Button
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 190.0,
                                  child: Image.asset(
                                    'assets/images/small_logo.jpg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenSize.width / 20,
                          ),
                          //Our Partners Button
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _visibilityWidget(1),
                              SizedBox(
                                height: 5.0,
                              ),
                              InkWell(
                                key: actionKey,
                                onHover: (val) {
                                  setState(() {
                                    if (val) {
                                      if (!_currentOverlay) {
                                        _currentOverlay = true;
                                        findDropdownData();
                                        _floatingDropdown =
                                            _createFloatingDropdown();
                                        Overlay.of(context)
                                            .insert(_floatingDropdown);
                                      }
                                    }
                                    _isHovering[1] = val;
                                  });
                                },
                                onTap: () {
                                  if (_floatingDropdown != null) {
                                    if (_floatingDropdown.mounted) {
                                      _floatingDropdown.remove();
                                      _currentOverlay = false;
                                      //_floatingDropdown.dispose();
                                    }
                                  } else {
                                    findDropdownData();
                                    _floatingDropdown =
                                        _createFloatingDropdown();
                                    Overlay.of(context)
                                        .insert(_floatingDropdown);
                                  }
                                },
                                child: Container(
                                  width: 100.0,
                                  child: Text(
                                    SISTER_COMPANIES,
                                    style: _isHovering[1]
                                        ? isHovingTextStyle
                                        : isNotHoveringTextStyle,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              _visibilityWidget(1),
                            ],
                          ),
                          SizedBox(
                            width: screenSize.width / 20,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //Register Button
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _visibilityWidget(3),
                              SizedBox(
                                height: 5.0,
                              ),
                              InkWell(
                                onHover: (val) {
                                  setState(() {
                                    _isHovering[3] = val;
                                  });
                                },
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Register();
                                    }),
                                child: Text(
                                  REGISTER,
                                  style: _isHovering[3]
                                      ? isHovingTextStyle
                                      : isNotHoveringTextStyle,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              _visibilityWidget(3),
                            ],
                          ),
                          SizedBox(
                            width: screenSize.width / 50,
                          ),
                          //Sign In Button
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _visibilityWidget(4),
                              SizedBox(
                                height: 5.0,
                              ),
                              InkWell(
                                onHover: (val) {
                                  setState(() {
                                    _isHovering[4] = val;
                                  });
                                },
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SignIn();
                                    }),
                                child: Text(
                                  SIGN_IN,
                                  style: _isHovering[4]
                                      ? isHovingTextStyle
                                      : isNotHoveringTextStyle,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              _visibilityWidget(4),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GestureDetector(
        //Will close the menu list when clicking anywhere on the page
        onTap: () {
          setState(() {
            if (_floatingDropdown != null) {
              if (_floatingDropdown.mounted) {
                _currentOverlay = false;
                _floatingDropdown.remove();
              }
            } else {
              _floatingDropdown.dispose();
            }
          });
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              //Image slider
              Container(
                height: screenSize.height * 0.45,
                width: screenSize.width,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  images: sliderImage,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 400),
                ),
              ),
              //Floating tab bar
              Center(
                heightFactor: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenSize.height * 0.4,
                    left: screenSize.width / 6,
                    right: screenSize.width / 6,
                  ),
                  child: Card(
                    child: _buildTabBar(),
                    color: Colors.blueGrey[300],
                  ),
                ),
              ),
              //Tab bar view
              Container(
                height: _containerHeight,
                child: Center(
                  heightFactor: 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height * 0.50,
                    ),
                    child: Card(
                      child: _buildTabBarView(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //set the overlay render box
  void findDropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    _menuHeight = renderBox.size.height;
    _menuWidth = renderBox.size.width + 20;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  //Overlay entry for menu drop down items
  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: _menuWidth,
        top: yPosition + _menuHeight,
        height: 4 * _menuHeight + 40,
        child: DropDown(
          itemHeight: _menuHeight,
        ),
      );
    });
  }

  //Drop down menu button
  Widget _menuList() {
    List<String> companyList = sisterCompaniesList.companiesList();
    return Container(
      width: 150.0,
      child: DropdownButton<String>(
        isExpanded: true,
        isDense: true,
        onChanged: (val) {
          print(val);
        },
        hint: Text(SISTER_COMPANIES),
        selectedItemBuilder: (BuildContext context) {
          return companyList.map<Widget>((item) {
            return Text(item);
          }).toList();
        },
        items: companyList.map((item) {
          return DropdownMenuItem<String>(
            child: Text(item),
            value: item,
          );
        }).toList(),
      ),
    );
  }

  //Line under the tabs
  Widget _visibilityWidget(int index) {
    return Visibility(
      maintainAnimation: true,
      maintainState: true,
      maintainSize: true,
      visible: _isHovering[index],
      child: Container(
        height: 2.0,
        width: 50.0,
        color: Colors.red,
      ),
    );
  }

  //Scroll Listner
  void _scrollListner() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  //draw text
  void getNewLines() {
    StringBuffer paraOne = new StringBuffer();
    for (String line in HomePageText().paragraphOne)
      paraOne.write(line + '\n\n');

    paragraphOne = paraOne.toString();
  }

  //get current user
  void _getCurrentUser() async {
    if (widget.uid != null) {
      DatabaseService db = new DatabaseService();
      await db.usersCollection.doc(widget.uid).get().then((value) {
        setState(() {
          userRoles = value.data()['roles'];
        });
      });
    } else {
      print('not logged in');
    }
  }

  //Open a dialog
  _openDialog(String title, String data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Text(title),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(width: 2.0),
              ),
              elevation: 1.0,
              backgroundColor: Colors.grey[300],
              content: Container(width: 500.0, child: Text(data)),
            ),
          );
        });
  }

  Widget _homePageBuild(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 450.0,
          width: 1310.0,
          child: Center(
            child: CarouselSlider(
              options: CarouselOptions(
                  height: 440.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5)),
              items: [
                'assets/images/home/photo_1.jpg',
                'assets/images/home/photo_2.jpg',
                'assets/images/home/photo_3.jpg'
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(i);
                  },
                );
              }).toList(),
            ),
          ),
        ),
        Container(
          height: 200.0,
          width: 450.0,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      onTap: (val) => _changeContainerHeight(val),
      controller: _tabController,
      isScrollable: true,
      unselectedLabelColor: Colors.white,
      indicator: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(_tabBorderRadius)),
      tabs: [
        Tab(
          text: HOME_TAB,
        ).moveUpOnHover,
        Tab(
          text: PHOTO_GALLERY_TAB,
        ).moveUpOnHover,
        Tab(
          text: CLIENTS_TAB,
        ).moveUpOnHover,
        Tab(
          text: SUPPLIERS_TAB,
        ).moveUpOnHover,
        Tab(
          text: Contact_US_TAB,
        ).moveUpOnHover,
      ],
    );
  }

  void _changeContainerHeight(var value) {
    if (_containerHeight > _tabHeightsList[value])
      Future.delayed(Duration(milliseconds: 350), () {
        setState(() {
          _containerHeight = _tabHeightsList[value];
          _tabBorderRadius = 12.0;
        });
      });
    else
      setState(() {
        _containerHeight = _tabHeightsList[value];
        _tabBorderRadius = 12.0;
      });
  }

  //Tab Bar View
  Widget _buildTabBarView() {
    return TabBarView(controller: _tabController, children: [
      _homePageDetails(),
      _photoGalleryDetails(),
      _clientPageDetails(),
      _suppliersPageDetails(),
      _contactUsPageDetails(),
    ]);
  }

  //Home Page Details
  Widget _homePageDetails() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: new Text(
                  paragraphOne,
                  textAlign: TextAlign.left,
                  style: textStyleParagraph,
                ),
              ),
              SizedBox(
                width: rowDistance,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset(
                      'assets/images/home/nesma_holding_p1.jpg',
                    ),
                  )),
            ],
          ),
          Row(children: [
            Expanded(
                flex: 1,
                child: Text(HomePageText().ourProducts,
                    style: textStyleParagraph3))
          ]),
          SizedBox(
            height: columnDistance,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                _productListCategoris(),
                SizedBox(
                  width: rowDistance,
                ),
                Expanded(
                  flex: 2,
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                      height: 350.0,
                      width: 700.0,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset(
                          'assets/images/home/wood_in_style.jpg',
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        HomePageText().imageCaption_1,
                        style: textStyleParagraph4,
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
          SizedBox(
            height: columnDistance,
          ),
          FooterWidget()
        ],
      ),
    );
  }

  //Company Page Details
  Widget _photoGalleryDetails() {
    return Container(
      child: PhotoGalleryGrid(),
    );
  }

  //Clients Page
  Widget _clientPageDetails() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'assets/images/coming_soon.jpg',
          scale: 2,
        ).moveUpOnHover,
      ),
    );
  }

  //Suppliers page
  Widget _suppliersPageDetails() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'assets/images/coming_soon.jpg',
          scale: 2,
        ).moveUpOnHover,
      ),
    );
  }

  //Contact Us
  Widget _contactUsPageDetails() {
    return Container(
      child: ContactUs(),
    );
  }

  //Build Product Categories List
  Widget _productListCategoris() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Solid Wood
        Container(
          child: InkWell(
            child: Text(
              HomePageText().solidWood,
              style: textStyleParagraph2,
            ),
            onTap: () =>
                _openDialog(homePageText.solidWood, homePageText.solidWoodDesc),
          ),
        ),
        SizedBox(
          height: columnDistance,
        ),
        //HPL
        Container(
          child: InkWell(
            child: Text(
              HomePageText().hpl,
              style: textStyleParagraph2,
            ),
            onTap: () => _openDialog(homePageText.hpl, homePageText.hplDesc),
          ),
        ),
        SizedBox(
          height: columnDistance,
        ),
        //MDF
        Container(
          child: InkWell(
            child: Text(
              HomePageText().mdf,
              style: textStyleParagraph2,
            ),
            onTap: () => _openDialog(homePageText.mdf, homePageText.mdfDesc),
          ),
        ),
        SizedBox(
          height: columnDistance,
        ),
        //MFC
        Container(
          child: InkWell(
            child: Text(
              HomePageText().mfc,
              style: textStyleParagraph2,
            ),
            onTap: () => _openDialog(homePageText.mfc, homePageText.mfcDesc),
          ),
        ),
        SizedBox(
          height: columnDistance,
        ),
        //Door Cores
        Container(
          child: InkWell(
            child: Text(
              HomePageText().doorCore,
              style: textStyleParagraph2,
            ),
            onTap: () =>
                _openDialog(homePageText.doorCore, homePageText.doorCoreDesc),
          ),
        ),
        SizedBox(
          height: columnDistance,
        ),
        //Solid Surface
        Container(
          child: InkWell(
            child: Text(
              HomePageText().solidSurface,
              style: textStyleParagraph2,
            ),
            onTap: () => _openDialog(
                homePageText.solidSurface, homePageText.solidSurfaceDesc),
          ),
        ),
        SizedBox(
          height: columnDistance,
        ),
        //Furniture Fittings
        Container(
          child: InkWell(
            child: Text(
              HomePageText().furnitureFittings,
              style: textStyleParagraph2,
            ),
            onTap: () => _openDialog(homePageText.furnitureFittings,
                homePageText.funitureFittingsDesc),
          ),
        ),
        SizedBox(
          height: columnDistance,
        ),
        //Coatings and adhesives
        Container(
          child: InkWell(
            child: Text(
              HomePageText().coatingsAndAdh,
              style: textStyleParagraph2,
            ),
            onTap: () => _openDialog(
                homePageText.coatingsAndAdh, homePageText.coatingsAndAdhDesc),
          ),
        ),
        SizedBox(
          height: columnDistance,
        ),
        //Spray Machines
        Container(
          child: InkWell(
            child: Text(
              HomePageText().sprayMachines,
              style: textStyleParagraph2,
            ),
            onTap: () => _openDialog(
                homePageText.sprayMachines, homePageText.sprayMachinesDesc),
          ),
        ),
      ],
    );
  }
}
