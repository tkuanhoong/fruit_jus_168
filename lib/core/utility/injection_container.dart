import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fruit_jus_168/features/auth/data/datasources/auth_api_service.dart';
import 'package:fruit_jus_168/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fruit_jus_168/features/auth/domain/repositories/auth_repository.dart';
import 'package:fruit_jus_168/features/auth/domain/usecases/log_out.dart';
import 'package:fruit_jus_168/features/auth/domain/usecases/save_user_info.dart';
import 'package:fruit_jus_168/features/auth/domain/usecases/verify_otp.dart';
import 'package:fruit_jus_168/features/auth/domain/usecases/verify_phone.dart';
import 'package:fruit_jus_168/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  /// Firebase Auth
  final auth = FirebaseAuth.instance;
  // Firebase Firestore
  final fireStore = FirebaseFirestore.instance;
  // Firebase Storage
  final FirebaseStorage storage = FirebaseStorage.instance;

  sl.registerSingleton<FirebaseAuth>(auth);
  sl.registerSingleton<FirebaseFirestore>(fireStore);
  sl.registerSingleton<FirebaseStorage>(storage);

  // Dependencies
  sl.registerSingleton<AuthApiService>(AuthApiService(sl(), sl()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<SaveUserInfoUseCase>(SaveUserInfoUseCase(sl()));
  sl.registerSingleton<VerifyPhoneUseCase>(VerifyPhoneUseCase(sl()));
  sl.registerSingleton<VerifyOtpUseCase>(VerifyOtpUseCase(sl()));
  sl.registerSingleton<LogOutUseCase>(LogOutUseCase(sl()));

  // Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl(), sl(), sl()));
}
