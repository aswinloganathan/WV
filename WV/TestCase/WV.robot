*** Settings ***
Library    SeleniumLibrary    screenshot_root_directory=../Screenshot/         
Resource    ../Resource/CommonFunctions.robot
Test Teardown    Finish Testcase


*** Test Cases ***

Verify user should able to save the profile without entering any Mandatory details
    [Tags]    My Profile
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//span[@class='Sub_head_Login']
    Click Element    //input[@id='edit-name']
    Input Text    //input[@id='edit-name']    logimohan@gmail.com
    Click Element    //input[@id='edit-pass']
    Input Password    //input[@id='edit-pass']    logi
    Click Element    //button[text()='Login']
    Click Element    //li[@class='welcomesponsor']
    Click Link    //a[@href="/user"]
    Click Element    //a[text()='Edit Profile']
    #Clear Field
    Clear Element Text    //input[@id='edit-field-first-name-0-value']
    Clear Element Text    //input[@id='edit-field-last-name-0-value']
    Clear Element Text    //input[@id='edit-field-registeraddress-0-value']
    Clear Element Text    //input[@id='edit-field-address-2-0-value']
    Clear Element Text    //input[@id='edit-field-pin-code-0-value']
    Clear Element Text    //input[@id='edit-mail']
    Click Element    edit-submit
    #Check Alert
    #first name alert
    ${firstname_alert}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-field-first-name-0-value-error
    Run Keyword If    'True'!='${firstname_alert}'    Fail    "First name alert not display"
    #last name alert
    ${lastname_alert}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-field-last-name-0-value-error
    #adddress 1 alert
    ${addrs_alert}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-field-registeraddress-0-value-error
    Run Keyword If    'True'!='${addrs_alert}'    Fail    "Address 1 alert not display"
    #adddress 2 alert
    ${addrs2_alert}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-field-last-name-0-value-error
    Run Keyword If    'True'!='${addrs2_alert}'    Fail    "Address 2 alert not display"
    #Postal code alert
    ${postal_code}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-field-pin-code-0-value-error
    Run Keyword If    'True'!='${postal_code}'    Fail    "Postal code alert not display"
    #Email alert
    ${email_alert}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-mail-error
    Run Keyword If    'True'!='${email_alert}'    Fail    "Email address alert not display"

