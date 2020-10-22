import 'dart:async';

import '../connection/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentController extends GetxController {
  var document = <dynamic>[].obs;
  bool loading = true;
  var currentIndex = -1;
  var lastIndex = -1;
  var newIndex = -1;
  var docLength = 0;

  @override
  void onInit() {
    getDocuments();
    super.onInit();
  }

  void getDocuments() async {
    // CALL AN API
    var documentResponse = await API().getDocuments();
    print(documentResponse);
    if (documentResponse == null) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 10.0,
        ),
      );
      loading = false;
    } else {
      loading = false;
      for (var i = 0; i < documentResponse.length; i++) {
        documentResponse[i]['visibility'] = true;
        documentResponse[i]['initIndex'] = i;
        // document.add(documentResponse[i]);
      }
      // print(documentResponse);
      document.addAll(documentResponse);
      docLength = document.length;
    }
  }

  void removeIndex() {
    print('newIndex: $newIndex');
    print('lastIndex: $lastIndex');
    print('document: ${document.toList()}');
    if (newIndex != -1) {
      document.removeAt(newIndex);
      newIndex = -1;
      lastIndex--;
    }
    if (lastIndex != -1) {
      document.removeAt(lastIndex);
      lastIndex = -1;
    }
    currentIndex = -1;
    print('document after: ${document.toList()}');
    update();
  }

  void updateIndex(index) {
    currentIndex = index;
    var addItem = {
      'name': 'Test',
    };

    if (index % 2 == 0) {
      if (index == document.length - 1) {
        var newItem = {
          'name': 'New Business',
          'color': '#6d727c',
          'icon':
              'https://icons.iconarchive.com/icons/zhoolego/material/256/Filetype-Docs-icon.png',
          'visibility': false,
        };
        document.add(newItem);
        newIndex = index + 1;
      }
      document.insert(index + 2, addItem);
      lastIndex = index + 2;
    } else {
      document.insert(index + 1, addItem);
      lastIndex = index + 1;
    }

    // if (newIndex != -1) {
    //   document.removeAt(newIndex);
    // }
    // if (lastIndex != -1) {
    //   document.removeAt(lastIndex);
    // }
    // print('doc: ${document.toList()}');
    // print('length: ${document.length}');
    // print('index: $index');
    // if (index > document.length) {
    //   index = index - 1;
    //   var newItem = {
    //     'name': 'New Business',
    //     'color': '#6d727c',
    //     'icon':
    //         'https://icons.iconarchive.com/icons/zhoolego/material/256/Filetype-Docs-icon.png',
    //     'visibility': false,
    //   };
    //   document.add(newItem);
    //   newIndex = document.length - 1;
    // }
    // if (index % 2 == 0) {
    //   document.insert(index + 2, addItem);
    //   lastIndex = index + 2;
    // } else {
    //   if (index == document.length - 1) {
    //     var newItem = {
    //       'name': 'New Business',
    //       'color': '#6d727c',
    //       'icon':
    //           'https://icons.iconarchive.com/icons/zhoolego/material/256/Filetype-Docs-icon.png',
    //       'visibility': false,
    //     };
    //     document.add(newItem);
    //     document.insert(index + 2, addItem);
    //     lastIndex = index + 2;
    //   } else {
    //     document.insert(index + 1, addItem);
    //     lastIndex = index + 1;
    //   }
    // }

    // print('index: $index');
    // var addItem = {};
    // // print('visibility: ${document.removeAt(lastIndex)}');
    // if (lastIndex != -1) {
    //   print('removeAt: $lastIndex');
    //   document.removeAt(lastIndex);
    //   // if (document.length > docLength) {
    //   //   document.removeLast();
    //   // }
    // }
    // if (index == docLength - 1) {
    //   document.removeWhere((value) => value == null);
    // }
    // if (index % 2 == 0) {
    //   print('docuLength: ${document.length}');
    //   var diff = (index + 2) - (document.length);
    //   print('diff: $diff');
    //   if (diff > 0) {
    //     for (var i = 0; i < diff; i++) {
    //       var newItem = {
    //         'name': 'New Business',
    //         'color': '#6d727c',
    //         'icon':
    //             'https://icons.iconarchive.com/icons/zhoolego/material/256/Filetype-Docs-icon.png',
    //         'visibility': false,
    //       };
    //       document.add(newItem);
    //     }
    //   }
    //   document.insert(index + 2, addItem);
    //   lastIndex = index + 2;
    // } else {
    //   print('else');
    //   document.insert(index + 1, addItem);
    //   lastIndex = index + 1;
    // }
    // print('currentIndex = $index - ${document.length} - $docLength');
    // if (index == docLength) {
    //   currentIndex = index - 1;
    // }
    update();
  }
}
