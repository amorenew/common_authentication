Allow common authentication by firebase auth for all platforms

## Features

- Login by Google on Mobile, Desktop and Web.

## Getting started

List prerequisites and provide or point to information on how to
start using the package.

## Usage

 Include short and useful examples for package users. Add longer examples
to `/example` folder.


## Additional information

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