To register > User should fill all the required fields and click "create new account" button
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Register')]
    #first name
    Input Text    id=edit-field-first-name-0-value    logeshwari
    #last name
    Input Text    id=edit-field-last-name-0-value    mohan
    #Email
    Input Text    id=edit-mail    logi@gmail.com
    #Phone no
    Input Text    id=edit-field-mobile-verify-0-mobile    9345623456
    #confirm password
    Wait Until Element Is Visible    id=edit-pass-pass1    20s
    Click Element    //label[text()='Password']    
    Input Text    id=edit-pass-pass1    logi
    #Re-confirm
    Wait Until Element Is Visible    id=edit-pass-pass2    20s
    Click Element    //label[text()='Confirm Password']
    Input Text    id=edit-pass-pass2    logi
    #Address 1
    Input Text    id=edit-field-registeraddress-0-value    ngkdjdfhbdjkgh
    #Address 2
    Input Text    id=edit-field-address-2-0-value    lkjlhdfgldjfgjhg
    #Address 3
    Input Text    id=edit-field-address-3-0-value    lkjlhdfgldjfgkljuytr
    #Postal code
    Input Text    id=edit-field-pin-code-0-value    600099
    #How Do you Know - Newly added
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Select From List By Label    id=edit-field-how-do-you-know-about-worl    Friends and Family        
    #DOB
    Click Element    xpath=//label[text()='Date of Birth']
    Select From List By Label    xpath=//select[@class='ui-datepicker-year']    1993
    Select From List By Label    xpath=//select[@class='ui-datepicker-month']    Sep
    Click Element    xpath=(//table//tbody/tr/td/a)[7]
    Click Element    //button[@class='singUpRegister']
    #${chck_reg_worked}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='modal-content']
    #Run Keyword If    'True'!='${chck_reg_worked}'    Fail    "Register required fields are filled but OTP dialogue box not display"
    
Verify User should able to edit profile with invalid data
    [Tags]    My Profile
    #Local browser launch
    Jenkins browser launch
    # Click Login icon in Header
    Click Element    xpath=//span[@class='Sub_head_Login']
    # Enter Email-Id or Ph no
    Click Element    //input[@id='edit-name']
    Input Text    //input[@id='edit-name']    logimohan@gmail.com
    # Enter the Password
    Click Element    //input[@id='edit-pass']
    Input Password    //input[@id='edit-pass']    logi
    Click Element    //button[text()='Login']
    # Click Welcome Button
    Click Element    //li[@class='welcomesponsor']
    # Click My Profile
    Click Link    //a[@href="/user"]
    # Click Edit Profile
    Click Element    //a[text()='Edit Profile']
    # Edit pan Number
    Input Text    //input[@id='edit-field-pan-number-0-value']    BJTPB90$@AA
    # Enter valid PAN Number.
    ${get_invalid_alert}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//strong[@id='edit-field-pan-0-value-error']
    Run Keyword If    'True'!='${get_invalid_alert}'    Fail    "Enter invalid PAN number, alert is not display"

Click login link
    [Tags]    LOGIN
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    ${check_login_page}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//*[@class='login-form__top']
    Run Keyword If    'True'!='${check_login_page}'    Fail    "When click login icon it will not redirect to login page"

To verify Login credentials in UPPER case should not be treated as invalid
    [Tags]    LOGIN
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    //input[@id='edit-name']
    Input Text    //input[@id='edit-name']    LOGIMOHAN@GMAIL.COM
    Click Element    //input[@id='edit-pass']
    Input Password    //input[@id='edit-pass']    logi
    Click Element    //button[text()='Login']
    ${chck_redirect_userlogin_page}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//li[@class='welcomesponsor']
    Run Keyword If    'True'=='${chck_redirect_userlogin_page}'    Log To Console    "Login credentials are given in Uppercase and Page redirected to post Login page"
    #${chck_invalid_alert}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='InvalidUsername']
    #Run Keyword If    'True'=='${chck_invalid_alert}'    Fail    "Login credentials are given in Uppercase but alert msg are display"
    #${chck_redirect_userlogin_page}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//li[@class='welcomesponsor']
    #Run Keyword If    'True'!='${chck_redirect_userlogin_page}'    Fail    "Login credentials are given in Uppercase but it will not redirect to the postlogin page"

Validation message should be shown when invalid username and/or password is enter
    [Tags]    LOGIN
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    id=edit-name
    Input Text    id=edit-name    logi
    Click Element    id=edit-pass
    Input Text    id=edit-pass    logi
    Click Element    xpath=//div[@class='login-form__submit']//button
    ${invalid_alert}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//*[@id='edit-pass-error']
    Run Keyword If    'True'!='${invalid_alert}'    Fail    "Enter invalid username and password 'Incorrect username or password' error msg not display"

After clicking get one time OTP button
    [Tags]    LOGIN
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    id=edit-name
    Input Text    id=edit-name    logimohan@gmail.com
    Click Element    id=edit-pass
    Input Text    id=edit-pass    logi
    Click Element    id=ToGetOTP
    ${get_alert_txt}=    Get Text    xpath=.//span[@class='orngClr']
    Run Keyword If    'OTP has been sent to your Mobile/Email'!='${get_alert_txt}'    Fail    "When click 'Get One Time PAssword' link, alert msg not display"

To verify all the fields are mandy
    [Tags]    Registration Page
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Register')]    
    Scroll Element Into View    xpath=//div[@id='edit-actions']//button[@class='singUpRegister']
    Sleep   5s
    Click Element    xpath=//div[@id='edit-actions']//button[@class='singUpRegister']   
    
    FOR    ${element}    IN    @{RegisterFields}
        ${alert}=    Run Keyword And Return Status    Element Should Be Visible    id=signUpfnameErr
        Run Keyword If    'True'!='${alert}'    Fail    "${element} name alert not display"
    END
    
    Log To Console    "Alert messages are active"
    # ${state_alert}=    Run Keyword And Return Status    Element Should Be Visible    id=signUpStateErr
    # Run Keyword If    'True'!='${state_alert}'    Fail    "State alert not display"

To verify login through invalid mobile number with invalid password
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    id=edit-name
    Input Text    id=edit-name    9856787656
    Click Element    id=edit-pass
    Input Text    id=edit-pass    djfkdfjfk
    Click Element    xpath=//div[@class='login-form__submit']//button
    ${username_validation}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//*[@id='edit-pass-error']
    Run Keyword If    'True'!='${username_validation}'    Fail    "Enter Invalid mobile number and invalid password, 'Incorrect username or password' error msg not display"

To verify login through invalid email id and invalid password
    Jenkins browser launch
    #Local browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    id=edit-name
    Input Text    id=edit-name    mnvfdfa@gmail.com
    Click Element    id=edit-pass
    Input Text    id=edit-pass    djfkdfjfk
    Click Element    xpath=//div[@class='login-form__submit']//button
    ${username_validation}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//*[@id='edit-pass-error']
    Run Keyword If    'True'!='${username_validation}'    Fail    "Enter Invalid email id and invalid password, 'Incorrect username or password' error msg not display"

To verify login through invalid mobile number with valid password
    Jenkins browser launch
    #Local browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    id=edit-name
    Input Text    id=edit-name    9845674321
    Click Element    id=edit-pass
    Input Text    id=edit-pass    123456
    Click Element    xpath=//div[@class='login-form__submit']//button
    ${username_validation}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//*[@id='edit-pass-error']
    Run Keyword If    'True'!='${username_validation}'    Fail    "Enter Invalid mobile number and valid password, 'Incorrect username or password' error msg not display"

To verify login through valid mobile number with invalid password
    Jenkins browser launch
    #Local browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    id=edit-name
    Input Text    id=edit-name    9600185121
    Click Element    id=edit-pass
    Input Text    id=edit-pass    dfgdfs
    Click Element    xpath=//div[@class='login-form__submit']//button
    ${username_validation}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//*[@id='edit-pass-error']
    Run Keyword If    'True'!='${username_validation}'    Fail    "Enter valid mobile number and invalid password, 'Incorrect username or password' error msg not display"

To verify login through valid mobile number with valid password
    [Tags]    LOGIN
    
    Jenkins browser launch    
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Wait Until Element Is Visible    xpath=//li[@class='welcomesponsor']    60s
    ${postlogin_homepage_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//li[@class='welcomesponsor']
    Run Keyword If    'True'!='${postlogin_homepage_chck}'    Fail    "Valid user can't able to login Or Post login Page doesnt Load"
    

To verify login through valid email ID with valid password
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    id=edit-name
    Input Text    id=edit-name    logimohan@gmail.com
    Click Element    id=edit-pass
    Input Text    id=edit-pass    logi
    Click Element    xpath=//div[@class='login-form__submit']//button
    ${postlogin_homepage_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//li[@class='welcomesponsor']
    Run Keyword If    'True'!='${postlogin_homepage_chck}'    Fail    "Valid user can't able to login"

To Sponsor a child by SI payment flow from search page
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=.//span[@class='Sub_head_search']
    Input Text    id=edit-search-api-fulltext    hjfhjhf
    Click Element    id=edit-submit-wv-custom-search
    ${search_child_count}=    Get Element Count    xpath=.//div[@class='search-page']
    Run Keyword If    4!=${search_child_count}    Fail    "Enter irrelavent data list of 4 child list not display"
    Mouse Over    xpath=(.//div[@class='search-page']/div[@class='search-page-childimg test']/h4)[1]
    Click Element    xpath=(.//div[@class='add-cart-btn'])[1]

# Switching indian citizen to other passport holder in my profile page
    # #Local browser launch
    # Jenkins browser launch
    # Click Element    xpath=//a[contains(text(),'Login')]
    
    # Wait Until Element Is Visible    id=edit-name    15s
    # Click Element    id=edit-name    
    # Input Text    id=edit-name    9600185121
    
    # Wait Until Element Is Visible    id=edit-pass    15s
    # Click Element    id=edit-pass    
    # Input Text    id=edit-pass    123456
    
    # Click Element    xpath=(//div[@class='login-form__submit']/button)[1]
    # Mouse Over    xpath=.//li[@class='welcomesponsor']
    # Click Element    xpath=.//ul[@class='mypro-lgot']/li/a[contains(.,'My profile')]
    # Click Element    xpath=.//a[contains(.,'Edit Profile')]
    # Scroll Element Into View    xpath=.//label[@for='edit-field-nationality']
    # ${ind}=    Execute Javascript    return window.jQuery('#indctzn').prop('checked')
    # Log To Console    Indian is choosed:${ind}
    # Run Keyword If    'True'!='${ind}'    Fail    "User by default have choosed 'Indian' but now it display like 'Other passport' holder"
    # Click Element    xpath=.//label[@for='othctzn']
    # Scroll Element Into View    id=edit-submit
    # Click Element    id=edit-submit
    # Click Element    xpath=.//a[contains(.,'My Gifts')]
    # Banner Alert
    # ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    # ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}        
    # Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    # Mouser hover ways to give campaign    Educate Children
    # Sleep    5s
    # ${val_1}    ${val_2}    Checkout flow campaign
    # check in view cart page    ${val_1}    ${val_2}
    # View cart proceed button
    # ${checkout_payment_list}=    Get Element Count    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div
    # Run Keyword If    3!=${checkout_payment_list}    Fail    "Checkout flow Other passport holder payment list are mismatch"
    # FOR    ${bank_txt}    IN    @{checkout_payment_list_text}
        # ${checkout_banklist_name_check}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'${bank_txt}')]
        # Run Keyword If    'True'!='${checkout_banklist_name_check}'    Fail    'Checkout Flow Other passport holder Payment Gateway ${bank_txt} text is mismatch'
    # END
    # Mouse Over    xpath=.//li[@class='welcomesponsor']
    # Click Element    xpath=.//ul[@class='mypro-lgot']/li/a[contains(.,'My profile')]
    # Click Element    xpath=.//a[contains(.,'Edit Profile')]
    # Scroll Element Into View    xpath=.//label[@for='edit-field-nationality']
    # Click Element    xpath=.//label[@for='indctzn']
    # Scroll Element Into View    id=edit-submit
    # Click Element    id=edit-submit
    
Valid username Invalid password
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    id=edit-name
    Input Text    id=edit-name    ${user_name}
    Click Element    xpath=//div[@class='login-form__submit']//button
    ${username_validation}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//*[@id='edit-pass-error']
    Run Keyword If    'True'!='${username_validation}'    Fail    "Enter valid username and blank password but 'Password/OTP is required.' error msg not display"
    Clear Element Text    id=edit-name

Invalid username and valid password
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    id=edit-pass
    Input Text    id=edit-pass    ${password}
    Click Element    xpath=//div[@class='login-form__submit']//button
    ${username_validation}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//*[@id='edit-pass-error']
    Run Keyword If    'True'!='${username_validation}'    Fail    "Enter valid password and blank username but 'Incorrect username or password' error msg not display"
    Clear Element Text    id=edit-pass

Ensure user can able to logout in direct login
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Sleep   40s
    Navigation banner close
    #Wait Until Element Is Visible    xpath=//li[@class='welcomesponsor']    30s
    Mouse Over    xpath=.//li[@class='welcomesponsor']
    Click Element    xpath=.//ul[@class='mypro-lgot']/li/a[contains(.,'Logout')]    
    #Click Element    class=input-survey    
    #Input Text    input-survey    Test review Data
    #Click Element    class=btnSub-survey    
    Click Element    class=close-survey            
    ${check_success_logout}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//li[@class='pre_lgn']
    Run Keyword If    'True'!='${check_success_logout}'    Fail    "Unable to logout Properly"
    
Direct login with exit user
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    id=edit-name
    Input Text    id=edit-name    ${user_name}
    Click Element    id=edit-pass
    Input Text    id=edit-pass    ${password}
    Click Element    xpath=//div[@class='login-form__submit']//button
    ${postlogin_homepage_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//li[@class='welcomesponsor']
    Run Keyword If    'True'!='${postlogin_homepage_chck}'    Fail    "Exist user can't able to login for direct login"

Checkoutflow login with exit user
    #Local browser launch
    Jenkins browser launch
    One time Hunger Free campaign
    View cart proceed button
    Login
    ${checkoutflow_postlogin_page}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@id='block-paymentmode']
    Run Keyword If    'True'!='${checkoutflow_postlogin_page}'    Fail    "Exist user can't able to login for Checkout Flow"
    
SI flow login with exit user
    #Local browser launch
    Jenkins browser launch
    Rescue child campaign
    SI login
    ${check_SI_postlogin_page}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//form[@class='payment_selection_form']
    Run Keyword If    'True'!='${check_SI_postlogin_page}'    Fail    "Exist user can't able to login for SI Flow"    
 
To verify child rotator
    #Local browser launch
    Jenkins browser launch
    ${get_child_count}=    Get Element Count    xpath=.//*[@class='child_sponsor_image']/img
    Run Keyword If    ${get_child_count}<5    Fail    In home page child rotator child are display lessthen 5
    Check allow auto debit select default in child rotator
    Click Element    xpath=//div[@class='item active']//div[@class='stepwizard-row setup-panel']//div[3]//div[1]//label[1]
    Click Element    xpath=//div[@class='item active']//button[@class='btn btn-primary si_modal_btn']
    ${check_sI_login_page}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@id='smartwizard']
    Run Keyword If    True!=${check_sI_login_page}    Fail    "When try to select child get into SI login but SI login page not display"
    Click Element    xpath=.//div[@class='modal-footer']/button
    9600 should select defaulty
    Check rounded checkbox txt and amount
    #${check_sel_child}=    Add child to view cart
    #Child duplicate checking    ${check_sel_child}
 
To verify search child and donate
    [Tags]    Search functionality
        
    Jenkins browser launch    
    ${child_name}    ${sel_child_amt}    ${sel_child_imgsrc}    Rotator Child Details
    Log To Console    Child name: ${child_name} and child amount: ${sel_child_amt} and also child img src: ${sel_child_imgsrc}
    Rotator Payment validation    ${sel_child_imgsrc}
    Click Element    xpath=//a[@class='view_cart']
    Rotator Child cart validation    ${child_name}    ${sel_child_amt}    
    View cart proceed button
    Login
    CCavenue payment success flow        
    Click Element    xpath=.//li[@class='post_lgn']/a
    Why do you want to quit - PopUp
    Click Element    xpath=.//li[@class='post_lgn']/a
    #Click Element    xpath=.//ul[@class='nav nav-tabs gift-donation']/li[contains(.,'Donation')]
    Click Element    xpath=//div[@id='donation']//a[contains(text(),'My Children')]    
    ${check_child_display}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[contains(@class,'chld-items')]//div[@class='cld-nme']/p[contains(.,'${child_name}')]
    Run Keyword If    True!=${check_child_display}    Fail    Payment success, But child details doesnt appear in "My Children" tab

To verify child was donated in between gap while user seraching
    #Local browser launch
    Jenkins browser launch
    ${footer_status}=    Run Keyword And Return Status    Element Should Be Visible    id=myCarousel
    Run Keyword If    'True'!='${footer_status}'    Fail    "Home Page Footer child rotator section not displayed"    
    Click Element    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//div[@class='stepwizard-row setup-panel']/div[3]/div/label
    ${child_name}=    Get Text    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//h4
    ${child_name}=    Remove String Using Regexp    ${child_name}    \,.*$
    Log To Console    Child name:${child_name}
    Click Element    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//label[@class='chkSIlabel']
    ${footer_proceed_btn}=    Get Element Attribute    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//input[@id='edit-submit--12']    value
    Run Keyword If    'SPONSOR NOW'!='SPONSOR NOW'    Fail    "After Allow Auto Debit button click it will not change into 'Sponsor Now' text"
    Click Element    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//input[@id='edit-submit--12']
    ${child_count}=    Get Element Count    xpath=.//div[@class='seach-page-hover-content']/h4
    FOR    ${index}    IN RANGE    1    ${child_count}
    ${chck_sel_child_name}=    Run Keyword And Return Status    Element Should Be Visible    xpath=(.//div[@class='seach-page-hover-content']/h4[contains(.,'${child_name}')])[${index}]
    Run Keyword If    True==${chck_sel_child_name}    Fail    Selected child name is displayed in search page
    END

Payment failure banner
    [Tags]    Payment Failure banner Functionallity    

    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Cart campaign check and delete
    Mouser hover ways to give campaign    Educate Children
    Sleep    5s
    ${val_1}    ${val_2}    Checkout flow campaign
    check in view cart page    ${val_1}    ${val_2}
    View cart proceed button
    Login
    CCAvenue payment failure flow
    Click Element    xpath=//div[@class='header_new_logo']//img
    Sleep    10s    
    Payment failure check in home page banner    ${button_failure_txt}
    
To verify payment flow using failure banner
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Navigation banner close
    Payment failure check in home page banner - Click    content    
    CCavenue payment success flow
    Click Element    xpath=//div[@class='header_new_logo']//a/img  
    Banner Alert
    @{failure_banner}=    Get WebElements    xpath=//div[@class='banner-content']/h2
    FOR    ${element}    IN    @{failure_banner}
        ${text}=    Get Text    ${element}        
        Run Keyword If    'Please try again!'!='${text}'    Log To Console    "Payment Failure banner is changed"    ELSE    fail    'Payment failure banner is still exist'   
    END    
    
    
To sponsor a Educate Children Campaign using Checkout flow
    [Tags]    Educate Children Campaign
    
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    Educate Children
    Sleep    5s
    ${camp_name}    ${camp_amt}    Checkout flow campaign
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${camp_amt}
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${camp_name}    ${camp_amt}    ${cart_quanity}

To sponsor a Save Malnourished Children Campaign using Checkout flow
    [Tags]    Save Malnourished Children Campaign
    
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    Save Malnourished Children
    Sleep    5s
    ${camp_name}    ${camp_amt}    Checkout flow campaign
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${camp_amt}
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${camp_name}    ${camp_amt}    ${cart_quanity}
    
To sponsor a Childhood Rescue Campaign using Checkout flow
    [Tags]    Childhood Rescue Campaign

    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    Childhood Rescue
    Sleep    5s
    ${camp_name}    ${camp_amt}    Checkout flow campaign
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${camp_amt}
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${camp_name}    ${camp_amt}    ${cart_quanity}

To sponsor a Hunger Free Campaign as a one time donation using Checkout flow
    [Tags]    Hunger Free Campaign

    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign     Hungerfree 
    ${camp_name}    ${Camp_val}    one time campaign - Hunger Free campaign       
    ${cart_quanity}    check in view cart page - One time donation flow    ${camp_name}    ${Camp_val}
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${camp_name}    ${Camp_val}    ${cart_quanity}

To sponsor a Where Most Needed Campaign as a one time donation using Checkout flow
    [Tags]    Where Most Needed Campaign

    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    Where Most Needed
    ${camp_name}    ${Camp_val}    one time campaign - Where Most Needed Campaign       
    ${cart_quanity}    check in view cart page - One time donation flow    ${camp_name}    ${Camp_val}
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${camp_name}    ${Camp_val}    ${cart_quanity}

To sposor a Educate Children Campaign as a one time donation using Checkout flow
    [Tags]    Educate Children Campaign
    
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    Educate Children
    ${camp_name}    ${Camp_val}    one time campaign
    ${cart_quanity}    check in view cart page - One time donation flow    ${camp_name}    ${Camp_val}
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${camp_name}    ${Camp_val}    ${cart_quanity}

To sponsor a Rescue Children Campaign using Si payment Flow from Educate Children campaign page
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    Childhood Rescue
    SI flow campaign
    SI login

To sponsor a Help HIV aids Campaign using Si payment Flow
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    HIV & AIDS
    SI flow campaign
    SI login

To sponsor a Protect Girl Children Campaign using Si payment Flow from Educate Children campaign page
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    End Child Sexual Abuse
    SI flow campaign
    SI login

To sponsor child using SI flow
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    
    Click Element    xpath=//div[@class='header_new_logo']//img    

    Sleep    10s
    ${footer_status}=    Run Keyword And Return Status    Element Should Be Visible    id=myCarousel
    Run Keyword If    'True'!='${footer_status}'    Fail    "Home Page Footer child rotator section not displayed"
    Click Element    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//div[@class='stepwizard-row setup-panel']/div[3]/div/label
    ${child_name}=    Get Text    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//h4
    ${child_name}=    Remove String Using Regexp    ${child_name}    \,.*$
    ${sel_child_amt}=    Get Text    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//p[@class='pricemnth active']//span[@class='home-price']
    ${remove_comma_symbol}=    Remove symbol    ${sel_child_amt}    .00
    ${remove_dollor_symbol}=    Remove symbol    ${remove_comma_symbol}    ₹
    ${sel_child_imgsrc}=    Get Element Attribute    xpath=//div[@class='item active childRotator' or @class='item childRotator active']/div/div[1]/div[1]/div/img    src
    Log To Console    Child name:${child_name} and child amount:${remove_dollor_symbol} and also child img src:${sel_child_imgsrc}
    Click Element    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//button[@class='btn btn-primary si_modal_btn']
    SI login
    ${SI_payment_total_amt}=    Get Text    xpath=.//h5[@id='TotalAmtOfOrder']
    ${get_amt_only}=    Fetch From Right    ${SI_payment_total_amt}    Total Amount Of Order
    Log To Console    Amount with INR output is:${get_amt_only}
    ${final_val}=    Fetch From Left    ${get_amt_only}    INR
    ${final_output}=    Strip String    ${SPACE}${final_val}
    Log To Console    Final val is:${final_output}
    Run Keyword If    ${final_output}!=${remove_dollor_symbol}    Fail    Selected amount and display amount in SI payment are mismatch
    ${check_SI_postlogin_page}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//form[@class='payment_selection_form']
    Run Keyword If    'True'!='${check_SI_postlogin_page}'    Fail    "SI post login page not display"
    ${SI_payment_list}=    Get Element Count    xpath=.//div[@class='payment-main-content']/div
    Run Keyword If    3!=${SI_payment_list}    Fail    "SI Flow payment gateway list mismatch"
    FOR    ${SI_payment_txt}    IN    @{SI_payment_list_text}
        ${SI_payment_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='payment-main-content']/div[contains(.,'${SI_payment_txt}')]
        Run Keyword If    'True'!='${SI_payment_txt_chck}'    Fail    "SI flow payment gateway ${SI_payment_txt} text are mismatch"
    END
    
Just post login check hungerfree campaign
    [Tags]    Post Login 
    
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login           
    Click Element    xpath=//a[contains(.,'My Gifts')]    
    Banner Alert            
    Cart campaign check and delete
    
    #Make payment menu check
    Click Element    xpath=//li[@class='post_lgn']/a    
    Wait Until Element Is Visible    xpath=//ul[@class='nav nav-tabs gift-donation']/li[contains(.,'Donation')]    60s
    Click Element    xpath=//ul[@class='nav nav-tabs gift-donation']/li[contains(.,'Donation')]
    Click Element    xpath=//div[@class='tog-top-sec']/ul/li[contains(.,'My Donations')]
    
    ${hunger_free_label_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='childData']/following-sibling::div//div[@class='cld-nme']/p[contains(.,'HungerFree')]
    Run Keyword If    'True'!='${hunger_free_label_chck}'    Fail    "Hunger free label not found"
    
    ${Hungerfree_label_amt}=    Get Text    xpath=//div[@class='childData']/following-sibling::div//div[@class='cld-nme']/p[contains(.,'HungerFree')]/parent::div/following-sibling::div/p[1]
    ${final_label_amt}=    Remove String Using Regexp    ${Hungerfree_label_amt}    \\D     
    Log To Console    Before hunger free label amount:${final_label_amt}    
    
    #Move to hungerfree campaign    
    Mouse hover ways to give after login    Hungerfree    
    Click Element    xpath=.//div[@class='add-to-cart-section']
    
    ${hunger_camp_name}=    Get Text    xpath=//div[@class='inner_banner_pledge_content']/h2/div
    ${split_Hunger_name_with_rightside}=    Remove String    ${hunger_camp_name}    Free
    Log To Console    ${split_Hunger_name_with_rightside}
        
    ${get_input_val}=    Get Element Attribute    xpath=.//input[@name='manualCart[0][amount]']    value
    Log To Console    Hunger campaign get input amount:${get_input_val}
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"
    Click Element    xpath=//a[@class='view_cart']
    Banner Alert       
    ${hunger_camp_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[contains(text(),'${split_Hunger_name_with_rightside}')]
    Run Keyword If    'True'!='${hunger_camp_viewcart}'    Fail    "Hunger Free campaign not display in view cart page"
    ${replace_val}=    Replace String    ${get_input_val}    1    1,
    ${hunger_camp_amt_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'₹${replace_val}')]
    Run Keyword If    'True'!='${hunger_camp_amt_viewcart}'    Fail    "Hunger Free campaign amount are not display/mismatch in view cart page"
    View cart proceed button
    CCavenue payment success flow
    Click Element    xpath=.//li[@class='post_lgn']/a
    Why do you want to quit - PopUp
    Click Element    xpath=.//li[@class='post_lgn']/a
    Click Element    xpath=.//ul[@class='nav nav-tabs gift-donation']/li[contains(.,'Donation')]
    Click Element    xpath=.//div[@class='tog-top-sec']/ul/li[contains(.,'My Donations')]
    ${hunger_free_label_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='childData']/following-sibling::div//div[@class='cld-nme']/p[contains(.,'HungerFree')]
    Run Keyword If    'True'!='${hunger_free_label_chck}'    Fail    "Hunger free label not display"
    ${add_label_amt+input_amt}=    Evaluate    ${final_label_amt}+${get_input_val}
    Log To Console    Before hunger label amount + hunger free input value:${add_label_amt+input_amt}
    ${get_hungerfree_amt}=    Get Text    xpath=.//div[@class='childData']/following-sibling::div//div[@class='cld-nme']/p[contains(.,'HungerFree')]/parent::div/following-sibling::div/p[1]
    ${get_split_label_amt}=    Fetch From Right    ${get_hungerfree_amt}    Amount Paid : ₹
    ${get_final_amt}=    Strip String    ${SPACE}${get_split_label_amt}
    Log To Console    Overall hunger free label amount:${get_final_amt}
    Run Keyword If    ${add_label_amt+input_amt}!=${get_final_amt}    Fail    "After success Hunger free campaign recent amount not added in label"    

   
Just pre login check hungerfree campaign
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Click Element    xpath=.//li[@class='post_lgn']/a
    Click Element    xpath=.//ul[@class='nav nav-tabs gift-donation']/li[contains(.,'Donation')]
    Click Element    xpath=.//div[@class='tog-top-sec']/ul/li[contains(.,'My Donations')]
    ${hunger_free_label_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='childData']/following-sibling::div//div[@class='cld-nme']/p[contains(.,'HungerFree')]
    ${Hungerfree_label_amt}=    Get Text    xpath=.//div[@class='childData']/following-sibling::div//div[@class='cld-nme']/p[contains(.,'HungerFree')]/parent::div/following-sibling::div/p[1]
    ${split_amt_label}=    Fetch From Right    ${Hungerfree_label_amt}    Amount Paid : ₹
    ${final_label_amt}=    Strip String    ${SPACE}${split_amt_label}
    Log To Console    Before hunger free label amount:${final_label_amt}
    Mouse Over    xpath=.//li[@class='welcomesponsor']
    Click Element    xpath=.//ul[@class='mypro-lgot']/li/a[contains(.,'Logout')]    
    Click Element    class=close-survey    
    ${check_success_logout}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//li[@class='pre_lgn']
    Run Keyword If    'True'!='${check_success_logout}'    Fail    "Site not getting proper logout"
    ${hunger_get_input_val}    One time Hunger Free campaign
    Log To Console    Hunger campaign get input amount:${hunger_get_input_val}
    View cart proceed button
    Login
    CCavenue payment success flow
    Click Element    xpath=.//li[@class='post_lgn']/a
    Why do you want to quit - PopUp
    Click Element    xpath=.//li[@class='post_lgn']/a
    Click Element    xpath=.//ul[@class='nav nav-tabs gift-donation']/li[contains(.,'Donation')]
    Click Element    xpath=.//div[@class='tog-top-sec']/ul/li[contains(.,'My Donations')]
    ${hunger_free_label_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='childData']/following-sibling::div//div[@class='cld-nme']/p[contains(.,'HungerFree')]
    Run Keyword If    'True'!='${hunger_free_label_chck}'    Fail    "Hunger free label not display"
    ${add_label_amt+input_amt}=    Evaluate    ${final_label_amt}+${hunger_get_input_val}
    Log To Console    Before hunger label amount + hunger free input value:${add_label_amt+input_amt}
    ${get_hungerfree_amt}=    Get Text    xpath=.//div[@class='childData']/following-sibling::div//div[@class='cld-nme']/p[contains(.,'HungerFree')]/parent::div/following-sibling::div/p[1]
    ${get_split_label_amt}=    Fetch From Right    ${get_hungerfree_amt}    Amount Paid : ₹
    ${get_final_amt}=    Strip String    ${SPACE}${get_split_label_amt}
    Log To Console    Overall final hunger free label val:${get_final_amt}
    Run Keyword If    ${add_label_amt+input_amt}!=${get_final_amt}    Fail    "After success Hunger free campaign recent amount not added in label"



To download tax receipt 
    [Tags]    Tax Receipt Page
    
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Navigation banner close
    Click Element    xpath=//li/a[contains(text(),'Tax Receipts')] 
    Sleep    40s
    Banner Alert             
    ${chk_disable_download_Btn}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//a[@class='downloadpdf']
    Run Keyword If    'True'!='${chk_disable_download_Btn}'    Fail    "Tax receipts page by default 'Download Tax Receipt' button is enable"    ELSE    Log To Console    'By default "Download Tax Receipt" button is Disabled'                
    Click Element    id=edit-created-min
    Sleep    5s    
    Select From List By Label    class=ui-datepicker-month    May
    Sleep    5s    
    Select From List By Label    class=ui-datepicker-year    2020
    Sleep    5s    
    ${get_date_count}=    Get Element Count    xpath=//table[@class='ui-datepicker-calendar']//tbody/tr/td/a
    FOR    ${index}    IN RANGE    1    ${get_date_count}
        ${get_date_txt}=    Get Text    xpath=(//table[@class='ui-datepicker-calendar']//tbody/tr/td/a)[${index}]
        ${sub_date_}=    Subtract date
        Run Keyword If    '${get_date_txt}'=='${sub_date_}'    Click Element    xpath=(//table[@class='ui-datepicker-calendar']//tbody/tr/td/a)[${index}]
        Exit For Loop If    '${get_date_txt}'=='${sub_date_}'
    END
    Sleep    20s
    Click Element    id=edit-created-max
    ${get_count_date}=    Get Element Count    xpath=//table[@class='ui-datepicker-calendar']//tbody/tr/td/a
    FOR    ${index}    IN RANGE    1    ${get_count_date}+1    
        ${get_txt_date}=    Get Text    xpath=(//table[@class='ui-datepicker-calendar']//tbody/tr/td/a)[${index}]
        ${today_date}=    Today date
        Run Keyword If    '${get_txt_date}'=='${today_date}'    Click Element    xpath=(//table[@class='ui-datepicker-calendar']//tbody/tr/td/a)[${index}]
        Exit For Loop If    '${get_txt_date}'=='${today_date}'
    END
    Sleep    10s        
    Click Element    id=generate_tax
    ${tax_receipt}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//div[contains(@class,'no-data-found')]
    Run Keyword If    'True'!='${tax_receipt}'    Fail    "Tax receipt are not loading"    ELSE    Log To Console    'Tax receipts are loading'



    
Hungree one time campaign
    #Local browser launch
    Jenkins browser launch
    One time Hunger Free campaign
    Delete view cart campaign
    
Educate children campaign
    #Local browser launch
    Jenkins browser launch
    Educate children campaign with checkout flow
    Delete view cart campaign
    
Logo and home page banner loaded check
    #Local browser launch
    Jenkins browser launch
    Element Should Be Visible    xpath=.//div[@class='header_new_logo']/div/a/img
    Sleep    4s
    ${check_homepag_banner_section_status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=(//div[@class='slideshow_content area wv-pos-relative']/div[1]/div)[1]/div/div[@class='gavias_sliderlayer rev_slider_wrapper fullwidthbanner-container']
    Run Keyword If    'True'!='${check_homepag_banner_section_status}'    Fail    "Home page banner section not display properly"

Header main menu list verification
    #Local browser launch
    Jenkins browser launch
    ${headermenu_list}=    Get Element Count    xpath=//div[@class='main-menu-inner']//*[@class='we-megamenu-nolink' or text()=' My World ']
    Log To Console    ${headermenu_list}    
    Run Keyword If    '${headermenu_list}'!='${rightside_menu_list}'    Fail    "Header menu list size are mismatch"
    ${myworld_menus_name}=    Get Text    xpath=//div[@class='main-menu-inner']//li/a[contains(text(),'My World')]
    Run Keyword If    '${myworld_menus_name}'!='MY WORLD'    Fail    "My world menu text are different"
    FOR    ${menu_txt}    IN    @{homepage_header_menu_txt}
        ${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='main-menu-inner']//*[@class='we-megamenu-nolink' and contains(text(),'${menu_txt}') or contains(text(),'My World')]
        #${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@id='block-tbmegamenu-2']//ul[@class='we-mega-menu-ul nav nav-tabs']/li[contains(.,'${menu_txt}')]
        Run Keyword If    'True'!='${menu_txt_chck}'    Fail    "Prelogin home page ${menu_txt} text are mismatch"
    END

Search
    Jenkins browser launch
    Click Element    xpath=.//span[@class='Sub_head_search']
    Input Text    id=edit-search-api-fulltext    ksngjdsnfjksdfj
    Click Element    id=edit-submit-wv-custom-search
    ${search_status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//h3[@class='wv_sugg_search']
    Run Keyword If    'True'!='${search_status}'    Fail    "When enter irrelevant data 'No Result Found' text not display"
    

Header and footer verification
    Jenkins browser launch
    Element Should Be Visible    xpath=.//header[@id='header']
    Sleep    4s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Element Should Be Visible    xpath=.//footer
    
Aboutus submenu list verification
    #Local browser launch
    Jenkins browser launch
    ${headermenu_list}=    Get Element Count    xpath=//div[@class='main-menu-inner']//span[contains(text(),'About Us')]//parent::li//li/a
    #${headermenu_list}=    Get Element Count    xpath=//div[@id='block-tbmegamenu-2']//ul[@class='we-mega-menu-ul nav nav-tabs']/li[contains(.,'About Us')]/div//ul/li
    Log To Console    ${headermenu_list}    
    Run Keyword If    '${headermenu_list}'!='7'    Fail    "About us sub menu list size are mismatch"
    FOR    ${menu_txt}    IN    @{Aboutus_submenu_txt}
        Mouse Over    xpath=//div[@class='main-menu-inner']//span[contains(text(),'About Us')]
        ${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='main-menu-inner']//span[contains(text(),'About Us')]//parent::li//li/a[contains(text(),'${menu_txt}')]
        #${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@id='block-tbmegamenu-2']//ul[@class='we-mega-menu-ul nav nav-tabs']/li[contains(.,'About Us')]/div//ul/li/a[contains(.,'${menu_txt}')]
        Run Keyword If    'True'!='${menu_txt_chck}'    Fail    "Prelogin About us submenu ${menu_txt} text are mismatch"
    END

Child Sponsorship submenu list verification
    #Local browser launch
    Jenkins browser launch
    ${headermenu_list}=    Get Element Count    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Child Sponsorship')]//parent::li//li/a
    #${headermenu_list}=    Get Element Count    xpath=//div[@id='block-tbmegamenu-2']//ul[@class='we-mega-menu-ul nav nav-tabs']/li[contains(.,'Child Sponsorship')]/div//ul/li
    Run Keyword If    '${headermenu_list}'!='6'    Fail    "Child Sponsorship sub menu list size are mismatch"
    FOR    ${menu_txt}    IN    @{Childsponsorship_submenu_txt}
        Mouse Over    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Child Sponsorship')]
        ${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Child Sponsorship')]//parent::li//li/a[contains(text(),'${menu_txt}')]
        #Mouse Over    xpath=//div[@id='block-tbmegamenu-2']//ul[@class='we-mega-menu-ul nav nav-tabs']/li[contains(.,'Child Sponsorship')]
        #${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@id='block-tbmegamenu-2']//ul[@class='we-mega-menu-ul nav nav-tabs']/li[contains(.,'Child Sponsorship')]/div//ul/li/a[contains(.,'${menu_txt}')]
        Run Keyword If    'True'!='${menu_txt_chck}'    Fail    "Prelogin Child Sponsorship submenu ${menu_txt} text are mismatch"
    END
    
Ways to give submenu list verification
    #Local browser launch
    Jenkins browser launch
    ${headermenu_list}=    Get Element Count    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Ways to Give')]//parent::li//li/a
    Log To Console    ${headermenu_list}
    Run Keyword If    '${headermenu_list}'!='12'    Fail    "Ways to give sub menu list size are mismatch"
    FOR    ${menu_txt}    IN    @{Ways_to_give}
        Mouse Over    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Ways to Give')]
        ${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Ways to Give')]//parent::li//li/a[contains(text(),'${menu_txt}')]
        Run Keyword If    'True'!='${menu_txt_chck}'    Fail    "Prelogin Ways to give submenu ${menu_txt} text are mismatch"
    END
    
Get involved submenu list verification
    #Local browser launch
    Jenkins browser launch
    ${headermenu_list}=    Get Element Count    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Get Involved')]//parent::li//li/a
    Log To Console    ${headermenu_list}    
    Run Keyword If    '${headermenu_list}'!='2'    Fail    "Get involved sub menu list size are mismatch"
    FOR    ${menu_txt}    IN    @{Get_involved}
        Mouse Over    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Get Involved')]
        ${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Get Involved')]//parent::li//li/a[contains(text(),'${menu_txt}')]
        Run Keyword If    'True'!='${menu_txt_chck}'    Fail    "Prelogin Get Involved submenu ${menu_txt} text are mismatch"
    END
    
Media submenu list verification
    #Local browser launch
    Jenkins browser launch
    ${headermenu_list}=    Get Element Count    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Media')]//parent::li//li/a
    Log To Console    ${headermenu_list}    
    Run Keyword If    '${headermenu_list}'!='4'    Fail    "Media sub menu list size are mismatch"
    FOR    ${menu_txt}    IN    @{Media_submenu_txt}
        Mouse Over    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Media')]
        ${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Media')]//parent::li//li/a[contains(text(),'${menu_txt}')]
        Run Keyword If    'True'!='${menu_txt_chck}'    Fail    "Prelogin Media submenu ${menu_txt} text are mismatch"
    END

Partnership submenu list verification
    #Local browser launch
    Jenkins browser launch
    ${headermenu_list}=    Get Element Count    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Partnerships')]//parent::li//li/a
    Log To Console    ${headermenu_list}
    Run Keyword If    '${headermenu_list}'!='1'    Fail    "Partnerships sub menu list size are mismatch"
    FOR    ${menu_txt}    IN    @{Partnership_submenu_txt}
        Mouse Over    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Partnerships')]
        ${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='main-menu-inner']//span[contains(text(),'Partnerships')]//parent::li//li/a[contains(text(),'${menu_txt}')]
        Run Keyword If    'True'!='${menu_txt_chck}'    Fail    "Prelogin Partnerships submenu ${menu_txt} text are mismatch"
    END
    
Multiple deletion
    #Local browser launch
    Jenkins browser launch
    One time Hunger Free campaign
    Educate children campaign with checkout flow
    ${get_viewcart_list_count}=    Get Element Count    xpath=.//tbody/tr/td[starts-with(@headers,'view-product-')]
    FOR    ${index}    IN RANGE    ${get_viewcart_list_count}    0    -1
        Log To Console    Count: ${index}    
        Click Element    xpath=(//a[@class='remove-btn'])[${index}]    
        Sleep    10s    
    END           
    ${check_cartpage_after_complete_del}=   Get Text    xpath=//div[@class='Empty_basket_Content']/h1    
    Run Keyword If    '${check_cartpage_after_complete_del}'!='Your Gift Cart is Empty'    Fail    "In View cart page after complete deletion 'Your Gift Cart is Empty' text not display"

To add child to a cart
    #Local browser launch
    Jenkins browser launch
    #Execute Javascript    window.scrollTo(0, 600)
    ${child_name}    ${sel_child_amt}    ${sel_child_imgsrc}    Rotator Child Details
    Log To Console    Child name:${child_name} and child amount:${sel_child_amt} and also child img src:${sel_child_imgsrc}        
    Rotator Payment validation    ${sel_child_imgsrc}
    Click Element    xpath=//a[@class='view_cart']
    Rotator Child cart validation    ${child_name}    ${sel_child_amt}"

SI Flow payment gateway list and text check
    #Local browser launch
    Jenkins browser launch
    Rescue child campaign
    SI login
    ${check_SI_postlogin_page}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//form[@class='payment_selection_form']
    Run Keyword If    'True'!='${check_SI_postlogin_page}'    Fail    "SI post login page not display"
    ${SI_payment_list}=    Get Element Count    xpath=.//div[@class='payment-main-content']/div
    Run Keyword If    3!=${SI_payment_list}    Fail    "SI Flow payment gateway list mismatch"
    FOR    ${SI_payment_txt}    IN    @{SI_payment_list_text}
        ${SI_payment_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='payment-main-content']/div[contains(.,'${SI_payment_txt}')]
        Run Keyword If    'True'!='${SI_payment_txt_chck}'    Fail    "SI flow payment gateway ${SI_payment_txt} text are mismatch"
    END
    #nedd to check campaign details
    
Check Add-on added in view cart page
    #Local browser launch
    Jenkins browser launch
    Educate children campaign with checkout flow
    ${check_addon_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='prdt_tle']
    Run Keyword If    'True'!='${check_addon_viewcart}'    Fail    "Viewcart page 'My Body My Rights' add-on not display
    Click Element    xpath=.//label[@for='edit-form-field-field-product-add-on-s-add-to-ca-0-field-product-add-on-s-add-to-ca-value']
    ${Chck_addon_added_or_not}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'My BODY')]
    Run Keyword If    'True'!='${Chck_addon_added_or_not}'    Fail    "After click Add-on not display in view cart page"
    ${hungercamp_amt+Add_on_amt}=    Evaluate    ${edu_child_amt}+${addon_val}
    ${convert_int_to_string_val}=    Convert To String    ${hungercamp_amt+Add_on_amt}
    ${hungercamp_amt+Add_on_amt_final_val}=    Replace String    ${convert_int_to_string_val}    4    4,
    Log To Console    Viewcart final total amount:${hungercamp_amt+Add_on_amt_final_val}
    ${chck_total_amt_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='order-total-line order-total-line__total']/span[@class='order-total-line-value'][contains(.,'₹${hungercamp_amt+Add_on_amt_final_val}')]
    Run Keyword If    'True'!='${chck_total_amt_viewcart}'    Fail    "In view cart page campaign amoutn and add-on amount of total amount are differ"
 
Child add from child rotator and payment success ccavenue
    #Local browser launch
    Jenkins browser launch        
    ${child_name}    ${sel_child_amt}    ${sel_child_imgsrc}    Rotator Child Details    
    Log To Console    Child name: ${child_name} and child amount: ${sel_child_amt} and also child img src: ${sel_child_imgsrc}
    Rotator Payment validation    ${sel_child_imgsrc}
    Click Element    xpath=.//a[@class='view_detailed']
    ${by_spec_child_count}=    Get Element Count    xpath=//div[@class='row mychilddet']/div/div
    Run Keyword If    ${by_spec_child_count}<1    Fail    "No child in By specifics page"
    Mouse Over    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='bySpecHoverContent']
    Click Element    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='bySpecHoverContent']/input
    ${byspec_child_name}=    Get Text    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='childproduct']//div[@class='inner_banner_pledge_content']/h2
    Click Element    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='addpledge pledgeblock']//div[@class='com_emergency_flood row']/span[2]/div/label
    ${get_byspec_child_amt}=    Get Element Attribute    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='addpledge pledgeblock']//div[@class='com_emergency_flood row']/span[2]/div/label    for
    ${add_symbol_to_amt}=    Replace String    ${get_byspec_child_amt}    2    2,
    Click Element    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='addpledge pledgeblock']//div[@class='SIpatent']//input
    Click Element    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='addpledge pledgeblock']//div[@class='siNonShow']//div[@class='kl_flood_sub_or_sec']/input
    Click Element    xpath=(.//a[@class='view_cart'])[1]
    
    Rotator Child cart validation    ${child_name}    ${sel_child_amt}    
    
    ${chck_byspec_child_name}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${byspec_child_name}')]
    Run Keyword If    'True'!='${chck_byspec_child_name}'    Fail    "By spec choosed child not display in view cart page"
    ${chck_byspec_child_amt}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'₹${add_symbol_to_amt}')]
    Run Keyword If    'True'!='${chck_byspec_child_amt}'    Fail    "By spec choosed child amount are mismatch in view cart page"
    View cart proceed button
    Login
    CCavenue payment success flow
 
Child add from child rotator and add extra child from add another child way
    #Local browser launch
    Jenkins browser launch
        
    ${child_name}    ${sel_child_amt}    ${sel_child_imgsrc}    Rotator Child Details
    Log To Console    Child name: ${child_name} and child amount: ${sel_child_amt} and also child img src: ${sel_child_imgsrc}
    Rotator Payment validation    ${sel_child_imgsrc}
    
    Click Element    xpath=.//a[@class='view_detailed']
    ${by_spec_child_count}=    Get Element Count    xpath=//div[@class='row mychilddet']/div/div
    Run Keyword If    ${by_spec_child_count}<1    Fail    "No child in By specifics page"
    Mouse Over    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='bySpecHoverContent']
    Click Element    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='bySpecHoverContent']/input
    ${byspec_child_name}=    Get Text    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='childproduct']//div[@class='inner_banner_pledge_content']/h2
    Click Element    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='addpledge pledgeblock']//div[@class='com_emergency_flood row']/span[2]/div/label
    ${get_byspec_child_amt}=    Get Element Attribute    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='addpledge pledgeblock']//div[@class='com_emergency_flood row']/span[2]/div/label    for
    ${add_symbol_to_amt}=    Replace String    ${get_byspec_child_amt}    2    2,
    Click Element    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='addpledge pledgeblock']//div[@class='SIpatent']//input
    Click Element    xpath=//div[@class='row mychilddet']/div/div[1]//div[@class='addpledge pledgeblock']//div[@class='siNonShow']//div[@class='kl_flood_sub_or_sec']/input
    Click Element    xpath=(.//a[@class='view_cart'])[1]
    
    Rotator Child cart validation    ${child_name}    ${sel_child_amt}

    ${chck_byspec_child_name}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${byspec_child_name}')]
    Run Keyword If    'True'!='${chck_byspec_child_name}'    Fail    "By spec choosed child not display in view cart page"
    ${chck_byspec_child_amt}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'₹${add_symbol_to_amt}')]
    Run Keyword If    'True'!='${chck_byspec_child_amt}'    Fail    "By spec choosed child amount are mismatch in view cart page"
    View cart proceed button
    Login
    Click Element    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div[4]
    ${check_visible_sponsor_child_checkout_gateway}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//table/tbody/tr/td[1][contains(.,'${child_name}')]
    Run Keyword If    'True'!='${check_visible_sponsor_child_checkout_gateway}'    Fail    "Selected child name not displayed in checckout payement gateway"
    ${check_visible_byspec_child_name_checkout_gateway}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//table/tbody/tr/td[1][contains(.,'${byspec_child_name}')]
    Run Keyword If    'True'!='${check_visible_byspec_child_name_checkout_gateway}'    Fail    "Selected By spec child name not displayed in checckout payement gateway"
    Click Element    xpath=(.//div[@id='offpay']//label)[1]
    Click Element    xpath=.//span[@class='offline_pay_btn']
    ${check_thq_page}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='thanks_description']/h1
    Run Keyword If    'True'!='${check_thq_page}'    Fail    "After payment through UPI 'Thank You' page text not display"
    
