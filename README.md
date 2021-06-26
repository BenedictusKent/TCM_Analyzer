## TCM (Traditional Chinese Medicine) Analyzer

A mobile application with camera feature and model prediction.  

## ⚠️ Note ⚠️

This app is developed on Samsung A52 5G.  
All dimensions in this app are all catered to this phone.  
If used on other phones, some adjustments are required. 

## Things to install

- Flutter
- IDE (VS Code, Android Studio, etc.)

## Installation  

### Flutter
1. Go to Flutter official website ([here](https://flutter.dev/docs/get-started/install)).
2. Select which OS on which you are installing Flutter on.
3. Follow detailed guides.

### IDE: VS Code
1. Download VS Code ([here](https://code.visualstudio.com/)).
2. Once download is finished, start VS Code.
3. Go to ```Extensions``` tab on the left-hand side or click and hold ```(Ctrl+Shift+X)```.  
   - If above instruction doesn't work, click ```View -> Command Palette```.  
   - Type "install", and select **Extensions: Install Extensions**.
4. Type "flutter" in the extensions search field, select **Flutter** in the list, and click **Install**. This also installs the required Dart plugin.
5. Validate setup using **Flutter Doctor**:
   - Invoke ```View -> Command Palette```.  
   - Type “doctor”, and select the **Flutter: Run Flutter Doctor**.
   - Review the output in the **OUTPUT** pane for any issues. Make sure to select Flutter from the dropdown in the different Output Options.  
6. Cross-check your installations ([here](https://flutter.dev/docs/development/tools/vs-code)).

### IDE: Android Studio
Refer the installation guides [here](https://flutter.dev/docs/development/tools/android-studio).

## How to run (Android)  
Make sure device has version Android Oreo or higher.  
Below is the instruction on how to deploy app to device:

1. In VS Code, make sure there is a target device on bottom corner right-hand side.
   - If ```No device``` is shown, it means target device is not found or device not properly plugged in. 
   - Make sure your device has enabled developer option ([here](https://www.digitaltrends.com/mobile/how-to-get-developer-options-on-android/)).
2. Once target device is found, click F5 or go to ```Run and Debug``` tab on the left menu pane and press the green button on top to deploy app to device.  

Process is going to take a while especially if it is loaded the first time or there is huge update.

## Things to change
All dimensions need to be changed according to the device. Only numbers are changed.  
Here is a list of changes needed to be made:

1. ```tcm_analyzer/lib/home.dart```:
   - Line 78: App bar height **(reduce if pixels overflow)**
   - Line 84: Title adjustments [```fromLTRB```: ```fromLeftTopRightBottom```] (optional)
2. ```tcm_analyzer/lib/info.dart```:
   - Line 646: Info box **(reduce if pixels overflow)**
3. ```tcm_analyzer/lib/camera.dart```:
   - Line 59: Camera preview height **(add if pixels overflow)**
   - Line 80: Shutter box height **(add if pixels overflow)**


## Contribution
1. Prediction model: 周偉斌 N16095015
2. Mobile app: 曾青山 F74075055 + 周偉斌 N16095015
3. Server integration: 周偉斌 N16095015

## License
[MIT](https://choosealicense.com/licenses/mit/)