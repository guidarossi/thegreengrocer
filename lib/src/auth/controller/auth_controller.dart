import 'package:get/get.dart';
import 'package:thegreengrocer/src/auth/models/user_model.dart';
import 'package:thegreengrocer/src/auth/repository/auth_repository.dart';
import 'package:thegreengrocer/src/auth/result/auth_result.dart';
import 'package:thegreengrocer/src/auth/services/utils_services.dart';

import '../constants/storage_keys.dart';
import '../pages_routes/app_pages_routes.dart';

class AuthController extends GetxController {
  //variavel que indica sempre que o app estiver carregando a tela signin
  RxBool isLoading = false.obs;

  final UtilsServices utilsServices = UtilsServices();
  final authRepository = AuthRepository();
  
  UserModel user = UserModel();

  // @override
  // void onInit(){
  //   super.onInit();
  //
  //   validateToken();
  //
  // }

  //validacao do token
  Future<void> validateToken()async{

    //Recuperar o token que foi salvo localmente
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if(token == null){

      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
        success: (user){
          this.user = user;

          saveTokenAndProceedToBase();
        },
        error: (message){
          signOut();
        },
    );
  }

  Future<void> signOut()async{

    //Zerar o user
    user = UserModel();

    //Remover o token localmente
    await utilsServices.removeLocalData(key: StorageKeys.token);

    //Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);

  }


  void saveTokenAndProceedToBase(){

    //Salvar o token
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);

    //Ir para tela base
    Get.offAllNamed(PagesRoutes.baseRoute);

  }


  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result = await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    //verificação login
    result.when(
        success: (user){
          this.user = user;
          
          saveTokenAndProceedToBase();
        },
        error: (message){

          utilsServices.showToast(
              message: message,
              isError: true,
          );

        },);
  }
}