Ensure overview campaign label in Hosh menu
    [Tags]    Hope to Shine campaign
    
    Jenkins browser launch
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(.,'Ways to Give')]
    Click Element    xpath=//div[@class='main-menu-inner']//li/a[contains(.,'Overview')]
    ${overview_menus_list}=    Get Element Count    xpath=.//div[@class='views-element-container']//a
    Run Keyword If    ${overview_menus_list}!=12    Fail    "In Overview page menu list are mismatch"
    Click Element    xpath=//div[@class='col-md-12 ways-scroll-info']/div[1]//h3
    ${chck_banner_image}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='views-field views-field-field-banner-image']
    #Click Element    xpath=.//a[@class='real-gifts-btn']
    #Select Window    https://www.hopetoshine.in/
    #${hosh_url}=    Get Location
    #Log To Console    Hosh url is:${hosh_url}
    #Select Window    URL=https://prod.worldvision.in/real-gifts
    #${wv_url}=    Get Location
    #Log To Console    WV url is:${wv_url}
    Click Element    xpath=//div[@class='gbl_tabbed_menu']/ul/li[2]
    Mouse Over    xpath=//div[@class='IMGSec_cover']
    Sleep    5s    
    Click Element    xpath=//div[@class='Gift_add giftBtn']/input    
    Ensure default amount in educational need
    Add to cart functionality    
    Clear and input text    1000
    #Error default value and check button disable
    View cart page
    Sleep    10s        
    Cart campaign check and delete
    
Ensure overview campaign label in Back to school
    [Tags]    Back to school campaign       

    Jenkins browser launch
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(.,'Ways to Give')]
    Click Element    xpath=//div[@class='main-menu-inner']//li/a[contains(.,'Overview')]
    ${overview_menus_list}=    Get Element Count    xpath=//div[@class='views-element-container']//a
    Run Keyword If    ${overview_menus_list}!=12    Fail    "In Overview page menu list are mismatch"
    Click Element    xpath=//div[@class='col-md-12 ways-scroll-info']/div[3]//h3    
    #${chck_banner_image}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='views-field views-field-field-banner-image']    
    Click Element    xpath=//div[@class='gbl_tabbed_menu']/ul/li[2]
    Mouse Over    xpath=//div[@class='IMGSec_cover']
    Sleep    5s    
    Click Element    xpath=//div[@class='Gift_add giftBtn']/input
    Ensure default amount in educational need
    Add to cart functionality    
    Clear and input text    1000
    #Error default value and check button disable
    View cart page
    Sleep    10s    
    Cart campaign check and delete
    
