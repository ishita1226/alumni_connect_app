part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable{@override
  List<Object> get props => [];}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}