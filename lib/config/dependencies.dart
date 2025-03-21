import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/repositories/auth/auth_repository.dart';
import 'package:todo/data/repositories/auth/auth_firebase_repository.dart';
import 'package:todo/data/repositories/todo/todo_repository.dart';
import 'package:todo/data/repositories/todo/todo_firebase_repository.dart';
import 'package:todo/data/services/firebase/auth_firebase_service.dart';
import 'package:todo/data/services/firebase/todo_firestore_service.dart';

List<SingleChildWidget> get providerRemote {
  return [
    Provider(
      create: (context) => AuthFirebaseService(),
    ),
    Provider(
      create: (context) => TodoFirestoreService(),
    ),
    Provider(
      create: (context) => TodoFirebaseRepository(
        service: context.read(),
      ) as TodoRepository,
    ),
    ChangeNotifierProvider(
      create: (context) => AuthFirebaseRepository(
        service: context.read(),
      ) as AuthRepository,
    ),
  ];
}
