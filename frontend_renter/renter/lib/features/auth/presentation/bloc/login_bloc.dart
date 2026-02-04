import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
    final LoginUsecase loginUsecase;

    LoginBloc({required this.loginUsecase}) : super(LoginInitial()) {
        on<LoginSubmitted>(_onLoginSubmitted);
    }

    Future<void> _onLoginSubmitted(
        LoginSubmitted event,
        Emitter<LoginState> emit,
    ) async {
        emit(LoginLoading());

        final result = await loginUsecase(
            phoneNumber: event.phoneNumber,
            password: event.password
        );

        result.fold(
            (failure) => emit(LoginFailure(error: failure)),
            (user) => emit(LoginSuccess(message: "Đăng nhập thành công")),
        );
    }
}