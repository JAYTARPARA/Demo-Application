import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../controllers/document_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatelessWidget {
  final DocumentController documentController = Get.put(
    DocumentController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        backgroundColor: Colors.indigo[900],
        onTap: (index) {},
        fixedColor: Colors.blue[300],
        unselectedItemColor: Colors.white60,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_input_composite,
            ),
            label: 'More',
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 180.0,
                  color: Colors.indigo[900],
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: Text(
                            'Department of Economic Development',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Obx(
                      () => ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          Visibility(
                            visible: documentController.loading,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 1.8,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SpinKitPulse(
                                    color: Colors.black87,
                                    size: 50.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: documentController.document.isEmpty,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 1.8,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'No document available',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: documentController.document.isNotEmpty,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: StaggeredGridView.countBuilder(
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                itemCount: documentController.document.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var document =
                                      documentController.document[index];
                                  if (index == documentController.lastIndex) {
                                    print(
                                        'Here: $index - ${documentController.lastIndex}');
                                    return GetBuilder<DocumentController>(
                                      builder: (currentIndex) {
                                        return Container(
                                          color: Colors.indigo[900],
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GridView.count(
                                              crossAxisCount: 2,
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              childAspectRatio: 2.50,
                                              children: List.generate(
                                                documentController
                                                    .document[documentController
                                                            .currentIndex]
                                                        ['subcategories']
                                                    .length,
                                                (index) {
                                                  print(
                                                      'sdasd: ${documentController.currentIndex}');
                                                  var subCat = documentController
                                                              .document[
                                                          documentController
                                                              .currentIndex]
                                                      ['subcategories'][index];
                                                  return Card(
                                                    elevation: 3.0,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.network(
                                                              documentController
                                                                  .document[
                                                                      documentController
                                                                          .currentIndex]
                                                                      ['icon']
                                                                  .toString(),
                                                              height: 60.0,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                subCat['subcat_name']
                                                                    .toString(),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    //for odd row
                                    return Visibility(
                                      visible: document['visibility'],
                                      child: Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            print(index);
                                            if (index !=
                                                    documentController
                                                        .currentIndex &&
                                                documentController
                                                        .currentIndex !=
                                                    -1) {
                                              Get.snackbar(
                                                'Error',
                                                'Please close open sub category first',
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white,
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 10.0,
                                                ),
                                              );
                                            } else if (index ==
                                                documentController
                                                    .currentIndex) {
                                              documentController.removeIndex();
                                            } else {
                                              documentController
                                                  .updateIndex(index);
                                            }
                                            // document['subcategories']
                                            //     .forEach((subcat) {
                                            //   print(
                                            //     'catName: ${subcat['subcat_name']}',
                                            //   );
                                            // });
                                            // documentController.document
                                            //     .removeWhere(
                                            //         (value) => value == null);
                                          },
                                          child: ListView(
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            children: [
                                              Card(
                                                elevation: 3.0,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // Image.network(
                                                        //   document['icon']
                                                        //       .toString(),
                                                        //   height: 60.0,
                                                        // ),
                                                        CachedNetworkImage(
                                                          height: 60.0,
                                                          imageUrl:
                                                              document['icon']
                                                                  .toString(),
                                                          placeholder:
                                                              (context, url) =>
                                                                  SpinKitPulse(
                                                            color:
                                                                Colors.black87,
                                                            size: 20.0,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            document['name']
                                                                .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        height: 8.0,
                                                        color: HexColor(
                                                          document['color'],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                staggeredTileBuilder: (int index) =>
                                    index == documentController.lastIndex
                                        ? StaggeredTile.fit(2)
                                        : StaggeredTile.fit(1),
                              ),
                              // child: GridView.count(
                              //   crossAxisCount: 2,
                              //   shrinkWrap: true,
                              //   physics: ScrollPhysics(),
                              //   childAspectRatio: 2.30,
                              //   // childAspectRatio: 2,
                              //   children: List.generate(
                              //     documentController.document.length,
                              //     (index) {
                              //       var document =
                              //           documentController.document[index];
                              //       // print(document);
                              //       return Container(
                              //         child: GestureDetector(
                              //           onTap: () {
                              //             print(index);
                              //             document['subcategories']
                              //                 .forEach((subcat) {
                              //               print(
                              //                 'catName: ${subcat['subcat_name']}',
                              //               );
                              //             });
                              //           },
                              //           child: ListView(
                              //             shrinkWrap: true,
                              //             physics: ScrollPhysics(),
                              //             children: [
                              //               Card(
                              //                 elevation: 3.0,
                              //                 child: Column(
                              //                   children: [
                              //                     Row(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .center,
                              //                       children: [
                              //                         // Image.network(
                              //                         //   document['icon']
                              //                         //       .toString(),
                              //                         //   height: 60.0,
                              //                         // ),
                              //                         CachedNetworkImage(
                              //                           height: 60.0,
                              //                           imageUrl:
                              //                               document['icon']
                              //                                   .toString(),
                              //                           placeholder:
                              //                               (context, url) =>
                              //                                   SpinKitPulse(
                              //                             color: Colors.black87,
                              //                             size: 20.0,
                              //                           ),
                              //                           errorWidget: (context,
                              //                                   url, error) =>
                              //                               Icon(Icons.error),
                              //                         ),
                              //                         Expanded(
                              //                           child: Text(
                              //                             document['name']
                              //                                 .toString(),
                              //                             maxLines: 2,
                              //                             overflow: TextOverflow
                              //                                 .ellipsis,
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                     SizedBox(
                              //                       height: 5.0,
                              //                     ),
                              //                     Align(
                              //                       alignment:
                              //                           Alignment.bottomCenter,
                              //                       child: Container(
                              //                         height: 8.0,
                              //                         color: HexColor(
                              //                           document['color'],
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               // Visibility(
                              //               //   visible:
                              //               //       index == 0 ? true : false,
                              //               //   child: Container(
                              //               //     color: Colors.indigo[900],
                              //               //     child: GridView.count(
                              //               //       crossAxisCount: 2,
                              //               //       shrinkWrap: true,
                              //               //       physics: ScrollPhysics(),
                              //               //       // childAspectRatio: 2.50,
                              //               //       children: List.generate(
                              //               //         document['subcategories']
                              //               //             .length,
                              //               //         (index) {
                              //               //           var subCat = document[
                              //               //                   'subcategories']
                              //               //               [index];
                              //               //           return Card(
                              //               //             elevation: 3.0,
                              //               //             child: Column(
                              //               //               children: [
                              //               //                 Row(
                              //               //                   mainAxisAlignment:
                              //               //                       MainAxisAlignment
                              //               //                           .center,
                              //               //                   children: [
                              //               //                     Image.network(
                              //               //                       document[
                              //               //                               'icon']
                              //               //                           .toString(),
                              //               //                       height: 60.0,
                              //               //                     ),
                              //               //                     Expanded(
                              //               //                       child: Text(
                              //               //                         subCat['subcat_name']
                              //               //                             .toString(),
                              //               //                         maxLines: 2,
                              //               //                         overflow:
                              //               //                             TextOverflow
                              //               //                                 .ellipsis,
                              //               //                       ),
                              //               //                     ),
                              //               //                   ],
                              //               //                 ),
                              //               //               ],
                              //               //             ),
                              //               //           );
                              //               //         },
                              //               //       ),
                              //               //     ),
                              //               //   ),
                              //               // ),
                              //             ],
                              //           ),
                              //         ),
                              //       );
                              //     },
                              //   ),
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 100.0,
              child: Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width / 1.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      15.0,
                    ),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 30.0,
                    )
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        hintText: 'Search here',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