Ensure overview campaign label in Gift catalog
    [Tags]    Gift catalog

    Jenkins browser launch
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(.,'Ways to Give')]
    Click Element    xpath=//div[@class='main-menu-inner']//li/a[contains(.,'Overview')]
    ${overview_menus_list}=    Get Element Count    xpath=.//div[@class='views-element-container']//a
    Run Keyword If    ${overview_menus_list}!=12    Fail    "In Overview page menu list are mismatch"
    Click Element    xpath=(//div[@class='views-element-container']//a)[1]
    Execute JavaScript    window.scrollTo(0, 100)
    Sleep    5s
    Mouse Over    xpath=(//div[@class='bySpecHoverContent'])[1]
    Click Element    xpath=(//input[contains(@class,'realGiftsSponsor')])[1]
    
    ${chck_sidediv_enable}=    Run Keyword And Return Status    Element Should Be Visible    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav'])[1]
    Run Keyword If    'True'!='${chck_sidediv_enable}'    Fail    "Side section information tab not display"
    
    ${camp_name}=    Get Text    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav'][1])[1]//div[@class='inner_banner_pledge_content']/h2
    ${camp_name}=    Get Substring    ${camp_name}    0    11
    ${chck_val_sidebar}=    Get Text    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='price'])[1]
    ${camp_amt_button}=    Remove String    ${chck_val_sidebar}    .00     
    ${camp_amt}=    Convert to price    ${camp_amt_button}         

    ${get_val_addtocart_button}=    Get Element Attribute    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='kl_flood_sub_or_sec']/input)[1]    value    
    ${button_amt}=    Convert to price    ${get_val_addtocart_button}
    Run Keyword If    ${camp_amt}!=${button_amt}    Fail    "Gift Catalog label amount and 'Add to Cart' button amount are mismatch"        

    Add to cart functionality - Gift catalog

    Clear Element Text    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='realgift_input_value commerce_manual_inputs']/input)[1]

    Click Element    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='kl_flood_sub_or_sec']/input)[1]    

    Click Element    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav'][1])//a[contains(text(),'Proceed To Checkout')]    
    
    ${camp_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${camp_name}')]
    Run Keyword If    'True'!='${camp_viewcart}'    Fail    "${camp_name} campaign not display in view cart page"
    ${camp_amt_viewcart}=    Get Text    xpath=//td[@class='views-field views-field-product-id'][contains(.,'Food Basket')]/following-sibling::td[3]
    ${camp_amt_viewcart}=    Convert to price    ${camp_amt_viewcart}
    Run Keyword If    ${camp_amt}!=${camp_amt_viewcart}    Fail    "${camp_name} campaign amount are not display or mismatch in view cart page"   
    ${cart_quanity}=    Get Element Attribute    xpath=//span[@class='dynamic-quantity']//input    value
    
    View cart proceed button
    Login
    CCavenue payment success flow
    
Post login menus check
    
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Sleep   15s
    ${postloginheadermenu_list}=    Get Element Count    xpath=//div[@class='main-menu-inner']//nav[@data-menu-name='post-login-menu-section']/div/ul/li
    Log To Console    "No of Post login menus: ${postloginheadermenu_list}"    
    Run Keyword If    '${postloginheadermenu_list}'!='${postlogin_menu_list}'    Fail    "Post login header main menu list size are mismatch"
    #${postlogin_menu_txt}=    Get Text    xpath=//div[@class='main-menu-inner']//ul[@class='we-mega-menu-ul nav nav-tabs']/li
    FOR    ${postlogin_menu_txt}    IN    @{postlogin_homepage_header_chck_menu_txt}        
        Log To Console    "Post login menus are : ${postlogin_menu_txt}"
        Mouse Over    xpath=//div[@class='main-menu-inner']//nav[@data-menu-name='post-login-menu-section']/div/ul/li/*[contains(text(),'${postlogin_menu_txt}')]
        ${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='main-menu-inner']//nav[@data-menu-name='post-login-menu-section']/div/ul/li/*[contains(text(),'${postlogin_menu_txt}')]    
        Run Keyword If    'True'!='${menu_txt_chck}'    Fail    "Postlogin home page ${postlogin_menu_txt} text are mismatch"
    END  
    
Post login ways to give submenu list verification
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    ${headermenu_list}=    Get Element Count    xpath=//li/span[contains(text(),'Ways to Give')]/parent::li//ul//a
    Log To Console    No of Submenus: ${headermenu_list}    
    Run Keyword If    '${headermenu_list}'!='12'    Fail    "Ways to give sub menu list size are mismatch"
    FOR    ${menu_txt}    IN    @{Ways_to_give}
        Mouse Over    xpath=//li/span[contains(text(),'Ways to Give')]
        ${menu_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//li/span[contains(text(),'Ways to Give')]/parent::li//ul//a[contains(.,'${menu_txt}')]
        Run Keyword If    'True'!='${menu_txt_chck}'    Fail    "Postlogin Ways to give submenu ${menu_txt} text are mismatch"
    END
    
# Ensure user can able to change passport holder
    # Jenkins browser launch
    # Click Element    xpath=//a[contains(text(),'Login')]
    # Click Element    id=edit-name
    # Input Text    id=edit-name  aswin.l@live.in
    # Click Element    id=edit-pass
    # Input Text    id=edit-pass  test
    # Click Element    xpath=(//div[@class='login-form__submit']/button)[1]
    # Mouse Over    xpath=.//li[@class='welcomesponsor']
    # Click Element    xpath=.//ul[@class='mypro-lgot']/li/a[contains(.,'My profile')]
    # Click Element    xpath=.//a[contains(.,'Edit Profile')]
    # Scroll Element Into View    xpath=.//label[@for='edit-field-nationality']
    # ${ind}=    Execute Javascript    return window.jQuery('#indctzn').prop('checked')
    # Log To Console    Indian is choosed:${ind}
    # ${other}=    Execute Javascript    return window.jQuery('#othctzn').prop('checked')
    # Log To Console    Other is choosed:${other}
    # Run Keyword If    'True'=='${ind}'    Check other passport holder
    # Run Keyword If    'True'=='${other}'    Check indian passport holder
    # ${again_other}=    Execute Javascript    return window.jQuery('#othctzn').prop('checked')
    # Run Keyword If    'True'=='${again_other}'    Check indian passport holder
    
Indian citizen should not change to Other passport holder
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Navigation banner close
    MyProfile Edit
    ${ind}=    Execute Javascript    return window.jQuery('#indctzn').prop('checked')
    Log To Console    Indian is choosed:${ind}      
    Run Keyword If    'True'=='${ind}'    Check other passport holder
    
Other passport holder should not change to Indian passport holder
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login - Other passport user
    Navigation banner close
    MyProfile Edit
    ${other}=    Execute Javascript    return window.jQuery('#othctzn').prop('checked')
    Log To Console    Other is choosed:${other}  
    Run Keyword If    'True'=='${other}'    Check indian passport holder


To verify payment gateways for other passport holder
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login - Other passport user
    Mouse Over    xpath=.//li[@class='welcomesponsor']
    Click Element    xpath=.//ul[@class='mypro-lgot']/li/a[contains(.,'My profile')]
    Click Element    xpath=.//a[contains(.,'Edit Profile')]
    Scroll Element Into View    xpath=.//label[@for='edit-field-nationality']
    ${other}=    Execute Javascript    return window.jQuery('#othctzn').prop('checked')
    Run Keyword If    'True'!='${other}'    Fail    "By default Other passport holder should be checked but not like that"
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    #Select Hunger free campaign
    Mouse Over    xpath=//li/span[contains(text(),'Ways to Give')]
    Click Element    xpath=(.//li/a[contains(.,'Hungerfree')])[1]
    Sleep    10s
    Click Element    xpath=.//div[@class='add-to-cart-section']
    ${hunger_camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    ${split_Hunger_name_with_rightside}=    Remove String    ${hunger_camp_name}    Free
    ${input_val}=    Get Element Attribute    xpath=.//input[@name='manualCart[0][amount]']    value
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"
    Click Element    xpath=//a[@class='view_cart']
    Banner Alert
    ${hunger_camp_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${split_Hunger_name_with_rightside}[0]')]
    Run Keyword If    'True'!='${hunger_camp_viewcart}'    Fail    "Hunger Free campaign not display in view cart page"
    ${replace_val}=    Replace String    ${input_val}    1    1,
    ${hunger_camp_amt_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'₹${replace_val}')]
    Run Keyword If    'True'!='${hunger_camp_amt_viewcart}'    Fail    "Hunger Free campaign amount is mismatch in view cart page"
    View cart proceed button
    ${checkout_payment_list}=    Get Element Count    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div
    Run Keyword If    3!=${checkout_payment_list}    Fail    "Checkout flow Other passport holder payment list are mismatch"
    FOR    ${bank_txt}    IN    @{checkout_payment_list_text}
        ${checkout_banklist_name_check}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'${bank_txt}')]
        Run Keyword If    'True'!='${checkout_banklist_name_check}'    Fail    'Checkout Flow Other passport holder Payment Gateway ${bank_txt} text is mismatch'
    END

To verify payment gateways for indian citizen
    #Local browser launch
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Mouse Over    xpath=.//li[@class='welcomesponsor']
    Click Element    xpath=.//ul[@class='mypro-lgot']/li/a[contains(.,'My profile')]
    Click Element    xpath=.//a[contains(.,'Edit Profile')]
    Scroll Element Into View    xpath=.//label[@for='edit-field-nationality']
    ${ind}=    Execute Javascript    return window.jQuery('#indctzn').prop('checked')
    Run Keyword If    'True'!='${ind}'    Fail    "By default Indian passport holder should be checked but not like that"
    Click Element    xpath=.//a[contains(.,'My Gifts')]    
    Banner Alert   
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}          
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}    
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(text(),'Ways to Give')]
    Click Element    xpath=//div[@class='main-menu-inner']//li/a[contains(text(),'Educate Children')]
    Sleep    5s
    Click Element    xpath=.//div[@class='item-image']//img
    ${educate_chld_camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div        
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    Sleep    15s
    Click Element    id=ChkForSI
    Click Element    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Input Text    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    ${edu_child_amt}
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    Click Element    xpath=//a[@class='view_cart']    
    Banner Alert
    ${replace_val_educate_camp}=    Replace String    ${edu_child_amt}    4    4,
    ${edu_child_camp_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id' and contains(text(),'${educate_chld_camp_name}')]
    Run Keyword If    'True'!='${edu_child_camp_viewcart}'    Fail    "Educate children campaign not display in view cart page"
    ${chck_edu_child_camp_amt_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'₹${replace_val_educate_camp}')]
    Run Keyword If    'True'!='${chck_edu_child_camp_amt_viewcart}'    Fail    "Educate children campaign amount are not display/mismatch in view cart page"
    View cart proceed button
    ${checkout_payment_list}=    Get Element Count    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div
    Run Keyword If    5!=${checkout_payment_list}    Fail    "Checkout flow Indian passport holder payment list are mismatch"
    FOR    ${bank_txt}    IN    @{checkout_payment_list_text}
        ${checkout_banklist_name_check}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'${bank_txt}')]
        Run Keyword If    'True'!='${checkout_banklist_name_check}'    Fail    'Checkout Flow Indian passport holder Payment Gateway Powered by ${bank_txt} text is mismatch'
    END
    FOR    ${checkout_bank_txt}    IN    @{checkout_payment_list_ind_passport}
        ${checkout_banklist_name_check}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/label[contains(.,'${checkout_bank_txt}')]
        Run Keyword If    'True'!='${checkout_banklist_name_check}'    Fail    'Checkout Flow Indian passport holder Payment Gateway ${bank_txt} text is mismatch'
    END
 
Max val alert in view cart page
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}                   
    FOR    ${sponcer}    IN    @{Sponcer_List}
        Ways to give - 5 items    ${sponcer}
    END
    ${proceed_btn_disable}=    Run Keyword And Return Status    Element Should Be Disabled    id=edit-checkout
    Run Keyword If    'True'=='${proceed_btn_disable}'    Log To Console    "Proceed button is disabled"
    ${max_erro_msg}=    Run Keyword And Return Status    Element Should Be Visible    //div[@class='max-amount']
    Run Keyword If    'True'!='${max_erro_msg}'    Fail    "Donation is more than 10 lakhs and alert message doesnt appear"
    
Verify User should able to Edit Existing profile details
    [Tags]    My Profile
    Jenkins browser launch
    Click Element    xpath=//a[text()='Login']
    Direct login
    Sleep    20s    
    Navigation banner close
    MyProfile Edit
    Scroll Element Into View    id=edit-submit
    Click Element    id=edit-submit   
    
To verify app store and google play link appear in postlogin
    [Tags]    Page Footer
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Navigation banner close
    Scroll Element Into View    xpath=//img[contains(@src,'app store.PNG')]
    ${status_appstore}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//img[contains(@src,'app store.PNG')]
    ${status_playstore}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//img[contains(@src,'gppgle pay.PNG')]    
    Run Keyword If  'True'!='${status_appstore}' or 'True'!='${status_playstore}'    Fail    "AppStore and PlayStore images are not visible in POST-LOGIN page"    ELSE    Log To Console    "AppStore and PlayStore images are visible in POST-LOGIN page"

To verify app store and google play link should not appear in prelogin
    [Tags]    Page Footer
    
    Jenkins browser launch
    Navigation banner close
    Execute Javascript    window.scrollTo(0, 900)
    ${status_appstore}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//img[contains(@src,'app store.PNG')]
    ${status_playstore}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//img[contains(@src,'gppgle pay.PNG')]    
    Run Keyword If  'True'!='${status_appstore}' or 'True'!='${status_playstore}'    Fail    "AppStore and PlayStore images are visible in PRE-LOGIN page"    ELSE    Log To Console    "AppStore and PlayStore images are not visible in PRE-LOGIN page"     

To verify my campaign details for existing user
    [Tags]    My Campaign
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'My Campaign')]    
    ${campaign_status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='userCampHolder']//a    
    Run Keyword If    'True'!='${campaign_status}'    Fail    'My campaign details are not visible'    ELSE    MyCampaign List

# To verify my campaign details for new user
    # [Tags]    My Campaign
    # Jenkins browser launch
    # Navigation banner close
    # Registration - Indian    
    # Navigation banner close
    # Click Element    xpath=//a[contains(text(),'My Campaign')]    
    # ${campaign_status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='userCampHolder']//a    
    # Run Keyword If    'True'!='${campaign_status}'    Fail    'My campaign details are not visible'    ELSE    MyCampaign List

To verify Overview page
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Navigation banner close
    Mouse Over    xpath=//li/span[contains(text(),'Ways to Give')]
    Click Element    xpath=//a[contains(text(),'Overview')]    
    ${campaign_status}=    Run Keyword And Return Status    Element Should Be Visible    class=Way_give_title    
    Run Keyword If    'True'!='${campaign_status}'    Fail    'Overview campaign details are not visible'    ELSE    Overview List 

To Verify current emergency campaign in overview page
    [Tags]    Overview Page
    
    Jenkins browser launch
    Navigation banner close
    ${mylist} =    Create List
    Mouser hover ways to give campaign    Emergency Relief
    ${Emergency_relief}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[contains(@id,'current-emergency')]
    Run Keyword If    ${True}!=${Emergency_relief}    Fail    There are no current "emergency page"    ELSE    Log To Console    Redirected to "emergency page"       
    @{emergency_relief}=    Get WebElements    xpath=//h5[@class='campaign-title']/a
    FOR    ${element}    IN    @{emergency_relief}
        ${text}=    Get Text    ${element}
        Log To Console    Current Emergencey reliefs are: ${text}    
        Append To List    ${mylist}    ${text}    
    END    
    Mouser hover ways to give campaign    Overview                       
    FOR    ${element}    IN    @{mylist}                 
        ${list_status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//h3[contains(text(),'${text}')]    
        Run Keyword If    ${True}==${list_status}    Log To Console    "Emergency relief camapigns are visible in Overview page"    ELSE    Fail    "Emergency relief camapigns are not visible in Overview page"
    END
    
Verify user should Able to add profile details with Valid Data
    [Tags]    My Profile    

    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Navigation banner close
    MyProfile Edit
    Click Element    xpath=//input[contains(@id,'edit-field-pan-number')]    
    
    Input Text    xpath=//input[@id='edit-field-last-name-0-value']    NewLastName Test
    Input Text    Xpath=//input[@id='edit-field-registeraddress-0-value']    New Test address1 Test
    Input Text    xpath=//input[@id='edit-field-address-2-0-value']    New Test address2 Test
    
    Scroll Element Into View    id=edit-submit    
    Click Element    id=edit-submit

    Mouse Over    xpath=.//li[@class='welcomesponsor']
    Click Element    xpath=.//ul[@class='mypro-lgot']/li/a[contains(.,'My profile')]    

    ${last_Name}=    Get Text    xpath=//span[@class='userspanprofile']/div
    Run Keyword If    'NewLastName Test'=='${last_Name}'    Log To Console    "LastName Updated in Edit profile"    ELSE    Fail    "Unable to edit Last Name"
    ${address_1}=    Get Text    xpath=//li[@class='user_address']/div//div[2]
    Run Keyword If    'New Test address1 Test'=='${address_1}'    Log To Console    "Address field 1 Updated in Edit profile"    ELSE    Fail    "Unable to edit Address field 1"
    ${address_2}=    Get Text    xpath=(//span[@class='userspanprofile1'])[1]/div
    Run Keyword If    'New Test address2 Test'=='${address_2}'    Log To Console    "Address field 2 Updated in Edit profile"    ELSE    Fail    "Unable to edit Address field 2"
    
    MyProfile Edit
    Input Text    xpath=//input[@id='edit-field-last-name-0-value']    NewLastName
    Input Text    Xpath=//input[@id='edit-field-registeraddress-0-value']    New Test address1
    Input Text    xpath=//input[@id='edit-field-address-2-0-value']    New Test address2
    
    Scroll Element Into View    id=edit-submit    
    Click Element    id=edit-submit
    
    Mouse Over    xpath=.//li[@class='welcomesponsor']
    Click Element    xpath=.//ul[@class='mypro-lgot']/li/a[contains(.,'My profile')]    
  
To verify that user can edit the City State Country even though it is auto Populated
    [Tags]    Registration Page
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Register')]     
    Sleep    10s          
    Scroll Element Into View    class=singUpRegister    
    #Click Element    xpath=//input[contains(@id,'edit-field-pin-code')]    
    Input Text    xpath=//input[contains(@id,'edit-field-pin-code')]    600123          
    # ${chat_box}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@id='ChatOpen']/div[2]    
    # Run Keyword If    'True'=='${chat_box}'    Click Element    xpath=//div[@id='ChatOpen']/div[2]     ELSE    Log To Console    "Chat Box was not present"
    #Pincode
    #Click Element    xpath=//input[contains(@id,'edit-field-pin-code')]    
    Clear Element Text    xpath=//input[contains(@id,'edit-field-pin-code')]
    Input Text    xpath=//input[contains(@id,'edit-field-pin-code')]    600012    
    #City
    #Click Element    xpath=//input[contains(@id,'edit-field-city')]    
    Clear Element Text    xpath=//input[contains(@id,'edit-field-city')]
    Input Text    xpath=//input[contains(@id,'edit-field-city')]    Chennai
    #State
    #Click Element    xpath=//input[contains(@id,'edit-field-regstate')]    
    Clear Element Text    xpath=//input[contains(@id,'edit-field-regstate')]
    Input Text    xpath=//input[contains(@id,'edit-field-regstate')]    Tamil Nadu    
    #Country
    Select From List By Label    id=edit-field-country    India  
 

To Verify Existing user Email Id and Phone Should not Accept for New User Registration
    [Tags]    Registration Page
        
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Register')]     
    Sleep    10s          
    Registration - Indian - Test
    ${email_status}=    Run Keyword And Return Status    Element Should Be Visible    id=signUpEmailErr
    Run Keyword If    'True'=='${email_status}'    Log To Console    "Email alert is dispayed"    ELSE    Fail    "Email alert was not displayed"
    ${phone_status}=    Run Keyword And Return Status    Element Should Be Visible    id=signInPhoneErr
    Run Keyword If    'True'=='${phone_status}'    Log To Console    "phone number alert is dispayed"    ELSE    Fail    "Phone number alert was not displayed"   
    
To sponsor a Rescue Children Campaign as a one time donation using Checkout flow
    [Tags]  Childhood Rescue Campaign
        
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}           
    Mouser hover ways to give campaign    Childhood Rescue
    Click Element    xpath=.//div[@class='item-image']//img
    ${camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    ${camp_name}=    Remove String    ${camp_name}    Childhood
    Log To Console    ${camp_name}    
    Sleep    15s
    #Wait Until Element Is Visible    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label    15s    
    Click Element    id=ChkForSI
    Click Element    xpath=//div[@class='realgift_input_value commerce_manual_inputs']/input[1]    
    Input Text    xpath=//div[@class='realgift_input_value commerce_manual_inputs']/input[1]    ${amount}    
    ${button_text}=    Get Element Attribute    xpath=//div[@class='kl_flood_sub_or_sec']/input    value
    Run Keyword If    'Add to cart'=='${button_text}'    Log To Console    "Button changed to ADD TO CART"    ELSE    Fail    "Button was not changed to ADD TO CART"     
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']/input
    Click Element    xpath=//div[@class='cart-buttons']/a[2]    
    ${amount}=    Replace String    ${amount}    1    1,
    check in view cart page    ${camp_name}    ${amount}
    View cart proceed button
    Login
    CCavenue payment success flow    


To sponsor a Save malnourished Children Campaign using Si payment Flow from Educ
    [Tags]    Save Malnourished Children Campaign
    Jenkins browser launch
    Navigation banner close
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    Save Malnourished Children
    SI flow campaign
    SI login
    Sleep    15s    
    FOR    ${element}    IN    @{SI_payment_list_text}
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='payment-main-content']/div[contains(text(),'${element}')]
        Run Keyword If    '${status}'!='True'    Fail    'Payment type was not displayed"    ELSE    Log To Console    "payment types are displayed"    
    END

To sponsor a Save malnourshied Children Campaign as a one time donation using Checkout flow
    [Tags]    Save Malnourished Children Campaign 

    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count} 
    Mouser hover ways to give campaign    Save Malnourished Children  
    ${camp_name}    ${Camp_val}    one time campaign - Save malnourshied Children Campaign
    ${cart_quanity}    check in view cart page - One time donation flow    ${camp_name}    ${Camp_val}
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${camp_name}    ${Camp_val}    ${cart_quanity}

