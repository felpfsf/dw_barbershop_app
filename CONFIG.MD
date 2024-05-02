# USING ENV FILES

In the root directory, create a new folder named "./config" with a file named env.json within.

Example env.json content:

```json
{
  "BASE_URL":"HTTP:url:port"
}

```

Next, create a launcher file by clicking on "Debug and Run". This action will generate a file named "launch.json" inside a .vscode folder. Now, edit the file and add the following line within the first object:

```json
{
  ...
  "args": [
        "--dart-define-from-file",
        ".config/env.json"
  ]
}
```

Then, in the core directory, create a new file named "env.dart". It will contain a class named Env with a baseUrl attribute.

Example:

```dart
final class Env {
  static const baseUrl = String.fromEnvironment('BASE_URL'); 
  // This must match the name of the environment variable declared in the JSON file.
  // You can also declare other environment variables here, such as DEV, PROD, HML, etc.
}
```
