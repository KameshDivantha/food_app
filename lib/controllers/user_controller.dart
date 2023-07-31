import 'package:food_delivery/models/user_model.dart';
import 'package:get/get.dart';

import '../data/repository/user_repo.dart';
import '../models/response_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool? _isLoading = false;
  UserModel? _userModel;

  bool? get isLoading => _isLoading;
  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "Successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  // Future<ResponseModel> login(String email, String password) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await authRepo.login(email, password);
  //   late ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     authRepo.saveUserToken(response.body["token"]);
  //     responseModel = ResponseModel(true, response.body["token"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText!);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // void saveUserNumberAndPassword(String number, String password) async {
  //   authRepo.saveUserNumberAndPassword(number, password);
  // }

  // bool userLoggedIn() {
  //   return authRepo.userLoggedIn();
  // }

  // bool clearSharedData() {
  //   return authRepo.clearSharedData();
  // }
}
