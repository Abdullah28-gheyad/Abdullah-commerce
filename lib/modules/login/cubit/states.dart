abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginWithGoogleLoadingState extends LoginStates {}

class LoginWithGoogleSuccessState extends LoginStates {}

class LoginWithGoogleErrorState extends LoginStates {}

class LoginWithFacebookLoadingState extends LoginStates {}

class LoginWithFacebookSuccessState extends LoginStates {}

class LoginWithFacebookErrorState extends LoginStates {}

class LoginWithEmailLoadingState extends LoginStates{}

class LoginWithEmailSuccessState extends LoginStates{}

class LoginWithEmailErrorState extends LoginStates{}