To sponsor a Educate Children Campaign using Si payment Flow from Educate Children campaign page
    [Tags]    Educate Children Campaign
    
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    Educate Children
    SI flow campaign
    SI login
    Sleep    15s    
    FOR    ${element}    IN    @{SI_payment_list_text}
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='payment-main-content']/div[contains(text(),'${element}')]
        Run Keyword If    '${status}'!='True'    Fail    'Payment type was not displayed"    ELSE    Log To Console    "payment types are displayed"    
    END

To sponsor a Protect Girl Children Campaign as a one time donation using Checkout flow
    [Tags]    Protect Girl Children Campaign
    
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    End Child Sexual Abuse  
    ${camp_name}    ${Camp_val}    one time campaign
    ${cart_quanity}    check in view cart page - One time donation flow   ${camp_name}    ${Camp_val}
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${camp_name}    ${Camp_val}    ${cart_quanity}

To select children through location filter
    [Tags]    Sponsor a Child
    Jenkins browser launch
    Banner Alert
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(.,'Child Sponsorship')]
    Click Element    xpath=//div[@class='main-menu-inner']//a[contains(.,'Sponsor a Child')]
    
    Sleep    15s    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='modal-content-survey2']/span
    Run Keyword If    'True'=='${status}'    Click Element    xpath=//div[@class='modal-content-survey2']/span    ELSE    Log To Console    "Alert was not present"
    
    ${by_specific}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//span[contains(@class,'checked')]   
    Run Keyword If    '${by_specific}'=='True'    Log To Console    "By specific is selected by default"    ELSE    Fail    "By specific was not selected by default"
    
    ${most_needed}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='gbl_tabbed_menu']//li[contains(@class,'most-needed active')]
    Run Keyword If    '${most_needed}'=='True'    Log To Console    "Most Needed is selected by default"    ELSE    Fail    "Most Needed was not selected by default"
    
    ${state}=    Get Text    xpath=(//label[contains(@for,'locality-the-top-level-administrative-subdivision')])[1]/span[1]
    Click Element    xpath=(//label[contains(@for,'locality-the-top-level-administrative-subdivision')])[1]/span[1]  
    
    Scroll Element Into View    xpath=//div[@class='bySpecContHolder']//p[contains(text(),'${state}')]
    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='bySpecContHolder']//p[contains(text(),'${state}')]        
    Run Keyword If    'True'!='${status}'    Fail    "Childrens are not available on the state you selected"    ELSE    Log To Console    "Childrens are available on the selected state"        
   

To select children through age filter
    [Tags]    Sponsor a Child
    
    Jenkins browser launch
    Banner Alert
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(.,'Child Sponsorship')]
    Click Element    xpath=//div[@class='main-menu-inner']//a[contains(.,'Sponsor a Child')]
    
    Sleep    15s    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='modal-content-survey2']/span
    Run Keyword If    'True'=='${status}'    Click Element    xpath=//div[@class='modal-content-survey2']/span    ELSE    Log To Console    "Alert was not present"
    
    ${by_specific}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//span[contains(@class,'checked')]   
    Run Keyword If    '${by_specific}'=='True'    Log To Console    "By specific is selected by default"    ELSE    Fail    "By specific was not selected by default"
    
    ${most_needed}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='gbl_tabbed_menu']//li[contains(@class,'most-needed active')]
    Run Keyword If    '${most_needed}'=='True'    Log To Console    "Most Needed is selected by default"    ELSE    Fail    "Most Needed was not selected by default"
    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//label[@for='age-range-above-12-years']//span[contains(text(),'Above 12 Years')]    
    Run Keyword If    'True'!='${status}'    Fail    'Currently there are no childrens or Childrens age are below 12 years"    ELSE    Log To Console    "Children's are found"
    ${age}=    Get Text    xpath=//label[@for='age-range-above-12-years']//span[contains(text(),'Above 12 Years')]
    ${age}=    Remove String Using Regexp    ${age}    \\D
    #Log To Console    ${age}    
    ${age}=    Convert To Integer    ${age}            
    Click Element    xpath=//label[@for='age-range-above-12-years']//span[contains(text(),'Above 12 Years')] 
    Sleep    15s         
    ${age_count}=    Get Element Count    xpath=//div[@class='bySpecinfo']//span[1]
    Log To Console    No of childrens found: ${age_count}
    FOR    ${element}    IN RANGE    1    ${age_count}+1    
        Mouse Over    xpath=(//div[@class='bySpecHoverContent'][1])[${element}]        
        ${Text}=    Get Text    xpath=(//div[@class='bySpecinfo']//span[1])[${element}]
        ${element_age}=    Convert To Integer    ${Text}
        Run Keyword If    ${element_age}>${age}    Log To Console    "Sorted children age is : ${element_age}'    ELSE    Fail    "Site show children out of filter applied"        
    END

To select children through gender filter
    [Tags]    Sponsor a Child
    
    Jenkins browser launch
    Banner Alert
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(.,'Child Sponsorship')]
    Click Element    xpath=//div[@class='main-menu-inner']//a[contains(.,'Sponsor a Child')]
    
    Sleep    15s    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='modal-content-survey2']/span
    Run Keyword If    'True'=='${status}'    Click Element    xpath=//div[@class='modal-content-survey2']/span    ELSE    Log To Console    "Alert was not present"
    
    ${by_specific}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//span[contains(@class,'checked')]   
    Run Keyword If    '${by_specific}'=='True'    Log To Console    "By specific is selected by default"    ELSE    Fail    "By specific was not selected by default"
    
    ${most_needed}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='gbl_tabbed_menu']//li[contains(@class,'most-needed active')]
    Run Keyword If    '${most_needed}'=='True'    Log To Console    "Most Needed is selected by default"    ELSE    Fail    "Most Needed was not selected by default"
    
    Execute JavaScript    window.scrollTo(0, 400)

    ${gender}=    Get Text    xpath=//label[@for='gender-boy']/span[1]
    ${gender}=    Replace String    ${gender}    B    b
    Click Element    xpath=//label[@for='gender-boy']/span[1]      

    Sleep    15s    

    Wait Until Element Is Visible    xpath=//li[@class='pager__item']/a
    Click Element    xpath=//li[@class='pager__item']/a            
    
    Sleep    10s        

    ${gender_count}=    Get Element Count    xpath=//div[@class='bySpecContHolder']//p/span[contains(text(),'${gender}')]
    Log To Console    No of childrens found: ${gender_count}
    FOR    ${element}    IN RANGE    1    ${gender_count}+1
        Mouse Over    xpath=(//div[@class='bySpecHoverContent'][1])[${element}]
        ${gender_got}=    Get Text    xpath=(//div[@class='bySpecContHolder']//p/span[contains(text(),'${gender}')])[${element}]    
        Run Keyword If    '${gender_got}'!='${gender}'    Fail    "Sorted was not based on the given gender"        
    END


To verify uncheck and check allow auto debit, It should lead to SI flow
        
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    Childhood Rescue
    
    Click Element    xpath=.//div[@class='item-image']//img
    ${camp_name}=    Get Text    xpath=//div[@class='inner_banner_pledge_content']/h2/div
    ${label_val}=    Get Text    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    ${del_month_get_val_only}=    Fetch From Right    ${label_val}    3 Months
    ${final_val}=    Strip String    ${SPACE}${del_month_get_val_only}
    Log To Console    Final val is: ${final_val}
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    
    Click Element    id=ChkForSI    
    
    ${button_text}=    Get Element Attribute    xpath=//div[@class='kl_flood_sub_or_sec']/input    value
    Run Keyword If    'Add to cart'=='${button_text}'    Log To Console    "Button text changed to 'Add to cart'    ELSE    Fail    "Button text was not changed to 'Add to cart'
    
    Click Element    id=ChkForSI
    
    ${button_text}=    Get Text    xpath=//div[@class='SIPopBlock']//button
    Run Keyword If    'PROCEED TO AUTOPAY'=='${button_text}'    Log To Console    "Button text changed to 'PROCEED TO AUTOPAY'    ELSE    Fail    "Button text was not changed to 'PROCEED TO AUTOPAY'       

    Click Element    xpath=//div[@class='SIPopBlock']//button    
    
    SI login
    
    Sleep    15s    
    FOR    ${element}    IN    @{SI_payment_list_text}
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='payment-main-content']/div[contains(text(),'${element}')]
        Run Keyword If    '${status}'!='True'    Fail    'Payment type was not displayed"    ELSE    Log To Console    "${element} is displayed in payment page"    
    END

Password should be displayed in masked format rather than showing actual text format
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Click Element    id=edit-name    
    Input Text    id=edit-name    username    
    Click Element    id=edit-pass    
    Input Text    id=edit-pass    DummyPassword
    Capture Page Screenshot    
    ${password_status}=    Get Element Attribute    id=edit-pass    type
    Run Keyword If    '${password_status}'=='password'    Log To Console    'Password is in masked format'    ELSE    Fail    'Password is not in masked format'


To sponsor a Help HIV aids Campaign as a one time donation using Checkout flow
    [Tags]    Help Hiv aids Campaign
    
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    HIV & AIDS
    ${camp_name}    ${Camp_val}    one time campaign - Help HIV aids Campaign
    ${cart_quanity}    check in view cart page - One time donation flow    ${camp_name}    ${Camp_val}  
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${camp_name}    ${Camp_val}    ${cart_quanity}

To sponsor a Protect Girl Children Campaign using Checkout flow
    [Tags]    Protect Girl Children Campaign

    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    End Child Sexual Abuse
    Sleep    5s    
    ${camp_name}    ${camp_amt}    Checkout flow campaign
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${camp_amt}
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${camp_name}    ${camp_amt}    ${cart_quanity}

# To sponsor a Protect Girl Children Campaign using Checkout flow
    # Jenkins browser launch
    # Click Element    xpath=.//a[contains(.,'My Gifts')]
    # Banner Alert
    # ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    # ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    # Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    # Mouser hover ways to give campaign    End Child Sexual Abuse
    # Sleep    5s
    # Click Element    xpath=.//div[@class='item-image']//img
    # ${camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    # Click Element    id=ChkForSI
    # Sleep    10s    
    # ${label_val}=    Get Text    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    # ${Camp_amt}=    Get Substring    ${label_val}    9    16
    # Log To Console    Final val is: ${camp_amt}
    # Sleep    15s   
    # Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label    
    # Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    # Click Element    xpath=//a[@class='view_cart']
    # ${view_cart_amount}=    Get Text    xpath=//td[@class='views-field views-field-total-price__number views-align-center']
    # Log To Console    View cart page campaign amount: ${view_cart_amount}
    # check in view cart page    ${camp_name}    ${camp_amt}
    # View cart proceed button
    # Login
    # CCavenue payment success flow


To Verify title select from the options provided in th the dropdown
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Register')]
    FOR    ${element}    IN    @{registration_title}
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-field-title 
        Run Keyword If    '${status}'=='True'    Select From List By Label    id=edit-field-title    ${element}    ELSE    Fail    "${element} is not in title dropdown"
    END
    
To Verify User should submit the form without entering any details
    Jenkins browser launch
    Navigation banner close
    Mouse Over    xpath=//div[@class='main-menu-inner']//*[contains(text(),'About Us')]
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Contact Us')] 
    Sleep    30s    
    Scroll Element Into View    id=edit-actions-submit
    Click Element    id=edit-actions-submit    
    FOR    ${element}    IN    @{alert_list}
        ${alert}=    Run Keyword And Return Status    Element Should Be Visible    id=${element}
        Run Keyword If    'True'!='${alert}'    Fail    "${element} name alert not display"          
    END    

To Verify User should submit the form without entering any details - End Child sexual abuse Page
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Mouser hover ways to give campaign    End Child Sexual Abuse 
    Sleep    30s    
    Scroll Element Into View    id=edit-actions-submit
    Click Element    id=edit-actions-submit    
    FOR    ${element}    IN    @{alert_list}
        ${alert}=    Run Keyword And Return Status    Element Should Be Visible    id=${element}
        Run Keyword If    'True'!='${alert}'    Fail    "${element} name alert not display"          
    END 
    
To sponsor a Help Hiv aids Campaign using Checkout flow
    [Tags]    Help Hiv aids Campaign        

    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    Cart campaign check and delete            
    Mouser hover ways to give campaign    HIV & AIDS
    Sleep    5s            
    ${camp_name}    ${camp_amt}    Checkout flow campaign - HIV
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${camp_amt}
    View cart proceed button
    Login
    CCavenue payment success flow 
    CCavenue payment - cart verification    ${camp_name}    ${camp_amt}    ${cart_quanity}          
    
To verify gallery and recent videos in my child page
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Child')]
    Sleep    20s    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//h2[@class='savegallry-head']/span[contains(text(),'Gallery')]       
    Run Keyword If    'True'!='${status}'    Fail    "Gallery section was not loading in mychild page"    ELSE    Log To Console    "Gallery section loading successfully"
    @{galary_img}=    Get WebElements    xpath=//div[@class='child-gallery']//img
    FOR    ${element}    IN    @{galary_img}
        ${image}=    Get Element Attribute    ${element}    title
        Log To Console    Images displaying in My child page are: ${image}    
    END
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//h2[@class='savegallry-head']/span[contains(text(),'Recent Video')]       
    Run Keyword If    'True'!='${status}'    Fail    "Recent video section was not loading in mychild page"    ELSE    Log To Console    "Recent video section loading successfully"
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='sponsor_header']/img       
    Run Keyword If    'True'!='${status}'    Fail    "Recent video was not uploaded in mychild page"    ELSE    Log To Console    "Recent video was uploaded in mychild page"
    Click Element    xpath=//div[@class='sponsor_header']/img     
    
To Verify User should submit the form without entering any details - HungerFree page
    [Tags]    Hunger Free Campaign
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Mouser hover ways to give campaign    Hungerfree 
    Sleep    30s    
    Scroll Element Into View    id=edit-actions-submit
    Click Element    id=edit-actions-submit    
    FOR    ${element}    IN    @{HungerFree_alert}
        ${alert}=    Run Keyword And Return Status    Element Should Be Visible    id=${element}
        Run Keyword If    'True'!='${alert}'    Fail    "${element} name alert not display"          
    END 
    
