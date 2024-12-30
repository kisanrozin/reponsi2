import 'package:auth/app/http/controllers/auth_controller.dart';
import 'package:auth/app/http/controllers/jemput_controller.dart';
import 'package:auth/app/http/controllers/user_controller.dart';
import 'package:auth/app/http/middleware/authenticate.dart';

import 'package:vania/vania.dart'; 

class ApiRoute implements Route {
  @override
  void register() {

    Router.basePrefix('api');


    Router.group(() {
      Router.post('register', authController.register);
      Router.post('login', authController.login);
    }, prefix: 'auth');


    Router.group(() {
      Router.get('me', userController.index);
    }, prefix: 'user', middleware: [AuthenticateMiddleware()]);

    Router.group(() {
      Router.get('/jemput', sampahRequestController.index);
      Router.post('/jemput', sampahRequestController.create);
      Router.get('/jemput/:id', sampahRequestController.show);
      Router.put('/jemput/:id', sampahRequestController.update);
      Router.delete('/jemput/:id', sampahRequestController.destroy);
    }, prefix: 'sampah');
  }
}