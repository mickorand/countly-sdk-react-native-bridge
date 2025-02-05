
### Using Push Notification Example App
Please visit [Countly React Native documentation page](https://resources.count.ly/docs/react-native-bridge) for further details.

*Usual Instructions for setting up App but npm install from this branch*
```
react-native init DemoProject       # Create a new project

cd DemoProject                      # Go to that directory
cp <PATH_TO>/App.js .               # Copy App.js here into your new react project

# Include SDK
npm install --save https://github.com/Countly/countly-sdk-react-native-bridge.git#android-push
react-native link countly-sdk-react-native-bridge

# In a new terminal
adb reverse tcp:8081 tcp:8081       # Link Android port for development server
npm start                           # Start development server

# In root of DemoProject
react-native run-android # OR       # Run the android project
react-native run-ios                # Run the iOS project


```
*Now comes the steps for FCM integration* 

* Copy your Firebase config file `google-services.json`into `android/app`
* Make these additions to the specified files:
```
# File: android/app/src/main/AndroidManifest.xml

<application>
        <service android:name=".DemoFirebaseMessagingService">
            <intent-filter>
                <action android:name="com.google.firebase.MESSAGING_EVENT" />
            </intent-filter>
        </service>
</application>

# File: android/build.gradle

buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:3.2.0'
    }
}

# File: android/app/build.gradle

dependencies {
    implementation 'com.google.firebase:firebase-messaging:17.3.0'
    implementation 'ly.count.android:sdk-messaging-fcm:19.02.1'
}

// Then at the very bottom of this file
apply plugin: 'com.google.gms.google-services'

```

* Copy `DemoFirebaseMessagingService.java` found here under `android/app/src/main/java/<YOUR_PACKAGE_PATH>`. It should reside near `MainActivity.java`. Change the package name at the top of this file to match your package name.

* Copy `ic_message.png` found here into `android/app/src/main/res/drawable`. Create `drawable` folder if necessary.

*I think that's it. After setting your countly server and app key, you can launch the app. First call/press init, start (may be send a basic event just to make sure) then hit "Setup Push" button. This will get the token from FCM service and send it to Countly (logs should look like below). Then you can test sending message from Countly server.*

```
# Logs after Setup Push
D/Countly (27786): Initializing Countly FCM push
D/Countly (27786): Returning consent for feature named: [push] [true]
D/Countly (27786): Refreshing FCM push token
```
