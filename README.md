Allow common authentication by firebase auth for all platforms

## Features

- Login by Google on Mobile, Desktop and Web.

## Getting started

List prerequisites and provide or point to information on how to
start using the package.

## Usage

 Include short and useful examples for package users. Add longer examples
to `/example` folder.


1- In yout app add Auth bloc

    ```dart return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
      ],
      child: MaterialApp());
```

2- 

```dart 
class LoginPage extends StatefulWidget {
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
                      child: const GoogleSignInButton(),
                    );
            }
  }
  ```
