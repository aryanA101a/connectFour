import 'package:connect_four/connect_four_view_model.dart';
import 'package:connect_four/socketio_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ConnectFourViewModel>(ConnectFourViewModel());
  getIt.registerLazySingleton(() => SocketIOService());
}
