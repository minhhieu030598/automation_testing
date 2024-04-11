*** Settings ***
Documentation     Test suite for mobile application login.
Library           AppiumLibrary


*** Variables ***
${APP}            C:\\Users\\hieudm\\PycharmProjects\\autotest_learn\\app-debug.apk  # For Android
# ${APP}         /path/to/your/app.app  # For iOS
${PLATFORM_NAME}    Android
# ${PLATFORM_NAME}  iOS
${PLATFORM_VERSION}   24  # Example platform version
${DEVICE_NAME}    Pixel_8_Pro_API_28  # Example device name or UDID for iOS
${URL}            http://localhost:4723/wd/hub  # Default Appium URL and port
${USERNAME}     proton@gmail.com
${PASSWORD}     abc1234!
#Solution 1
# text là cái hint của ô EditText,
#${emailAddressTextbox}        //android.widget.EditText[@text='Email']
#${passwordTextbox}            //android.widget.EditText[@text='Mật khẩu']
#${loginButton}            //android.widget.Button[@text='Đăng nhập']
#Solution 2
${emailAddressTextbox}        id=edtEmail
${passwordTextbox}            id=edtPassword
${loginButton}              id=btnLogin

*** Test Cases ***
Test Successful Login On Mobile
    Open Application    ${URL}    platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    app=${APP}    automationName=UiAutomator2  # Use UiAutomator2 for Android or XCUITest for iOS
    Input Text    ${emailAddressTextbox}    ${USERNAME}
    Input Text    ${passwordTextbox}    ${PASSWORD}
    Click Element    ${loginButton}
    sleep   2s
    Wait Until Element Is Visible   id=flFragment
    [Teardown]    Close Application

# robot --outputdir mobile_testing mobile_testing/android_testing.robot