Allow common authentication by firebase auth for all platforms

#### Features

- Login by Google on Mobile, Desktop and Web.

#### Getting started

List prerequisites and provide or point to information on how to
start using the package.

#### Usage

You can check example folder for how to integrate it but **I didn't add real firebase client id**


1- In your app add Auth bloc

```dart  
return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
      ],
      child: MaterialApp(..),
      );
```

2- Add Login functionality to your login page

```dart 
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleLoginButton(
      onPressed: () {
        context.read<AuthBloc>().add(AuthGoogleLoginEvent());
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  //used to get query parameters when google login redirect in web
  final SignInGoogleQueryParameters? queryParameters;

  const LoginPage({Key? key, this.queryParameters}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    initGoogleSignIn();
    context.read<AuthBloc>().add(AuthCheckStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedInState) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: ElevatedButton(
        onPressed: () => context.read<AuthBloc>().add(
              AuthGoogleLoginEvent(),
            ),
        child: const Text('Login By Google'),
      ),
    );
  }
}
  ```
3- Logout by the following event

```dart
context.read<AuthBloc>().add(AuthLogoutEvent());
 ```