To verify child profile
    [Tags]    MyChild Page
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Child')]
    Sleep    20s    
    Click Element    xpath=(//div[@class='child_name heartbeat'])[1]
    @{child_details}=    Get WebElements    xpath=//ul[@class='tab-mnu']/li/p
    FOR    ${element}    IN    @{child_details}
        ${text}=    Get Text    ${element}
        Log To Console    Details enabled for child:    ${text}    
    END    
    Click Element    xpath=//p[contains(text(),'PROFILE')]
    ${sponsor_amt}=    Get Text    xpath=//div[contains(@class,'sponsorship-amount')]/p
    ${Payment_Frequency}=    Get Text    xpath=//div[contains(@class,'Payment-period')]/p[1]
    ${Child_Image}=    Get Element Attribute    xpath=//div[@class='child-image']/img    src        
    Log To Console    Sponsored amount is: ${sponsor_amt}, Payment frequency for the child is: ${Payment_Frequency} and child image are at: ${Child_Image}
    Click Element    xpath=//p[contains(text(),'PROJECT METER')]
    ${adp}=    Get Text    xpath=//div[contains(@class,'proj_id')]    
    ${adp} =    Remove String Using Regexp    ${adp}    \1.*$
    Log To Console    Area development details: ${adp}    

To verify schedule a call
    [Tags]    MyChild Page    

    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Child')]
    Click Element    xpath=(//div[@class='child_title'])[1]    
    ${schedule_call}=    Get Text    xpath=//div[contains(@class,'call-schedule')]/a/p    
    Run Keyword If    'Schedule a Call'=='${schedule_call}'    Log To Console    "Schedule call option is enabled"    ELSE    Fail    "Schedule call options is not enabled"
    Click Element    xpath=//div[contains(@class,'call-schedule')]/a/p
    
    ${CurrentDate}=    Get Current Date    result_format=%Y-%m-%d
    ${datetime}=    Convert Date    ${CurrentDate}    datetime
    Sleep    5s    
    Click Element    xpath=//input[@class='scheduleavcdate hasDatepicker']
    Sleep    5s        
    Select From List By Label    class=ui-datepicker-month    Feb
    Select From List By Label    class=ui-datepicker-year    2021
    Click Element    xpath=//td[contains(@class,' ui-datepicker-days-cell-over ')]/a    
    #Click Element    xpath=//table[@class='ui-datepicker-calendar']//tbody/tr/td/a[text()='${datetime.day}']        
    Click Element    class=scheduleavctime
    Click Element    xpath=//a[text()='10:00:00']      
    Click Element    xpath=(//label[@class='disableclick'])[2]    
    Click Element    xpath=//a[contains(@class,'sendcallrequest')]

To verify Confirm password and Re-confirm password should be displayed in masked
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Register')]    
    #confirm password
    Wait Until Element Is Visible    id=edit-pass-pass1    20s
    Click Element    //label[text()='Password']    
    Input Text    id=edit-pass-pass1    dummuPass
    #Re-confirm password
    Wait Until Element Is Visible    id=edit-pass-pass2    20s
    Click Element    //label[text()='Confirm Password']
    Input Text    id=edit-pass-pass2    dummyPass
    Capture Page Screenshot
    ${password_status}=    Get Element Attribute    id=edit-pass-pass1    type
    Run Keyword If    '${password_status}'=='password'    Log To Console    'Password is in masked format'    ELSE    Fail    'Password is not in masked format'
    ${password_status}=    Get Element Attribute    id=edit-pass-pass2    type
    Run Keyword If    '${password_status}'=='password'    Log To Console    'Confirm Password is in masked format'    ELSE    Fail    'Confirm Password is not in masked format'


To sponsor single child - SI flow - By specific section
    [Tags]    Sponsor a Child
    
    Jenkins browser launch
    Banner Alert
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(.,'Child Sponsorship')]
    Click Element    xpath=//div[@class='main-menu-inner']//a[contains(.,'Sponsor a Child')]
    
    Sleep    15s    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='modal-content-survey2']/span
    Run Keyword If    'True'=='${status}'    Click Element    xpath=//div[@class='modal-content-survey2']/span    ELSE    Log To Console    "Alert was not present"
    
    ${by_specific}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//span[contains(@class,'checked')]   
    Run Keyword If    '${by_specific}'=='True'    Log To Console    "By specific is selected by default"    ELSE    Fail    "By specific was not selected by default"
    
    ${most_needed}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='gbl_tabbed_menu']//li[contains(@class,'most-needed active')]
    Run Keyword If    '${most_needed}'=='True'    Log To Console    "Most Needed is selected by default"    ELSE    Fail    "Most Needed was not selected by default"
    
    ${Child_name}=    Get Text    xpath=(//div[@class='bySpecName'])[1]/p[1]    
    ${child_details}=    Get Text    xpath=(//div[@class='bySpecinfo'])[1]/p
    ${child_location}=    Get Text    xpath=(//div[@class='bySpecLocation'])[1]/p    
    
    Mouse Over    xpath=(//div[@class='bySpecContHolder'])[1]
    Click Element    xpath=(//input[@value='SPONSOR NOW'])[1]  
      
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='overall_banner_pledge'][1]/div[2]/h2[contains(text(),'${Child_name}')]
    Run Keyword If    'True'=='${status}'    Log To Console    "Child found in popup menus"    ELSE    Fail    "Child is mismatching in popup menu"
    
    ${Amount_button}=    Run Keyword And Return Status    Element Should Be Visible    xpath=(//div[@class='price save-malnourished-cart-sec current'])[1]
    Run Keyword If    'True'=='${Amount_button}'    Log To Console    "1 year Rs.9600 is selected by default"    ELSE    Fail    "1 year Rs.9600 is not selected by default"
    
    ${recurring_payments}=    Run Keyword And Return Status    Checkbox Should Be Selected    xpath=(//input[@id='ChkForSI'])[1]
    Run Keyword If    'True'=='${recurring_payments}'    Log To Console    "Please use my card details for recurring payments is selected by default"    ELSE    Fail    "Please use my card details for recurring payments is not selected by default"
    
    ${more_childrens}=    Get Element Attribute    xpath=(//input[@id='SIPopBlock_qty'])[1]    value
    Run Keyword If    '0'=='${more_childrens}'    Log To Console    "Sponsor More Children is 0 by default "    ELSE    Fail    "Sponsor More Children is not 0 by default"
   
    Click Element    xpath=(//button[contains(@class,'si_modal_btn')])[1]
    
    SI login
    Sleep    10s    
    FOR    ${element}    IN    @{SI_payment_list_text}
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='payment-main-content']/div[contains(text(),'${element}')]
        Run Keyword If    '${status}'!='True'    Fail    '${element} was not displayed"    ELSE    Log To Console    "${element} are displayed"    
    END


To Sponsor a child-SI flow - Any child section
    [Tags]    Sponsor a Child
    
    Jenkins browser launch
    Banner Alert
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(.,'Child Sponsorship')]
    Click Element    xpath=//div[@class='main-menu-inner']//a[contains(.,'Sponsor a Child')]
    
    Sleep    15s    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='modal-content-survey2']/span
    Run Keyword If    'True'=='${status}'    Click Element    xpath=//div[@class='modal-content-survey2']/span    ELSE    Log To Console    "Alert was not present"
    
    Click Element    xpath=//span[@class='checkmark']/a     
      
    ${child_name}=    Get Text    xpath=(//div[@class='overall_banner_pledge'])[3]/div[2]/h2    
    
    ${Amount_button}=    Run Keyword And Return Status    Element Should Be Visible    xpath=(//div[@class='price save-malnourished-cart-sec current'])[3]
    Run Keyword If    'True'=='${Amount_button}'    Log To Console    "1 year Rs.9600 is selected by default"    ELSE    Fail    "1 year Rs.9600 is not selected by default"
    
    ${recurring_payments}=    Run Keyword And Return Status    Checkbox Should Be Selected    xpath=(//input[@id='ChkForSI'])[3]
    Run Keyword If    'True'=='${recurring_payments}'    Log To Console    "Please use my card details for recurring payments is selected by default"    ELSE    Fail    "Please use my card details for recurring payments is not selected by default"
    
    ${more_childrens}=    Get Element Attribute    xpath=(//input[@id='SIPopBlock_qty'])[3]    value
    Run Keyword If    '0'=='${more_childrens}'    Log To Console    "Sponsor More Children is 0 by default "    ELSE    Fail    "Sponsor More Children is not 0 by default"
   
    Click Element    xpath=(//button[contains(@class,'si_modal_btn')])[3]
    
    SI login
    Sleep    10s    
    FOR    ${element}    IN    @{SI_payment_list_text}
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='payment-main-content']/div[contains(text(),'${element}')]
        Run Keyword If    '${status}'!='True'    Fail    '${element} was not displayed"    ELSE    Log To Console    "${element} are displayed"    
    END  


To verify increment/decrement functionality
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    ${get_viewcart_list_count}=    Get Element Count    xpath=.//tbody/tr/td[starts-with(@headers,'view-product-')]
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}        
    Log To Console    ${get_viewcart_list_count}    
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}        
    
    #One Time Donation
    Mouser hover ways to give campaign    Educate Children
    Sleep    5s
    Click Element    xpath=.//div[@class='item-image']//img
    #Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    Sleep    5s    
    Click Element    id=ChkForSI
    Click Element    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Input Text    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    ${edu_child_amt}
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    Click Element    xpath=//a[@class='view_cart']
    ${add_button}=    Run Keyword And Return Status    Element Should Not Be Visible    class=save-plus        
    Run Keyword If    'True'=='${add_button}'    Log To Console    "Plus button is not available for one time donation"    ELSE    Fail    "Plus button is available for one time donation"
    ${reduce_button}=    Run Keyword And Return Status    Element Should Not Be Visible    class=save-plus        
    Run Keyword If    'True'=='${reduce_button}'    Log To Console    "Reduce button is not available for one time donation"    ELSE    Fail    "Reduce button is available for one time donation"            

    #Recuring Payment
    Sleep    10s    
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    ${get_viewcart_list_count}=    Get Element Count    xpath=.//tbody/tr/td[starts-with(@headers,'view-product-')]
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}        
    Log To Console    ${get_viewcart_list_count}    
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}
    Mouser hover ways to give campaign    Educate Children
    Sleep    5s
    Click Element    xpath=.//div[@class='item-image']//img
    Sleep    15s
    Wait Until Element Is Visible    xpath=(//div[@class='price save-malnourished-cart-sec'])[1]/label    15s    
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[1]/label
    Click Element    id=ChkForSI
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    Click Element    xpath=//a[@class='view_cart']    
    Cart addition check
    Cart reduce check

To Verify Postal Code Field should Auto populate
    [Tags]   Registration Page

    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Register')]     
    Sleep    10s          
    Scroll Element Into View    class=singUpRegister    
      
    Input Text    xpath=//input[contains(@id,'edit-field-pin-code')]    600123  
    
    Sleep    10s        

    ${city}=    Get Element Attribute    id=edit-field-city-0-value    value
    Log To Console    City ${city} is auto populated    
    ${state}=    Get Element Attribute    id=edit-field-regstate-0-value    value
    Log To Console    state ${state} is auto populated
    ${country}=    Get Element Attribute    id=edit-field-country    value
    Log To Console    Country ${country} is auto populated

To verify schedule a visit
    [Tags]    MyChild Page
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Child')]
    Click Element    xpath=(//div[@class='child_title'])[1]
    
    ${schedule_call}=    Get Text    xpath=//div[contains(@class,'visit-schedule')]/a/p    
    Run Keyword If    'Schedule a Visit'=='${schedule_call}'    Log To Console    "Schedule a Visit option is enabled"    ELSE    Fail    "Schedule a Visit options is not enabled"
    Click Element    xpath=//div[contains(@class,'visit-schedule')]/a/p
    ${CurrentDate}=    Get Current Date    result_format=%Y-%m-%d
    ${datetime}=    Convert Date    ${CurrentDate}    datetime
    
    Sleep    10s    
    Click Element    xpath=//input[@class='schedulevisitdate hasDatepicker']    
    Select From List By Label    class=ui-datepicker-month    Feb
    Select From List By Label    class=ui-datepicker-year    2021
    Click Element    xpath=//td[contains(@class,' ui-datepicker-days-cell-over ')]/a
    #Click Element    xpath=//table[@class='ui-datepicker-calendar']//tbody/tr/td/a[text()='${datetime.day+7}']        
    Click Element    xpath=//input[@class='schedulevisittime']
    Click Element    xpath=//a[text()='10:00:00']        
    Click Element    xpath=(//label[@class='disableclick'])[1]    
    Click Element    xpath=//a[contains(@class,'sendrequest')]

To verify write a message
    [Tags]    MyChild Page
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Child')]
    Click Element    xpath=(//div[@class='child_title'])[1]
    Click Element    xpath=(//div[@class='child_name heartbeat'])[1]
    
    @{child_details}=    Get WebElements    xpath=//ul[@class='tab-mnu']/li/p
    FOR    ${element}    IN    @{child_details}
        ${text}=    Get Text    ${element}
        Log To Console    Details enabled for child:    ${text}    
    END
    
    ${write_msg}=    Get Text    xpath=//div[contains(@class,'message-sec')]/p    
    Run Keyword If    'Write a Message'=='${write_msg}'    Log To Console    "Write a message option is enabled"    ELSE    Fail    "Write a message options is not enabled"
    
    ${child_name}=    Get Text    xpath=//div[@id='edit-messageheader']/div[@class='childsname']
    ${Child_image}=    Get Element Attribute    xpath=//div[@id='edit-messageheader']/div[@class='childspic']/img    src

    Click Element    xpath=//div[contains(@class,'message-sec')]/p    
    
    Click Element    id=edit-user-message    
    Input Text    id=edit-user-message    Test message for child
    Sleep    5s    
    ${child_msg}=    Get Text    id=user_message
    Run Keyword If    'Test message for child'=='${child_msg}'    Log To Console    "Message populate same as like written'    ELSE    Fail    "Message was not same as like written"

To verify offline - Cheque & DD acknowledgement page
    [Tags]    Payment Acknowlodgement for Indian Passport Holder
        
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Sleep    30s    
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    Cart campaign check and delete
    Mouser hover ways to give campaign    Educate Children     
    ${camp_name}    ${camp_val}    Checkout flow campaign
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${Camp_val}           
    View cart proceed button 
    Sleep    10s   
    Click Element    xpath=//input[@id='edit-payment-information-payment-method-offline-payment']    
    Scroll Element Into View    class=upihead
    Sleep    10        
    Click Element    xpath=//label[@class='off-container' and contains(text(),'Cheque & DD')]/span
    Sleep    10s 
    Click Element    id=off-edit-actions-next    
    CCavenue payment - cart verification    ${camp_name}    ${camp_val}    ${cart_quanity}

To verify offline - UPI acknowledgement page
    [Tags]    Payment Acknowlodgement for Indian Passport Holder
        
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Sleep    30s    
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    Cart campaign check and delete
    Mouser hover ways to give campaign    Educate Children     
    ${camp_name}    ${camp_val}    Checkout flow campaign
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${Camp_val}           
    View cart proceed button 
    Sleep    10s   
    Click Element    xpath=//input[@id='edit-payment-information-payment-method-offline-payment']    
    Scroll Element Into View    class=upihead
    Sleep    10        
    Click Element    xpath=//label[@class='off-container' and contains(text(),'UPI')]/span
    Sleep    10s 
    Click Element    id=off-edit-actions-next    
    CCavenue payment - cart verification    ${camp_name}    ${camp_val}    ${cart_quanity}

To verify offline - Paytm acknowledgement page
    [Tags]    Payment Acknowlodgement for Indian Passport Holder
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Sleep    30s    
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    Cart campaign check and delete
    Mouser hover ways to give campaign    Educate Children     
    ${camp_name}    ${camp_val}    Checkout flow campaign
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${Camp_val}           
    View cart proceed button 
    Sleep    10s   
    Click Element    xpath=//input[@id='edit-payment-information-payment-method-offline-payment']    
    Scroll Element Into View    class=upihead
    Sleep    10        
    Click Element    xpath=//label[@class='off-container' and contains(text(),'Paytm')]/span
    Sleep    10s 
    Click Element    id=off-edit-actions-next    
    CCavenue payment - cart verification    ${camp_name}    ${camp_val}    ${cart_quanity}

To verify offline - Bank transfer acknowledgement page
    [Tags]    Payment Acknowlodgement for Indian Passport Holder
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Sleep    30s    
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    Cart campaign check and delete
    Mouser hover ways to give campaign    Educate Children     
    ${camp_name}    ${camp_val}    Checkout flow campaign
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${Camp_val}           
    View cart proceed button 
    Sleep    10s   
    Click Element    xpath=//input[@id='edit-payment-information-payment-method-offline-payment']    
    Scroll Element Into View    class=upihead
    Sleep    10        
    Click Element    xpath=//label[@class='off-container' and contains(text(),'Bank Transfer')]/span
    Sleep    10s 
    Click Element    id=off-edit-actions-next    
    CCavenue payment - cart verification    ${camp_name}    ${camp_val}    ${cart_quanity}
    
To Verify confirm password Field minimum length registration page
    [Tags]    Registration Page
    
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Register')]    
       
    #confirm password
    Wait Until Element Is Visible    id=edit-pass-pass1    20s
    Click Element    //label[@for='edit-pass-pass1']    
    Input Text    id=edit-pass-pass1    password@123
    
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    id=edit-pass-pass1-error        
    Run Keyword If    '${status}'=='True'    Log To Console    Page doesnt throughs error message for password minimum length    ELSE    Fail    Page throughs error message for password minimum length
        
    Clear Element Text    id=edit-pass-pass1
    Click Element    //label[@for='edit-pass-pass1']
    Input Text    id=edit-pass-pass1    pas
    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-pass-pass1-error        
    Run Keyword If    '${status}'=='True'    Log To Console    Page throughs error message for password minimum length    ELSE    Fail    Page doesnt throughs error message for password minimum length

To Verify User should submit the form without the Captcha
    [Tags]  Contacts Us page
    
    Jenkins browser launch
    Navigation banner close   
    Mouse Over    xpath=//div[@class='main-menu-inner']//*[contains(text(),'About Us')]
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Contact Us')] 
    Sleep    15s    
    Scroll Element Into View    id=edit-actions-submit
    Input Text    id=edit-name-    testname
    Input Text    id=edit-email-    test@test.com
    Input Text    id=edit-contact-    9999999999
    Click Element    id=edit-query-type-styled
    Click Element    xpath=//a[text()='Sponsorship']    
    Input Text    id=edit-message    Dummy message to test Text box1$        
    Click Element    id=edit-actions-submit 
    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//strong[@id='g-recaptcha-response-error']        
    Run Keyword If    '${status}'=='True'    Log    "Recaptcha error message appeared"    ELSE    Fail    "Recaptcha error message doesnt appeared"

To Verify User should submit the form without the Captcha - End Child sexual abuse Page 
    Jenkins browser launch
    Navigation banner close   
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login    
    Mouse Over    xpath=//li/span[contains(.,'Ways to Give')]
    Click Element    xpath=//li/a[contains(.,'End Child Sexual Abuse')]
    Sleep    15s    
    Scroll Element Into View    id=edit-actions-submit
    Input Text    id=edit-name-    testname
    Input Text    id=edit-email-    test@test.com
    Input Text    id=edit-contact-    9999999999
    Click Element    id=edit-query-type-styled
    Click Element    xpath=//a[text()='Sponsorship']    
    Input Text    id=edit-message    Dummy message to test Text box1$        
    Click Element    id=edit-actions-submit 
    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//strong[@id='g-recaptcha-response-error']        
    Run Keyword If    '${status}'=='True'    Log    "Recaptcha error message appeared"    ELSE    Fail    "Recaptcha error message doesnt appeared"

To Verify Special Character should not accept except Email Address, Confirm pass
    [Tags]    Registration Page
    
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Register')]    
       
    #confirm password
    Wait Until Element Is Visible    id=edit-pass-pass1    20s
    Click Element    //label[@for='edit-pass-pass1']    
    Input Text    id=edit-pass-pass1    newpassword
    
    #Re-confirm
    Wait Until Element Is Visible    id=edit-pass-pass2    20s
    Click Element    //label[@for='edit-pass-pass2']
    Input Text    id=edit-pass-pass2    newpassword
    
    ${password1}=    Get Element Attribute    id=edit-pass-pass1    value
    ${password2}=    Get Element Attribute    id=edit-pass-pass2    value    
    Sleep    5s    
    
    Run Keyword If    '${password1}'=='${password2}'    Element Should Be Visible    xpath=//p[@class='wrong right']    ELSE    Fail    Password macthed icon doesnt show
    
    #confirm password
    Clear Element Text    id=edit-pass-pass1
    Click Element    //label[@for='edit-pass-pass1']    
    Input Text    id=edit-pass-pass1    newpassword
    
    #Re-confirm
    Clear Element Text    id=edit-pass-pass2
    Click Element    //label[@for='edit-pass-pass2']
    Input Text    id=edit-pass-pass2    passwordnew 
    
    ${password1Wrong}=    Get Element Attribute    id=edit-pass-pass1    value
    ${password2Wrong}=    Get Element Attribute    id=edit-pass-pass2    value
    Sleep    5s   
    
    Run Keyword If    '${password1Wrong}'!='${password2Wrong}'    Element Should Be Visible    xpath=//p[@class='wrong']    ELSE    Fail    Password mismatch icon doesnt show
    
To verify child project meter
    [Tags]    MyChild Page
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Child')]
    Sleep    20s    
    Click Element    xpath=(//div[@class='child_name heartbeat'])[1]
    @{child_details}=    Get WebElements    xpath=//ul[@class='tab-mnu']/li/p
    FOR    ${element}    IN    @{child_details}
        ${text}=    Get Text    ${element}
        Log To Console    Details enabled for child:    ${text}    
    END    
    Click Element    xpath=//p[contains(text(),'PROJECT METER')]
    ${location}=    Get Text    xpath=//div[@class='proj_id']
    ${from_date}=    Get Text    xpath=//div[contains(@class,'projmeter-date')]/p[2]    
    ${to_date}=    Get Text    xpath=//div[contains(@class,'projmeter-unit')]/p[2]    
    Log To Console    Location is: ${location}, From date is: ${from_date} and To date is: ${to_date}

To Verify User should submit the form Using Invalid Email ID
    [Tags]    Contacts Us page

    Jenkins browser launch
    Navigation banner close
    Mouse Over    xpath=//div[@class='main-menu-inner']//*[contains(text(),'About Us')]
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Contact Us')] 
    Sleep    15s    
    FOR    ${element}    IN    @{email_validation}
        Clear Element Text    id=edit-email-
        Input Text    id=edit-email-    ${element}
        Click Element    id=edit-actions-submit
        Sleep    5s    
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-email--error    
        Run Keyword If    '${status}'!='True'    Fail    Alert message was not displayed
    END    
    ${title}=    Get Title   
    Run Keyword If    'Contact Us | World vision'!='${title}'    Fail    'Form was submitted'    ELSE    Log To Console    form was not submitted

To Verify User should submit the form Using Invalid Email ID - End Child sexual abuse Page
    [Tags]    End Child Sexual Abuse campaign
    
    Jenkins browser launch
    Navigation banner close   
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login    
    Mouse Over    xpath=//li/span[contains(.,'Ways to Give')]
    Click Element    xpath=//li/a[contains(.,'End Child Sexual Abuse')] 
    Sleep    15s    
    FOR    ${element}    IN    @{email_validation}
        Clear Element Text    id=edit-email-
        Input Text    id=edit-email-    ${element}
        Click Element    id=edit-actions-submit
        Sleep    5s    
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-email--error    
        Run Keyword If    '${status}'!='True'    Fail    Alert message was not displayed
    END    
    ${title}=    Get Text    xpath=//div[contains(@class,'gbl_banner_content')]//h2
    Run Keyword If    'End Child Sexual Abuse'!='${title}'    Fail    'Form was submitted'    ELSE    Log To Console    form was not submitted    
    

To sposor a Emergency Relief Campaign using Checkout flow
    [Tags]    Emergency Relief Campaign
    
    Jenkins browser launch
    Navigation banner close

    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    Emergency Relief
    Sleep    5s
    @{emergency_relief}=    Get WebElements    xpath=//h5[@class='campaign-title']/a
    FOR    ${element}    IN    @{emergency_relief}
        ${text}=    Get Text    ${element}
        Log To Console    Current Emergencey reliefs are: ${text}        
    END 
    
    Wait Until Element Is Visible    xpath=//a[text()='Kerala Floods']/ancestor::h5/following-sibling::p[2]/a    40s
    Click Element    xpath=//a[text()='Kerala Floods']/ancestor::h5/following-sibling::p[2]/a
        
    Wait Until Element Is Visible    xpath=.//div[@class='item-image']//img    40s
    Click Element    xpath=.//div[@class='item-image']//img
    
    ${campaign_name}    ${campaign_amt}    Kerala flood campaign    1
    ${campaign_name2}    ${campaign_amt2}    Kerala flood campaign    2        
    
    Add to cart functionality
    Clear and input text    1000
    
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']/input   
    
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"    

    Click Element    xpath=//a[@class='view_cart'] 

    ${cart_quanity}    check in view cart page - dynamic    ${campaign_name}    ${campaign_amt}
    ${cart_quanity2}    check in view cart page - dynamic    ${campaign_name2}    ${campaign_amt2}    
    ${cart_quanity3}    check in view cart page - dynamic    Donation    1000
    
    ${total_calc}=    Evaluate    ${campaign_amt}+${campaign_amt2}+1000

    ${total_cart_value}    Total cart value
    
    Should Be Equal As Integers    ${total_calc}    ${total_cart_value}    

    View cart proceed button
    Login
    CCavenue payment success flow
    
    CCavenue payment - cart verification - dynamic    ${campaign_name}    ${campaign_amt}    ${cart_quanity}
    CCavenue payment - cart verification - dynamic    ${campaign_name2}    ${campaign_amt2}    ${cart_quanity2}
    CCavenue payment - cart verification - dynamic    Donation    1000    ${cart_quanity3}

To verify Events functionality
    [Tags]    Events Page
    
    Jenkins browser launch
    Navigation banner close
    Mouse Over    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Get Involved')]
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Events')]
    Wait Until Element Is Visible    id=recent-evnt    30s
    ${status}=    Get Element Attribute    id=recent-evnt    class
    Run Keyword If    '${status}'!='active'    Fail    Recent event was not selected by default
    
    ${event_count}=    Get Element Count    xpath=//div[@class='first_blog_title checking']
    FOR    ${element}    IN RANGE    1    ${event_count}+1
        ${events}=    Get Text    xpath=(//div[@class='first_blog_title checking'])[${element}]
        ${day}=    Get Text    xpath=(//span[@class='blog_dates'])[${element}]
        ${month}=    Get Text    xpath=(//span[@class='first_blog_month'])[${element}]
        ${year}=    Get Text    xpath=(//span[contains(@class,'first_blog_year')])[${element}]              
        Log To Console    Past and current event name is: ${events} and its date is ${day}/${month}/${year}    
    END    
    
    #Run Keyword If    ${year}>=2021 and ${month}<='current-month' and ${day}<'current day'
    Click Element    id=upcmg-evnt
    Sleep    10s        
    ${event_count}=    Get Element Count    xpath=//div[@class='first_blog_title checking']
    FOR    ${element}    IN RANGE    1    ${event_count}+1
        ${events}=    Get Text    xpath=(//div[@class='first_blog_title checking'])[${element}]
        ${day}=    Get Text    xpath=(//span[@class='blog_dates'])[${element}]
        ${month}=    Get Text    xpath=(//span[@class='first_blog_month'])[${element}]
        ${year}=    Get Text    xpath=(//span[contains(@class,'first_blog_year')])[${element}]              
        Log To Console    Future event name is: ${events} and will be held on ${day}/${month}/${year}    
    END

To check whether the filters work properly in Blog page
    [Tags]    Media
    
    Jenkins browser launch
    Navigation banner close    
    Event Page menu check    Blog
    Event Submenu Check    Blog
    Scroll Element Into View    xpath=//input[contains(@id,'edit-submit-press-releases')]
    Select From List By Label    id=edit-field-month-target-id    ${month_input}
    Select From List By Label    id=edit-field-releases-year-target-id    ${year_input}    
    Click Element    xpath=//input[contains(@id,'edit-submit-press-releases')]
    Sleep    40s
    ${month_sort}=    Get Substring    ${month_input}    0    3
    #Element Should Be Visible    xpath=//div[@class='media-press-page pressres']    
    ${month}=    Get Text    xpath=//div[@class='save-child-image_container']//span[@class='first_blog_month']
    Run Keyword If    '${month_sort}'!='${month}'    Fail    Month mismatch or No data found
    ${year}=    Get Text    xpath=//div[@class='save-child-image_container']//span[@class='first_blog_year']
    Run Keyword If    '2020'!='${year}'    Fail    Month mismatch or No data found

To check with the filters in news articles page
    [Tags]    Media
    
    Jenkins browser launch
    Navigation banner close    
    Event Page menu check    News Articles
    Event Submenu Check    News Articles
    Event page filter    ${month_input}    2019    ${language_input}            
    Sleep    40s    
    ${month_sort}=    Get Substring    ${month_input}    0    3            
    ${month}=    Get Text    xpath=//div[@class='media-press-page']//span[@class='media-mont']
    Run Keyword If    '${month_sort}'!='${month}'    Fail    Month mismatch or No data found
    ${year}=    Get Text    xpath=//div[@class='media-press-page']//span[@class='media-year']
    Run Keyword If    '2019'!='${year}'    Fail    Month mismatch or No data found

To check with the filters in press release page
    [Tags]    Media
    
    Jenkins browser launch
    Navigation banner close    
    Event Page menu check    Press Releases
    Event Submenu Check    Press Releases
    Event page filter    ${month_input}    ${year_input}    ${language_input}
    Sleep    40s   
    Event page filter verification    ${month_input}    ${year_input}

To Verify User should submit the form with Mandatory data - Hungerfree
    [Tags]    Hunger Free Campaign
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Mouser hover ways to give campaign    Hungerfree 
    Sleep    30s    
    Scroll Element Into View    id=edit-actions-submit
    
    Input Text    id=edit-name    testname
    Click Element    id=edit-date-of-birth    
    Select From List By Label    class=ui-datepicker-year    1989
    Select From List By Label    class=ui-datepicker-month    May
    Click Element    xpath=//a[text()='11']
    #Click Element    id=edit-state    
    Select From List By Index    id=edit-state    4
    Input Text    id=edit-email    test@testa.com
    Input Text    id=edit-mobile-number    9999999997

    Click Element    id=edit-actions-submit        

    ${message}=    Get Text    xpath=//div[@class='thanks_description']/h1
    Run Keyword If    '${message}'=='Thank You'    Log To Console    Form submitted successfully    ELSE    Fail    Form was not submitted   

To verify uncheck and check allow auto debit It should lead to SI flow
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}            
    Mouser hover ways to give campaign    Childhood Rescue
    Sleep    10s
    Click Element    xpath=.//div[@class='item-image']//img
    Sleep    10s    
    Click Element    id=ChkForSI
    Add to cart text change
    Click Element    id=ChkForSI
    Proceed to autopay text change        
    ${camp_name}=    Get Text    xpath=//div[@class='inner_banner_pledge_content']/h2/div
    ${educate_chld_camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    ${label_val}=    Get Text    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    ${final_val}=    Get Substring    ${label_val}    9    16
    Log To Console    Final val is:${final_val}
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label       
    Click Element    xpath=//button[@class='btn btn-primary si_modal_btn']
    SI login
    ${SI_payment_list}=    Get Element Count    xpath=.//div[@class='payment-main-content']/div
    Run Keyword If    3!=${SI_payment_list}    Fail    "SI Flow payment gateway list mismatch"
    FOR    ${SI_payment_txt}    IN    @{SI_payment_list_text}
        ${SI_payment_txt_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@class='payment-main-content']/div[contains(.,'${SI_payment_txt}')]
        Run Keyword If    'True'!='${SI_payment_txt_chck}'    Fail    "SI flow payment gateway ${SI_payment_txt} text are mismatch"
    END

To Verify User should submit form with Valid Sponsor ID
    [Tags]    Contacts Us page
    Jenkins browser launch
    Navigation banner close
    Mouse Over    xpath=//div[@class='main-menu-inner']//*[contains(text(),'About Us')]
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Contact Us')] 
    Sleep    10s    
    Click Element    xpath=//label[@for='edit-are-you-a-partner-y']    
    Input Text    id=edit-partner-id    asldkalsdglas
    Click Element    id=edit-actions-submit
    Sleep    5s    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-partner-id-error    
    Run Keyword If    '${status}'!='True'    Fail    Alert message was not displayed
    ${title}=    Get Title   
    Run Keyword If    'Contact Us | World vision'!='${title}'    Fail    'Form was submitted'    ELSE    Log To Console    form was not submitte


To Verify User should submit form with Valid Sponsor ID - End Child sexual abuse Page  
    [Tags]    End Child Sexual Abuse campaign

    Jenkins browser launch
    Navigation banner close
    Mouse Over    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Ways to Give')]
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'End Child Sexual Abuse')] 
    Sleep    10s    
    Click Element    xpath=//label[@for='edit-are-you-a-partner-y']    
    Input Text    id=edit-partner-id    asldkalsdglas
    Click Element    id=edit-actions-submit
    Sleep    5s    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-partner-id-error    
    Run Keyword If    '${status}'!='True'    Fail    Alert message was not displayed    
    ${title}=    Get Text    xpath=//div[contains(@class,'gbl_banner_content')]//h2
    Run Keyword If    'End Child Sexual Abuse'!='${title}'    Fail    'Form was submitted'    ELSE    Log To Console    form was not submitted    
    
To Verify welcome banner should appear for Donor on Second login
    [Tags]    Myworld Page    

    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login    
    Wait Until Element Is Visible    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[@aria-label='Go to slide 2']    60s    
    Click Element    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[@aria-label='Go to slide 1']    
    ${get_banner_text}=    Get Text    xpath=(//div[@class='banner-content'])[2]/h2
    ${get_banner_text}=    Remove String Using Regexp    ${get_banner_text}    \,.*$
    Run Keyword If    'Welcome Back'!='${get_banner_text}'    Fail    Welcome User message wasnt displayed

To Verify Upcomming Events Banner Functionallity appear by selecting loaction
    [Tags]    Myworld Page    

    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login    
    Wait Until Element Is Visible    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[@aria-label='Go to slide 1']    60s    
    Click Element    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[@aria-label='Go to slide 1']
    Click Element    xpath=//a[text()='Locate Event']    
    
    ${location}=    Get Text    xpath=(//div[@class='evt_ltn_stry'])[2]
    Run Keyword If    'Chennai'!='${location}    Fail    Event was not showing based on the location

To verify payment success for ccavenue payment gateway - For other passport holder
    [Tags]    Payment acknowledgment for other passport holder
        
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login - Other passport user    
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    Cart campaign check and delete            
    #Select Hunger free campaign
    Mouse Over    xpath=//li/span[contains(text(),'Ways to Give')]
    Click Element    xpath=//li/a[contains(.,'Educate Children')]
    Sleep    10s
    ${camp_name}    ${camp_amt}    Checkout flow campaign
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${camp_amt}
    View cart proceed button
    
    ${checkout_payment_list}=    Get Element Count    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div
    Run Keyword If    3!=${checkout_payment_list}    Fail    "Checkout flow Other passport holder payment list are mismatch"
    FOR    ${bank_txt}    IN    @{checkout_payment_list_text}
        ${checkout_banklist_name_check}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'${bank_txt}')]
        Run Keyword If    'True'!='${checkout_banklist_name_check}'    Fail    'Checkout Flow Other passport holder Payment Gateway ${bank_txt} text is mismatch'    ELSE    Log To Console    Payment gateway lists are matching    
    END
    ${camp_amt}=    Convert to price    ${camp_amt}
    CCavenue payment success flow
    CCavenue payment - cart verification - dynamic    ${camp_name}    ${camp_amt}    ${cart_quanity}

To verify payment failure for cc avenue payment gateway - For other passport holder
    [Tags]    Payment acknowledgment for other passport holder
        
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login - Other passport user    
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    Cart campaign check and delete            
    #Select Hunger free campaign
    Mouse Over    xpath=//li/span[contains(text(),'Ways to Give')]
    Click Element    xpath=//li/a[contains(.,'Educate Children')]
    Sleep    10s
    ${camp_name}    ${camp_amt}    Checkout flow campaign
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${camp_amt}
    View cart proceed button    
    ${checkout_payment_list}=    Get Element Count    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div
    Run Keyword If    3!=${checkout_payment_list}    Fail    "Checkout flow Other passport holder payment list are mismatch"
    FOR    ${bank_txt}    IN    @{checkout_payment_list_text}
        ${checkout_banklist_name_check}=    Run Keyword And Return Status    Element Should Be Visible    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'${bank_txt}')]
        Run Keyword If    'True'!='${checkout_banklist_name_check}'    Fail    'Checkout Flow Other passport holder Payment Gateway ${bank_txt} text is mismatch'    ELSE    Log To Console    Payment gateway lists are matching    
    END
    ${camp_amt}=    Convert to price    ${camp_amt}
    CCAvenue payment failure flow
    CCavenue payment - failure cart verification    ${camp_name}    ${camp_amt}    ${cart_quanity}


To Sponsor 3 child - Direct flow – byspecific
    [Tags]    Sponsor a Child
    
    Jenkins browser launch
    Banner Alert
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Cart campaign check and delete
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(.,'Explore More')]
    Click Element    xpath=//div[@class='main-menu-inner']//a[contains(.,'Sponsor a Child')]
    
    ${by_specific}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//span[contains(@class,'checked')]   
    Run Keyword If    '${by_specific}'=='True'    Log To Console    "By specific is selected by default"    ELSE    Fail    "By specific was not selected by default"
    
    ${most_needed}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='gbl_tabbed_menu']//li[contains(@class,'most-needed active')]
    Run Keyword If    '${most_needed}'=='True'    Log To Console    "Most Needed is selected by default"    ELSE    Fail    "Most Needed was not selected by default"
    
    ${Child_name}=    Get Text    xpath=(//div[@class='bySpecName'])[1]/p[1]    
    ${child_details}=    Get Text    xpath=(//div[@class='bySpecinfo'])[1]/p
    ${child_location}=    Get Text    xpath=(//div[@class='bySpecLocation'])[1]/p    
    
    Mouse Over    xpath=(//div[@class='bySpecContHolder'])[1]
    Click Element    xpath=(//input[@value='SPONSOR NOW'])[1]
    
    ${child_status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='overall_banner_pledge'][1]/div[2]/h2[contains(text(),'${Child_name}')]
    Run Keyword If    'True'=='${child_status}'    Log To Console    "Child found in popup menus"    ELSE    Fail    "Child is mismatching in popup menu"
    
    ${recurring_payments}=    Run Keyword And Return Status    Checkbox Should Be Selected    xpath=(//input[@id='ChkForSI'])[1]
    Run Keyword If    'True'=='${recurring_payments}'    Log To Console    "Please use my card details for recurring payments is selected by default"    ELSE    Fail    "Please use my card details for recurring payments is not selected by default"
    
    ${more_childrens}=    Get Element Attribute    xpath=(//input[@id='SIPopBlock_qty'])[1]    value
    Run Keyword If    '0'=='${more_childrens}'    Log To Console    "Sponsor More Children is 0 by default "    ELSE    Fail    "Sponsor More Children is not 0 by default"
   
    #select child amount
    ${camp_amt}=    Get Text    xpath=(//label[contains(text(),'1 Month')])[1]
    ${camp_amt}=    Convert to price    ${camp_amt}    

    Click Element    xpath=(//label[contains(text(),'1 Month')])[1]
    Click Element    id=ChkForSI    
    Add to cart text change    
    #sponsor child count
    FOR    ${element}    IN RANGE    0    3
        Click Element    xpath=(//div[@id='sip_increase'])[1]    
    END    
    ${child_count}=    Get Element Attribute    xpath=(//input[@id='SIPopBlock_qty'])[1]    value
    Run Keyword If    '2'!='${child_count}'    Fail    Sponsored Child count doesnt macth
    
    #Add to cart buttton
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']/input
    
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"    

    Click Element    xpath=//div[@class='cart-buttons']/a[2]    
    
    ${cart_quanity}=    check in view cart page - Checkout flow    ${Child_name}    ${camp_amt}    
    View cart proceed button
    CCavenue payment success flow
    CCavenue payment - cart verification    ${Child_name}    ${camp_amt}    ${cart_quanity}
    

To Sponsor 5 child - SI flow - byspecific
    [Tags]    Sponsor a Child
    
    Jenkins browser launch
    Banner Alert        
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Cart campaign check and delete
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(.,'Child Sponsorship')]
    Click Element    xpath=//div[@class='main-menu-inner']//a[contains(.,'Sponsor a Child')]
    
    ${by_specific}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//span[contains(@class,'checked')]   
    Run Keyword If    '${by_specific}'=='True'    Log To Console    "By specific is selected by default"    ELSE    Fail    "By specific was not selected by default"
    
    ${most_needed}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='gbl_tabbed_menu']//li[contains(@class,'most-needed active')]
    Run Keyword If    '${most_needed}'=='True'    Log To Console    "Most Needed is selected by default"    ELSE    Fail    "Most Needed was not selected by default"
    
    ${Child_name}=    Get Text    xpath=(//div[@class='bySpecName'])[1]/p[1]    
    ${child_details}=    Get Text    xpath=(//div[@class='bySpecinfo'])[1]/p
    ${child_location}=    Get Text    xpath=(//div[@class='bySpecLocation'])[1]/p    
    
    Mouse Over    xpath=(//div[@class='bySpecContHolder'])[1]
    Click Element    xpath=(//input[@value='SPONSOR NOW'])[1]
    
    ${child_status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='overall_banner_pledge'][1]/div[2]/h2[contains(text(),'${Child_name}')]
    Run Keyword If    'True'=='${child_status}'    Log To Console    "Child found in popup menus"    ELSE    Fail    "Child is mismatching in popup menu"
    
    ${recurring_payments}=    Run Keyword And Return Status    Checkbox Should Be Selected    xpath=(//input[@id='ChkForSI'])[1]
    Run Keyword If    'True'=='${recurring_payments}'    Log To Console    "Please use my card details for recurring payments is selected by default"    ELSE    Fail    "Please use my card details for recurring payments is not selected by default"
    
    ${more_childrens}=    Get Element Attribute    xpath=(//input[@id='SIPopBlock_qty'])[1]    value
    Run Keyword If    '0'=='${more_childrens}'    Log To Console    "Sponsor More Children is 0 by default "    ELSE    Fail    "Sponsor More Children is not 0 by default"
   
    #select child amount
    ${camp_amt}=    Get Text    xpath=(//label[contains(text(),'3 Month')])[1]
    ${camp_amt}=    Convert to price    ${camp_amt}    
    Click Element    xpath=(//label[contains(text(),'3 Month')])[1]
    #Click Element    id=ChkForSI    
    Add to cart text change    
    #sponsor child count
    FOR    ${element}    IN RANGE    0    5
        Click Element    xpath=(//div[@id='sip_increase'])[1]    
    END    
    ${child_count}=    Get Element Attribute    xpath=(//input[@id='SIPopBlock_qty'])[1]    value
    Run Keyword If    '4'!='${child_count}'    Fail    Sponsored Child count doesnt macth
    
    #Add to cart buttton
    Click Element    xpath=(//button[contains(@class,'si_modal_btn')])[1]
    #Click Element    xpath=//div[@class='kl_flood_sub_or_sec']/input
    
    SI login
    Sleep    10s    
    FOR    ${element}    IN    @{SI_payment_list_text}
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='payment-main-content']/div[contains(text(),'${element}')]
        Run Keyword If    '${status}'!='True'    Fail    '${element} was not displayed"    ELSE    Log To Console    "${element} are displayed"    
    END

To check whether filters work properly in magazine page
    [Tags]    Media
    
    Jenkins browser launch
    Navigation banner close    
    Event Page menu check    Publication

    Mouse Over    xpath=//h4[text()='Magazines']  
    Click Element    xpath=//h4[text()='Magazines']/parent::div//a[text()='View more']    
    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//h1[text()='Jeevan Sparsh']        
    Run Keyword If    'True'!='${status}'    Fail    Jeevan Sparsh page doesnt load    ELSE    Log To Console    Jeevan Sparsh page loaded

    Select From List By Label    id=edit-tid-1    Issue 41
    Click Element    id=edit-submit-jeevan-sparsh-newsletter
    
    @{issues41}=    Get WebElements    xpath=//div[contains(@class,'Txt_ctnr')]/h3
    FOR    ${element}    IN    @{issues41}
        ${text}=    Get Text    ${element}
        Log To Console    issue 41: ${text}
    END

Donate single campaign and to verify in make payment page
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    Cart campaign check and delete
    Mouser hover ways to give campaign     Hungerfree 
    Sleep    10s
    Click Element    xpath=.//div[@class='add-to-cart-section']
    ${amount_default}=    Get Element Attribute    xpath=//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    value
    Run Keyword If    '${amount_default}'!='1000'    Fail    Default amount 1000Rs was not present in hungerfree campaign page
    Click Element    class=closebtn    
    ${camp_name}    ${Camp_val}    one time campaign - Hunger Free campaign       
    ${cart_quanity}    check in view cart page - One time donation flow    ${camp_name}    ${Camp_val}
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${camp_name}    ${Camp_val}    ${cart_quanity}    
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Campaign')] 
    Why do you want to quit - PopUp
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Campaign')]
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='user_campheading']/a[contains(text(),'${camp_name}')]    
    Run Keyword If    'True'!='${status}'    Fail    Campaign not found    ELSE    Log    Campaign found in MyCampaign page        
    Click Element    xpath=//li[@class='post_lgn']/a  
    Wait Until Element Is Visible    xpath=//li[@id='oneTime-shwhde']    60s  
    Click Element    xpath=//li[@id='oneTime-shwhde']
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='cld-nme']/p[contains(text(),'${camp_name}')]
    Run Keyword If    '${status}'!='True'    Fail    Selected campaign was not added in mydonation bucket
    
sponsor single child and to verify in make payment page - My child
    [Tags]    Make Payment Page
    
    Jenkins browser launch
    Banner Alert    
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Cart campaign check and delete
    Mouse Over    xpath=//div[@class='main-menu-inner']//li/span[contains(.,'Child Sponsorship')]
    Click Element    xpath=//div[@class='main-menu-inner']//a[contains(.,'Sponsor a Child')]
    
    ${by_specific}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//span[contains(@class,'checked')]   
    Run Keyword If    '${by_specific}'=='True'    Log To Console    "By specific is selected by default"    ELSE    Fail    "By specific was not selected by default"
    
    ${most_needed}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='gbl_tabbed_menu']//li[contains(@class,'most-needed active')]
    Run Keyword If    '${most_needed}'=='True'    Log To Console    "Most Needed is selected by default"    ELSE    Fail    "Most Needed was not selected by default"
    
    ${Child_name}=    Get Text    xpath=(//div[@class='bySpecName'])[1]/p[1]    
    ${child_details}=    Get Text    xpath=(//div[@class='bySpecinfo'])[1]/p
    ${child_location}=    Get Text    xpath=(//div[@class='bySpecLocation'])[1]/p    
    
    Mouse Over    xpath=(//div[@class='bySpecContHolder'])[1]
    Click Element    xpath=(//input[@value='SPONSOR NOW'])[1]
    
    ${child_status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='overall_banner_pledge'][1]/div[2]/h2[contains(text(),'${Child_name}')]
    Run Keyword If    'True'=='${child_status}'    Log To Console    "Child found in popup menus"    ELSE    Fail    "Child is mismatching in popup menu"
    
    ${recurring_payments}=    Run Keyword And Return Status    Checkbox Should Be Selected    xpath=(//input[@id='ChkForSI'])[1]
    Run Keyword If    'True'=='${recurring_payments}'    Log To Console    "Please use my card details for recurring payments is selected by default"    ELSE    Fail    "Please use my card details for recurring payments is not selected by default"
    
    ${more_childrens}=    Get Element Attribute    xpath=(//input[@id='SIPopBlock_qty'])[1]    value
    Run Keyword If    '0'=='${more_childrens}'    Log To Console    "Sponsor More Children is 0 by default "    ELSE    Fail    "Sponsor More Children is not 0 by default"
   
    #select child amount
    ${camp_amt}=    Get Text    xpath=(//label[contains(text(),'1 Month')])[1]
    ${Camp_amt}=    Get Substring    ${camp_amt}    9    16
    ${camp_amt}=    Convert to price    ${camp_amt}    
    Click Element    xpath=(//label[contains(text(),'1 Month')])[1]
    Click Element    id=ChkForSI    
    Add to cart text change            
    
    #Add to cart buttton
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']/input
    
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"    
    Click Element    xpath=//div[@class='cart-buttons']/a[2]    
    
    ${cart_quanity}=    check in view cart page - Checkout flow    ${Child_name}    ${camp_amt}    
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification    ${Child_name}    ${camp_amt}    ${cart_quanity}
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Child')]
    Why do you want to quit - PopUp    
    Sleep    10s    
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Child')]
    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='child_title' and contains(text(),'${Child_name}')]        
    Run Keyword If    'True'!='${status}'    Fail    Child was not visible in Mychild page
    
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Campaign')]
    Wait Until Element Is Visible    xpath=//li[@id='campsec-shwhde']    60s   
    Click Element    xpath=//li[@id='campsec-shwhde']    
    ${Campaign_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='cld-nme']/p[contains(text(),'${Child_name}')]        
    Run Keyword If    '${Campaign_visible}'!='True'    Fail    Campaign is not showing in my campaign page    ELSE    Log To Console    Campaign is showing in my campaign page
   


To sponsor single campaign and to verify in make payment page
    [Tags]    Make Payment Page
    
    Jenkins browser launch
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    Cart campaign check and delete            
    Mouser hover ways to give campaign    Save Malnourished Children
    Sleep    5s
    
    Click Element    xpath=.//div[@class='item-image']//img        

    ${camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div   
    ${label_val}=    Get Text    xpath=//label[contains(text(),'3 Months')]
    #${label_val}=    Get Text    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    ${Camp_amt}=    Get Substring    ${label_val}    9    16
    ${Camp_amt_sorted}=    Remove String Using Regexp    ${Camp_amt}    \\D 
    Log To Console    Final val is: ${camp_amt}
    Sleep    15s
    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='price save-malnourished-cart-sec current']/label[contains(text(),'1 Year ')]        
    Run Keyword If    '${status}'!='True'    Fail    Rs 7200 was not selected by default    ELSE    Log    Rs 7200 was selected by default

    Wait Until Element Is Visible    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label    15s    
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    Sleep    10s    
    Click Element    id=ChkForSI
    
    Add to cart text change
    
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"    

    Click Element    xpath=//a[@class='view_cart']

    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${camp_amt}
    View cart proceed button
    Login
    CCavenue payment success flow
    CCavenue payment - cart verification - dynamic    ${camp_name}    ${Camp_amt_sorted}    ${cart_quanity}
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Campaign')]
    Why do you want to quit - PopUp    
    Sleep    10s    
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Campaign')]
    Wait Until Element Is Visible    xpath=//li[@id='campsec-shwhde']    60s   
    Click Element    xpath=//li[@id='campsec-shwhde']    
    ${Campaign_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='cld-nme']/p[contains(text(),'${camp_name}')]        
    Run Keyword If    '${Campaign_visible}'!='True'    Fail    Campaign is not showing in my campaign page    ELSE    Log To Console    Campaign is showing in my campaign page


To verify download tax receipt should not reflect in offline success page
    
    [Tags]    Payment Acknowlodgement
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Sleep   20s
    Click Element    xpath=.//a[contains(.,'My Gifts')]
    Banner Alert
    Cart campaign check and delete
    Mouser hover ways to give campaign    Educate Children    
    ${camp_name}    ${camp_val}    Checkout flow campaign
    ${cart_quanity}    check in view cart page - Checkout flow    ${camp_name}    ${Camp_val}       
    View cart proceed button    
    Sleep    10s    
    Click Element    xpath=//input[@id='edit-payment-information-payment-method-offline-payment']    
    Scroll Element Into View    class=upihead
    #Click Element    xpath=//label[@class='off-container' and contains(text(),'UPI')]/span
    Sleep    10s 
    Click Element    id=off-edit-actions-next
    CCavenue payment - cart verification    ${camp_name}    ${camp_val}    ${cart_quanity}    
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//a[@id='downloadReceipt']        
    Run Keyword If    '${status}'!='True'    Fail    Receipt available for offline payment

To verify child timeline
    [Tags]    MyChild Page    

    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'My Child')]
    Click Element    xpath=(//div[@class='child_title'])[1]
    Click Element    xpath=(//div[@class='child_name heartbeat'])[1]
    
    @{child_details}=    Get WebElements    xpath=//ul[@class='tab-mnu']/li/p
    FOR    ${element}    IN    @{child_details}
        ${text}=    Get Text    ${element}
        Log To Console    Details enabled for child:    ${text}    
    END    
    ${timeline}=    Get Element Attribute    xpath=//ul[@class='tab-mnu']/li[1]    class
    Run Keyword If    '${timeline}'!='Active'    Fail    Cannot able to view timeline

To verify banner should appear for Donator at the month of March 1st and April 31st
    [Tags]    Tax Receipt Banner    
    
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Sleep    10s    
    ${day}=    Get Current Date    result_format=%Y-%m-%d    
    ${date}=    Convert Date    ${day}    datetime  
    Log To Console    Current month is: ${date.month}
    Run Keyword If    ${date.month}==3 or ${date.month}==4    Banner text check should be visible    80G receipt    ELSE    Log To Console    Current month is not March or April 
    

To Verify Tax receipt banner is not appear for the Donator before 28th Feburary
    [Tags]    Tax Receipt Banner    
    
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Sleep    10s    
    ${day}=    Get Current Date    result_format=%Y-%m-%d    
    ${date}=    Convert Date    ${day}    datetime   
    Log To Console    Current month is: ${date.month}          
    Run Keyword If    ${date.month}!=3 or ${date.month}!=4    Banner text check should not visible    80G receipt    ELSE    Log To Console    Currrent month is March or April banner should be present

To Verify Donor birthday banner should appear at the date before and after 15 days
    [Tags]    Donor birthday banner functionallity
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Mouse Over    xpath=//li[@class='welcomesponsor']
    Click Link    xpath=//a[@href="/user"]
    
    ${today_date}=    today date complete        
    ${dob_coverted}=    get DOB from my profile    
    ${days_have}=    no of days have calculation    ${dob_coverted}    ${today_date}    
    Run Keyword If    ${days_have}<=15    Banner check birthday    SPREAD THE JOY    ELSE    Log To Console    Donor birthday was not today

To Verify Donor Birthday banner should not appear when donor does not have birthday
    [Tags]    Donor birthday banner functionallity
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Mouse Over    xpath=//li[@class='welcomesponsor']
    Click Link    xpath=//a[@href="/user"]
    
    ${today_date}=    today date complete
        
    ${dob_coverted}=    get DOB from my profile
    
    ${days_have}=    no of days have calculation    ${dob_coverted}    ${today_date}
    
    Run Keyword If    ${days_have}>15    Banner check birthday - should not visible    SPREAD THE JOY    ELSE    Log To Console    Today is donor birthday 

To Verify First name Enter a valid String of Character with minimum length of 2
    [Tags]    Registration Page
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Register')]     
    Sleep    10s                         
        
    Input Text    xpath=//input[@id='edit-field-first-name-0-value']    tes    
    Sleep    3s
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//strong[@id='edit-field-first-name-0-value-error']        
    Run Keyword If    '${status}'!='True'    Fail    Minimun character number was not visible

    Clear Element Text    xpath=//input[@id='edit-field-first-name-0-value']
    Input Text    xpath=//input[@id='edit-field-first-name-0-value']    a b    
    Sleep    3s            
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//strong[@id='edit-field-first-name-0-value-error']        
    Run Keyword If    '${status}'!='True'    Fail    Minimun character number was not visible

    Clear Element Text    xpath=//input[@id='edit-field-first-name-0-value']
    Input Text    xpath=//input[@id='edit-field-first-name-0-value']    ab    
    Sleep    3s            
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//strong[@id='edit-field-first-name-0-value-error']        
    Run Keyword If    '${status}'!='True'    Fail    Minimun character number was not visible

    Clear Element Text    xpath=//input[@id='edit-field-first-name-0-value']
    Input Text    xpath=//input[@id='edit-field-first-name-0-value']    aswyasdlasdlaishasdgaksdgalsidgaskuydtoasydutasodytsoady    
    Sleep    3s        

    ${firstname}=    Get Element Attribute    xpath=//input[@id='edit-field-first-name-0-value']    value
    ${length}=    Get Length    ${firstname}

    Run Keyword If    ${length}>30    Fail    Maximum character exceeded in firstname field

To Verify Last name Enter a valid String of Character with minimum length of 2
    [Tags]    Registration Page
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Register')]     
    Sleep    10s                         
        
    Input Text    xpath=//input[@id='edit-field-last-name-0-value']    tes    
    Sleep    3s
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//strong[@id='edit-field-last-name-0-value-error']        
    Run Keyword If    '${status}'!='True'    Fail    Minimun character number was not visible

    Clear Element Text    xpath=//input[@id='edit-field-last-name-0-value']
    Input Text    xpath=//input[@id='edit-field-last-name-0-value']    a b
    Sleep    3s            
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//strong[@id='edit-field-last-name-0-value-error']        
    Run Keyword If    '${status}'!='True'    Fail    Minimun character number was not visible

    Clear Element Text    xpath=//input[@id='edit-field-last-name-0-value']
    Input Text    xpath=//input[@id='edit-field-last-name-0-value']    ab    
    Sleep    3s            
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//strong[@id='edit-field-last-name-0-value-error']        
    Run Keyword If    '${status}'!='True'    Fail    Minimun character number was not visible

    Clear Element Text    xpath=//input[@id='edit-field-last-name-0-value']
    Input Text    xpath=//input[@id='edit-field-last-name-0-value']    aswyasdlasdlaishasdgaksdgalsidgaskuydtoasydutasodytsoady    
    Sleep    3s        

    ${lastname}=    Get Element Attribute    xpath=//input[@id='edit-field-last-name-0-value']    value
    ${length}=    Get Length    ${lastname}

    Run Keyword If    ${length}>30    Fail    Maximum character exceeded in firstname field

To verify Tax Receipt banner is not appear for Register user after May 1st
    [Tags]    Tax Receipt Banner    
    
    Jenkins browser launch
    Click Element    xpath=//a[contains(text(),'Login')]
    Direct login
    Sleep    10s    
    ${day}=    Get Current Date    result_format=%Y-%m-%d    
    ${date}=    Convert Date    ${day}    datetime   
    Log To Console    Current month is: ${date.month}          
    Run Keyword If    ${date.month}!=3 or ${date.month}!=4    Banner text check should not visible    80G receipt    ELSE    Log To Console    Currrent month is March or April banner should be present

To Verify Reconfirm password Field User Should enter Password Details with min
    [Tags]    Registration Page
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Register')]     
    Sleep    10s        
    Password matching check    
    Password doesnt matching check
    #confirm password
    Clear Element Text    id=edit-pass-pass1
    Click Element    //label[@for='edit-pass-pass1']    
    Input Text    id=edit-pass-pass1    ${pass1}    
    Sleep    5s    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-pass-pass1-error        
    Run Keyword If    '${status}'=='True'    Log To Console    Page throughs error message for password minimum length    ELSE    Fail    Page doesnt throughs error message for password minimum length          
    
    Clear Element Text    id=edit-pass-pass2
    Click Element    //label[@for='edit-pass-pass2']    
    Input Text    id=edit-pass-pass2    ${pass1}    
    Sleep    5s
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    id=edit-pass-pass2-error        
    Run Keyword If    '${status}'=='True'    Log To Console    Page throughs error message for password minimum length    ELSE    Fail    Page doesnt throughs error message for password minimum length                  

To Verify Address 1 Field minimum and maximum
    [Tags]    Registration Page
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Register')]     
    Sleep    10s
    
    ${address_random_min}=    Generate Random String    length=9
    ${address_random_max}=    Generate Random String    length=65                        
    
    Input Text    xpath=//input[@id='edit-field-registeraddress-0-value']    ${address_random_min}  
    Press Keys    xpath=//input[@id='edit-field-registeraddress-0-value']    TAB
    ${address_min}=    Get Element Attribute    xpath=//input[@id='edit-field-registeraddress-0-value']    value
    ${length}=    Get Length    ${address_min}
    Run Keyword If    ${length}<10    Element Should Be Visible    id=edit-field-registeraddress-0-value-error    ELSE    Fail    Minimum length alert was not visible    
                
    Clear Element Text    xpath=//input[@id='edit-field-registeraddress-0-value']
    Input Text    xpath=//input[@id='edit-field-registeraddress-0-value']    ${address_random_max}
    ${address_max}=    Get Element Attribute    xpath=//input[@id='edit-field-registeraddress-0-value']    value
    ${length}=    Get Length    ${address_max}
    Run Keyword If    ${length}>60    Fail    Maximum character exceeded in firstname field    ELSE    Log To Console    Maximum length is maintained in address field    

To Verify Address 2 Field minimum and maximum
    [Tags]    Registration Page
    
    Jenkins browser launch
    Navigation banner close
    Click Element    xpath=//a[contains(text(),'Register')]     
    Sleep    10s
    
    ${address_random_min}=    Generate Random String    length=9
    ${address_random_max}=    Generate Random String    length=65                        
    
    Input Text    xpath=//input[@id='edit-field-address-2-0-value']    ${address_random_min}  
    Press Keys    xpath=//input[@id='edit-field-address-2-0-value']    TAB
    ${address_min}=    Get Element Attribute    xpath=//input[@id='edit-field-address-2-0-value']    value
    ${length}=    Get Length    ${address_min}
    Run Keyword If    ${length}<10    Element Should Be Visible    id=edit-field-address-2-0-value-error    ELSE    Fail    Minimum length alert was not visible    
                
    Clear Element Text    xpath=//input[@id='edit-field-address-2-0-value']
    Input Text    xpath=//input[@id='edit-field-address-2-0-value']    ${address_random_max}
    ${address_max}=    Get Element Attribute    xpath=//input[@id='edit-field-address-2-0-value']    value
    ${length}=    Get Length    ${address_max}
    Run Keyword If    ${length}>60    Fail    Maximum length is exceeded in address field    ELSE    Log To Console    Maximum length is maintained in address field    
