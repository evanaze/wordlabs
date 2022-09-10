import 'package:get/get.dart';
import 'package:wordlabs/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
  }

  getUserData() async {
    List<String> thumbnails = [];
    var myPosts = await firestore
        .collection('posts')
        .where('uid', isEqualTo: _uid.value)
        .get();
  }
}
