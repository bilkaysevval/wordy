import 'package:fluttertoast/fluttertoast.dart';

import '../project_utilities/colors_utility.dart';

void customToastMsg(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: ColorsUtility.sorbus,
      textColor: ColorsUtility.daintree,
      fontSize: 16);
}
