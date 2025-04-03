class LoginState {
  bool? isLoading;
  String? errorMsg;

  LoginState({
    this.isLoading,
    this.errorMsg,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMsg,
  }) =>
      LoginState(
        isLoading: isLoading ?? this.isLoading,
        errorMsg: errorMsg ?? this.errorMsg,
      );
}