*** Settings ***
#Test Teardown     Close Browser
Library    SeleniumLibrary
Library    String
Library    DateTime
Library    BuiltIn
Library    Collections


*** Variables ***
${baseurl}        https://uat.worldvision.in/
${browser}        chrome
${rightside_menu_list}    7
${postlogin_menu_list}    6
${edu_child_amt}    4000
${val}            000
${amount}    1000
${minimum_amount}    101
${accurate_amount}    100
${lesser_amount}    99
${maximum_amount}    99999
${higher_amount}    999999
${hunger_free_camp_amt}    1000
${hunger_camp_name_space}    Free
${month_input}    April
${year_input}    2020
${language_input}    English
${user_name}      9999999997
${password}       password
${addon_val}      100
${real_gift_enter_val}    1000
@{email_validation}    asdasdad    934852    )*&%^&^%&^%    @gmail    @gmail.com    @@gmail.com    asdgasd.com    (^*&*^)*&@gmail.com
@{registration_title}    Mr.    Miss.    Mrs.    Dr.
${checkout_payment_list_no}    4
@{HungerFree_alert}    edit-name-error    edit-date-of-birth-error    edit-email-error    edit-mobile-number-error
@{alert_list}    edit-name--error    edit-email--error    edit-contact--error    edit-query-type-error    edit-message-error
@{RegisterFields}    signUpfnameErr    signUplnameErr    signUpEmailErr    signInPhoneErr    signUpPassErr    signUpConPassErr    signUpaddrErr    signUpaddrErr1    signUpaddrErr3    signUpPscodeErr    signUpCityErr    signUpStateErr
@{Sponcer_List}    Educate Children    Educate Children    Educate Children    Educate Children    Educate Children    Educate Children    Educate Children    Educate Children    Educate Children    Educate Children
#@{Sponcer_List}    Educate Children    HIV & AIDS    End Child Sexual Abuse    Childhood Rescue    Save Malnourished Children    Educate Children    HIV & AIDS    End Child Sexual Abuse    Childhood Rescue    Save Malnourished Children
@{homepage_header_menu_txt}    About Us    Child Sponsorship    Ways to Give    Get Involved    Partnerships    Media
@{checkout_payment_list_text}    Powered by CC Avenue    Powered by AXIS BANK    POWERED BY HDFC BANK
@{SI_payment_list_text}    NET BANKING    Indian credit card    Debit card
@{checkout_payment_list_ind_passport}    Debit Card/Net banking/Wallets/Amex    Amazon Pay    International credit card    Indian credit cards    Offline Payment
@{postlogin_homepage_header_menu_txt_list}    My World    My Child    My Campaign    Tax Receipts    Ways to Give    Explore More
@{postlogin_homepage_header_chck_menu_txt}    My World    My Child    My Campaign    Tax Receipts    Ways to Give    Explore More
@{Aboutus_submenu_txt}    Who We Are    How We Work    Where We Work    Our History    Our Accountability    Careers    Contact Us
@{Childsponsorship_submenu_txt}    How Sponsorship Works    Sponsor a Child    Stories of Change    Partners Speak    FAQs    Child Protection Policy
@{Ways_to_give}    Overview    HoSh - Hope to Shine    Back to School    Gift Catalogue    Educate Children    Emergency Relief    HIV & AIDS    Hungerfree    End Child Sexual Abuse    Childhood Rescue    Save Malnourished Children    Where Most Needed
@{Get_involved}    Events    Volunteer
@{Media_submenu_txt}    Press Releases    News Articles    Blog    Publication
@{Partnership_submenu_txt}    Corporate
#@{post_login_my_world_submenu_txt}
@{post_login_waysto_give}    Overview    HoSh - Hope to Shine    Back to School    Gift Catalogue    Educate Children    Emergency Relief    HIV & AIDS    Hungerfree    End Child Sexual Abuse    Childhood Rescue    Save Malnourished Children    Where Most Needed
${button_failure_txt}    TRY AGAIN NOW
${pass1}    abc
${pass2}    cba


*** Keywords ***

Jenkins browser launch
    Set Selenium Speed    .5s
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    Call Method    ${chrome_options}    add_argument    no-sandbox
    Call Method    ${chrome_options}    add_argument    incognito
    Call Method    ${chrome_options}    add_argument    disable-notifications
    Create WebDriver    Chrome    chrome_options=${chrome_options}
    Set Window Size    1920    1080
    Go To    ${baseurl}
    Set Browser Implicit Wait    60s

Local browser launch
    Set Selenium Speed    .5s
    Open Browser    ${baseurl}    ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait    60s

Calculation amount
    [Arguments]    ${child_amt}    ${edu_camp_amt}
    ${total_amt}=    Evaluate    ${child_amt}+${edu_camp_amt}
    [Return]    ${total_amt}
    
View cart proceed button
    Click Element    xpath=.//input[@id='edit-checkout']

Mouser hover ways to give campaign
    [Arguments]    ${edu_child}
    Mouse Over    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Ways to Give')]
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'${edu_child}')]

Ensure default amount in educational need
    ${get_val}=    Get Element Attribute    xpath=//div[@class='realgift_input_value commerce_manual_inputs']/input[1]    value
    #Log To Console    Input value is: ${get_val}
    Run Keyword If    '1000'!='${get_val}'    Fail    "Default value '1000' not display"

Error default value and check button disable
    Click Element    xpath=//div[@class='realgift_input_value commerce_manual_inputs']/input[1]       
    Clear Element Text    xpath=//div[@class='realgift_input_value commerce_manual_inputs']/input[1]
    Input Text    xpath=//div[@class='realgift_input_value commerce_manual_inputs']/input[1]    99
    ${chck_button_disable}=    Element Should Be Disabled    xpath=//div[@class='kl_flood_sub_or_sec']/input[1]
    #${chck_button_disable}=    Get Element Attribute    xpath=//div[@class='kl_flood_sub_or_sec']/input[1]    disabled
    Log To Console    Diabled value is:${chck_button_disable}
    Run Keyword If    '${chck_button_disable}'!='true'    Fail    "Enter amount '99' but 'ADD TO CART' button not in disable mode"
    Input Text    xpath=//div[@class='realgift_input_value commerce_manual_inputs']/input[1]    ${real_gift_enter_val}

View cart page
    ${backto_schl_campaign_name}=    Get Text    xpath=.//div[@class='views-infinite-scroll-content-wrapper clearfix']/div[1]//div[@id='mySidenav']//div[@class='inner_banner_pledge_content']/h2
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"
    Click Element    xpath=//a[@class='view_cart']
    ${back_to_school_camp}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${backto_schl_campaign_name}')]
    Run Keyword If    'True'!='${back_to_school_camp}'    Fail    "Back to school campaign not display in view cart page"
    ${real_gift_}=    Replace String    ${real_gift_enter_val}    1    1,
    ${back_to_school_camp_amt}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'₹${real_gift_}')]
    Run Keyword If    'True'!='${back_to_school_camp_amt}'    Fail    "Back to school campaign amount are not display/mismatch in view cart page"

Delete view cart campaign   
    Sleep    10s     
    ${gift_cart_msg1}=    Get Text    xpath=//span[@class='badge notification_badge']
    ${gift_cart_msg1}=    Convert To Integer    ${gift_cart_msg1}
    Run Keyword If    ${gift_cart_msg1}>=1    Click Element    xpath=(.//a[@class='remove-btn'])[1]    ELSE    Log To Console    "Cleared Cart"    
    #${gift_cart_msg}=    Get Text    xpath=//div[@class='Empty_basket_Content']/h1  
    Sleep    10s              
    ${gift_cart_msg1}=    Get Text    xpath=//span[@class='badge notification_badge']
    ${gift_cart_msg1}=    Convert To Integer    ${gift_cart_msg1}  
    Log To Console    ${gift_cart_msg1}      
    Run Keyword If    ${gift_cart_msg1}>=1    Fail    "Your cart have some order left"
    #Run Keyword If    '${gift_cart_msg}'!='Your Gift Cart is Empty'    Fail    "In View cart page after complete deletion 'Your Gift Cart Is Empty' text not display" 

Login
    Click Element   xpath=//input[@id='edit-login-custom-returning-customer-name']
    Input Text    xpath=//input[@id='edit-login-custom-returning-customer-name']    ${user_name}
    Click Element   xpath=//input[@id='edit-login-custom-returning-customer-password']
    Input Text    xpath=//input[@id='edit-login-custom-returning-customer-password']    ${password}
    Click Element    xpath=(//div[@class='login-form__submit']/button)[1]
    
  
Direct login
    Click Element    id=edit-name
    Input Text    id=edit-name    ${user_name}
    Click Element    id=edit-pass
    Input Text    id=edit-pass    ${password}
    Click Element    xpath=(//div[@class='login-form__submit']/button)[1]
    
SI login
    Wait Until Element Is Visible    xpath=//input[contains(@id,'exampleInputEmail')]    30s
    Click Element    xpath=//input[contains(@id,'exampleInputEmail')]    
    Input Text    xpath=//input[contains(@id,'exampleInputEmail')]    ${user_name}  
    Click Element    xpath=//input[contains(@id,'exampleInputPassword')]
    Input Text    xpath=//input[contains(@id,'exampleInputPassword')]    ${password}
    
    Sleep    10s    
    Click Element    id=si_login_btn
    
    Wait Until Element Is Visible    xpath=//div[@class='payment-main-content']    30s    
    ${si_postlogin_chck}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='payment-main-content']
    Run Keyword If    'True'!='${si_postlogin_chck}'    Fail    "SI flow Postlogin page not display"

CCavenue payment success flow    
    #Wait Until Element Is Visible    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'Powered by AXIS BANK')]
    #Click Element    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'Powered by AXIS BANK')]/preceding-sibling::input
    #Click Element    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'Powered by CC Avenue')]/preceding-sibling::input
    #Sleep    4s
    ${chck_ccaveneu_click}=    Get Element Attribute    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'Powered by CC Avenue')]/parent::div    class
    Run Keyword If    '${chck_ccaveneu_click}'!='js-form-item form-item js-form-type-radio form-item-payment-information-payment-method js-form-item-payment-information-payment-method active'    Click Element    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'Powered by CC Avenue')]/parent::div
    Sleep    30s
    Click Element    //button[text()='pay my contribution']    
    #Click Element    xpath=.//input[@id='edit-actions-next']
    #${order_id}=    Get Text    xpath=.//span[@class='order-value']
    #Log To Console    Order id:${order_id}
    Wait Until Element Is Visible    xpath=(.//div[@id='OPTNBK']//span[2][contains(text(),'Net Banking')])[1]    15s    
    Click Element    xpath=(.//div[@id='OPTNBK']//span[2][contains(text(),'Net Banking')])[1]
    Select From List By Value    id=netBankingBank    AvenuesTest
    Click Element    xpath=(.//span[starts-with(text(),'Make')])[3]
    Click Element    xpath=.//input[@type='submit']      
    Banner Alert
    ${payment_success_msg}=    Get Text    xpath=//div[@id='edit-completion-message']//h3
    Run Keyword If    'PAYMENT SUCCESSFULL'!='${payment_success_msg}'    Fail    "Payment successful page not display"
    
Educate children campaign with checkout flow
    Mouse Over    xpath=//div[@id='block-tbmegamenu-2']//ul[@class='we-mega-menu-ul nav nav-tabs']/li/span[contains(.,'Ways to Give')]
    Click Element    xpath=(.//li/a[contains(.,'Educate Children')])[1]
    Sleep    10s
    Click Element    xpath=.//div[@class='item-image']//img
    ${educate_chld_camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    #${check_label_checked}=    Get Element Attribute    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label    class
    #Run Keyword If    '${check_label_checked}'!='price save-malnourished-cart-sec current'    Fail    "Selected label not be in checked mode"
    Click Element    id=ChkForSI
    Click Element    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Input Text    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    ${edu_child_amt}
    #${sel_label_quantity}=    Get Text    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label/following-sibling::span
    #${sel_educate_label_amt}=    Get Element Attribute    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label    for
    #Log To Console    Selected label quantity:${sel_label_quantity}
    #Log To Console    Selected label amount:${sel_educate_label_amt}
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    Click Element    xpath=//a[@class='view_cart']
    ${replace_val_educate_camp}=    Replace String    ${edu_child_amt}    4    4,
    ${edu_child_camp_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${educate_chld_camp_name}')]
    Run Keyword If    'True'!='${edu_child_camp_viewcart}'    Fail    "Educate children campaign not display in view cart page"
    ${chck_edu_child_camp_amt_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'₹${replace_val_educate_camp}')]
    Run Keyword If    'True'!='${chck_edu_child_camp_amt_viewcart}'    Fail    "Educate children campaign amount are not display/mismatch in view cart page"

Checkout flow campaign
    Click Element    xpath=.//div[@class='item-image']//img
    ${camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div   
    ${label_val}=    Get Text    xpath=//label[contains(text(),'3 Months')]
    #${label_val}=    Get Text    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    ${Camp_amt}=    Get Substring    ${label_val}    9    16
    Log To Console    Final val is: ${camp_amt}
    Sleep    15s
    
    Wait Until Element Is Visible    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label    15s    
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    Sleep    10s    
    Click Element    id=ChkForSI
    
    Add to cart text change
    
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"    

    Click Element    xpath=//a[@class='view_cart']
    
    # ${view_cart_amount}=    Get Text    xpath=//td[@class='views-field views-field-total-price__number views-align-center']
    # Log To Console    View cart page campaign amount: ${view_cart_amount}
    
    [Return]    ${camp_name}    ${camp_amt}

SI flow campaign
    Sleep    10s
    Click Element    xpath=.//div[@class='item-image']//img
    ${camp_name}=    Get Text    xpath=//div[@class='inner_banner_pledge_content']/h2/div
    ${educate_chld_camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    ${label_val}=    Get Text    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    ${final_val}=    Get Substring    ${label_val}    9    16
    Log To Console    Final val is:${final_val}
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    ${status}=    Run Keyword And Return Status    Checkbox Should Be Selected    id=ChkForSI    
    Run Keyword If    'True'!='${status}'    Fail    'Auto Pay check box was not selected'    ELSE    Log To Console    'Checkbox selected by default'    
    Click Element    xpath=//button[@class='btn btn-primary si_modal_btn']
    
one time campaign
    Click Element    xpath=.//div[@class='item-image']//img
    ${camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    Click Element    id=ChkForSI
    
    Add to cart text change
    Add to cart functionality

    Clear Element Text    xpath=//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Click Element    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    
    Input Text    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    ${edu_child_amt}
    Sleep    5s    

    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"    

    Click Element    xpath=//a[@class='view_cart']
    ${camp_val}=    Replace String    ${edu_child_amt}    4    4,
    [Return]    ${camp_name}    ${camp_val}
    
One time Hunger Free campaign
    Mouse Over    xpath=//div[@id='block-tbmegamenu-2']//ul[@class='we-mega-menu-ul nav nav-tabs']/li/span[contains(.,'Ways to Give')]
    Click Element    xpath=(.//li/a[contains(.,'Hungerfree')])[1]
    Sleep    10s
    Click Element    xpath=.//div[@class='add-to-cart-section']
    ${hunger_camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    ${hunger_camp_name}=    Remove String    ${hunger_camp_name}    Free
    Log To Console    ${hunger_camp_name}    
    #${split_Hunger_name_with_rightside}=    Split String From Right    ${hunger_camp_name}    ${EMPTY}
    ${input_val}=    Get Element Attribute    xpath=.//input[@name='manualCart[0][amount]']    value
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"
    Click Element    xpath=//a[@class='view_cart']
    ${hunger_camp_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${hunger_camp_name}')]
    Run Keyword If    'True'!='${hunger_camp_viewcart}'    Fail    "Hunger Free campaign not display in view cart page"    
    ${replace_val}=    Replace String    ${input_val}    1    1,    
    ${hunger_camp_amt_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'${replace_val}')]    
    #${hunger_camp_amt_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'â‚¹${replace_val}')]
    Run Keyword If    'True'!='${hunger_camp_amt_viewcart}'    Fail    "Hunger Free campaign amount are not display/mismatch in view cart page"
    [Return]    ${input_val}
    
Rescue child campaign
    Mouse Over    xpath=//div[@id='block-tbmegamenu-2']//ul[@class='we-mega-menu-ul nav nav-tabs']/li/span[contains(.,'Ways to Give')]
    Click Element    xpath=(.//li/a[contains(.,'Childhood Rescue')])[1]
    Sleep    10s
    Click Element    xpath=.//div[@class='item-image']//img
    ${rescue_child_camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    Click Element    xpath=.//button[@class='btn btn-primary si_modal_btn']
    
check in view cart page
    [Arguments]    ${camp_name}    ${camp_amt}
    ${camp_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${camp_name}')]
    Run Keyword If    'True'!='${camp_viewcart}'    Fail    "${camp_name} campaign not display in view cart page"
    ${camp_amt_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'${camp_amt}')]
    Run Keyword If    'True'!='${camp_amt_viewcart}'    Fail    "${camp_name} campaign amount are not display or mismatch in view cart page"   

Subtract date
    ${CurrentDate}=    Get Current Date    result_format=%Y-%m-%d
    ${date}=    Subtract Time From Date    ${CurrentDate}    3days
    ${sub_time}=    Convert Date    ${date}    datetime
    [Return]    ${sub_time.day}

Today date
    ${CurrentDate}=    Get Current Date    result_format=%Y-%m-%d
    ${datetime}=    Convert Date    ${CurrentDate}    datetime
    [Return]    ${datetime.day}

Notification deletion
    [Arguments]    ${get_viewcart_list_count}
    #${get_viewcart_list_count}=    Set Variable    ${get_viewcart_list_count + 1}      
    FOR    ${index}    IN RANGE    ${get_viewcart_list_count}    0    -1    
        Click Element    xpath=(//a[@class='remove-btn'])[${index}]    
        Sleep    10s    
    END           
    ${check_cartpage_after_complete_del}=   Get Text    xpath=//div[@class='Empty_basket_Content']/h1    
    Run Keyword If    '${check_cartpage_after_complete_del}'!='Your Gift Cart is Empty'    Fail    "In View cart page after complete deletion 'Your Gift Cart is Empty' text not display"

Remove symbol
    [Arguments]    ${val}    ${sysmbol}
    ${output}=    Remove String    ${val}    ${sysmbol}
    [Return]    ${output}

CCAvenue payment failure flow
    ${chck_ccaveneu_click}=    Get Element Attribute    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'Powered by CC Avenue')]/parent::div    class
    Run Keyword If    '${chck_ccaveneu_click}'!='js-form-item form-item js-form-type-radio form-item-payment-information-payment-method js-form-item-payment-information-payment-method active'    Click Element    xpath=.//div[@id='block-paymentmode']//div[@id='edit-payment-information-payment-method']/div/span[contains(.,'Powered by CC Avenue')]/parent::div
    Sleep    30s
    Click Element    xpath=//div[@id='edit-actions']/button[contains(text(),'pay my contribution')]
    #${order_id}=    Get Text    xpath=.//span[@class='order-value']
    #Log To Console    Order id:${order_id}
    Wait Until Element Is Visible    xpath=(.//div[@id='OPTNBK']//span[2][contains(text(),'Net Banking')])[1]   15s
    Click Element    xpath=(.//div[@id='OPTNBK']//span[2][contains(text(),'Net Banking')])[1]
    Select From List By Value    id=netBankingBank    AvenuesTest
    Click Element    xpath=(.//span[starts-with(text(),'Make')])[3]
    Select From List By Value    xpath=.//select[@name='PAID']    N
    Click Element    xpath=.//input[@type='submit']
    ${payment_msg}=    Get Text    xpath=.//div[@class='content block-content']/div/h3/span
    ${Payment_msg}=    Remove String Using Regexp    ${payment_msg}    \\W*\\d*
    Log To Console    Payment failure text: ${payment_msg}
    Run Keyword If    'PAYMENTFAILED'!='${payment_msg}'    Fail    "Payment Failure page not display"

Payment failure check in home page banner
    [Arguments]    ${content}
    
    ${banner_count}=    Get Element Count    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide')]
    ${banner_count}=    Convert To Integer    ${banner_count}    
    FOR    ${element}    IN RANGE    1    ${banner_count}+1
        Click Element    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide ${element}')]
        Capture Page Screenshot
        ${status}=    Run Keyword And Return Status    Element Should Contain    xpath=//div[@class='banner-content']/a[contains(text(),'${content}')]    ${content}            
        Run Keyword If    '${status}'=='True'    Log To Console    Payment Failure banner is visible    
        Exit For Loop If    '${status}'=='True'
    END            
    Run Keyword If    '${status}'!='True'    Fail    Payment failure banner was not found

Check child duplicate
    Local browser launch
    Click Element    xpath=//div[@class='item active']//div[@class='stepwizard-row setup-panel']//div[3]//div[1]//label[1]
    Click Element    xpath=.//div[@class='item active']//label[@class='chkSIlabel']
    Click Element    xpath=//div[@class='item active']//input[@id='edit-submit--12']
    ${get_src}=    Get Element Attribute    xpath=(.//*[@class='child_sponsor_image']/img)[1]    src
    Log To Console    Src value is:${get_src}
    Reload Page
    ${get_child_count}=    Get Element Count    xpath=.//*[@class='child_sponsor_image']/img
    ${chceck}=    Evaluate    ${get_child_count}+1
    FOR    ${index}    IN RANGE    1    ${chceck}
        ${currentselece_child_src}=    Get Element Attribute    xpath=(.//*[@class='child_sponsor_image']/img)[${index}]    src
        Run Keyword If    '${currentselece_child_src}'=='${get_src}'    Fail    "Child are duplicate"
    END

Check allow auto debit select default in child rotator
    ${get_count}=    Get Element Count    xpath=.//div[starts-with(@class,'item')]//label[@class='chkSIlabel']/parent::label/following-sibling::div[contains(@style,'display: none')]
    Run Keyword If    ${get_count}>0    Fail    Some one child is not have default 'Alllow Auto Debit' not checked

9600 should select defaulty
    ${get_child_count}=    Get Element Count    xpath=.//*[@class='child_sponsor_image']/img
    ${chceck}=    Evaluate    ${get_child_count}+1
    FOR    ${index}    IN RANGE    1    ${chceck}
        ${active_default_label}=    Get Element Attribute    xpath=(//div[starts-with(@class,'item')]//div[@class='stepwizard-row setup-panel']//div[4]//div[1]//label)[${index}]    class
        Run Keyword If    '${active_default_label}'!='active'    Fail    "Some one child not have default amount '9,600' choosed"
    END

Check rounded checkbox txt and amount
    Click Element    xpath=//div[@class='item active']//div[@class='stepwizard-row setup-panel']//div[4]//div[1]//label[1]
    ${txt_1}=    Get Text    xpath=//div[@class='item active']//div[@class='rota_mandy']//p/span
    Run Keyword If    ${txt_1}!='₹9,600 every year.'    Fail    "I am willing pay ${txt_1} text amount is mismatch
    Click Element    xpath=//div[@class='item active']//div[@class='stepwizard-row setup-panel']//div[3]//div[1]//label[1]
    ${txt_2}=    Get Text    xpath=//div[@class='item active']//div[@class='rota_mandy']//p/span
    Run Keyword If    ${txt_2}!=' ₹4,800 every 6 months.'    Fail    "I am willing pay ${txt_2} text amount is mismatch
    Click Element    xpath=//div[@class='item active']//div[@class='stepwizard-row setup-panel']//div[3]//div[1]//label[1]
    ${txt_3}=    Get Text    xpath=//div[@class='item active']//div[@class='rota_mandy']//p/span
    Run Keyword If    ${txt_3}!='₹2,400 every 3 months.'    Fail    "I am willing pay ${txt_3} text amount is mismatch
    Click Element    xpath=//div[@class='item active']//div[@class='stepwizard-row setup-panel']//div[3]//div[1]//label[1]
    ${txt_4}=    Get Text    xpath=//div[@class='item active']//div[@class='rota_mandy']//p/span
    Run Keyword If    ${txt_4}!='₹800 every month.'    Fail    "I am willing pay ${txt_4} text amount is mismatch

Child duplicate checking
    [Arguments]    ${sel_child}
    Click Element    xpath=(//a[@class='site-branding-logo'])[1]
    ${get_child_count}=    Get Element Count    xpath=.//*[@class='child_sponsor_image']/img
    ${chceck}=    Evaluate    ${get_child_count}+1
    FOR    ${index}    IN RANGE    1    ${chceck}
        ${currentselece_child_src}=    Get Element Attribute    xpath=(.//*[@class='child_sponsor_image']/img)[${index}]    src
        Run Keyword If    '${currentselece_child_src}'=='${sel_child}'    Fail    "Child are duplicate"
    END
    
Ways to give - 5 items
    [Arguments]    ${sponcer}
    Mouse Over    xpath=//div[@id='block-tbmegamenu-2']//ul[@class='we-mega-menu-ul nav nav-tabs']/li/span[contains(.,'Ways to Give')]
    Click Element    xpath=(.//li/a[contains(.,'${sponcer}')])[1]  
    Sleep    10s
    Click Element    xpath=.//div[@class='item-image']//img
    ${educate_chld_camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
        #Click Auto credit
    Sleep    10s    
    Click Element    id=ChkForSI
        #enter Amount
    Click Element    xpath=//input[contains(@class,'commerce_manual_input realgift_inputvalue realgift_input')]
    Input Text    xpath=//input[contains(@class,'commerce_manual_input realgift_inputvalue realgift_input')]    1000000    
        #Add to cart
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
        #Proceed to cart
    Click Element    xpath=//a[@class='view_cart']    
    Banner Alert

Rotator Child Details
    Sleep    15s
    ${footer_status}=    Run Keyword And Return Status    Element Should Be Visible    id=myCarousel
    Run Keyword If    'True'!='${footer_status}'    Fail    "Home Page Footer child rotator section not displayed"
    
    Click Element    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//div[@class='stepwizard-row setup-panel']/div[3]/div/label    
    ${child_name}=    Get Text    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//h4  
    ${child_name}=    Remove String Using Regexp    ${child_name}    \,.*$         
    ${sel_child_amt}=    Get Text    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//p[@class='pricemnth active']//span[@class='home-price']
    ${sel_child_amt}=    Remove String    ${sel_child_amt}     .00
    ${sel_child_imgsrc}=    Get Element Attribute    xpath=//div[@class='item active childRotator' or @class='item childRotator active']/div/div[1]/div[1]/div/img    src
    [Return]    ${child_name}    ${sel_child_amt}    ${sel_child_imgsrc}

Rotator Payment validation
    [Arguments]    ${sel_child_imgsrc}
    Sleep    15s    
    Click Element    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//label[@class='chkSIlabel']
    ${footer_proceed_btn}=    Get Element Attribute    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//input[@id='edit-submit--12']    value
    Run Keyword If    '${footer_proceed_btn}'!='SPONSOR NOW'    Fail    "After Allow Auto Debit button click it will not change into 'Sponsor Now' text"
    Click Element    xpath=//div[@class='item active childRotator' or @class='item childRotator active']//input[@id='edit-submit--12']
    ${child_sponsor_msg}=    Get Text    xpath=//h2[@class='chat-text']
    Run Keyword If    '${child_sponsor_msg}'!='Success !'    Fail    "After child selected 'Sponsor Successfull' text not display"
    ${Sponsor_success_img_chck}=    Get Element Attribute    xpath=//div[@class='item active childRotator' or @class='item childRotator active']/div/div[1]/div[1]/div/img    src
    Run Keyword If    '${Sponsor_success_img_chck}'!='${sel_child_imgsrc}'    Fail    "Footer selected child and sponsor successs child image are not match"
   
Rotator Child cart validation 
    [Arguments]    ${child_name}    ${sel_child_amt}
    ${chck_child_name}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${child_name}')]
    Run Keyword If    'True'!='${chck_child_name}'    Fail    "Choosed child not display in view cart page"
    ${chck_child_amt}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'${sel_child_amt}')]
    Run Keyword If    'True'!='${chck_child_amt}'    Fail    "Choosed child amount are mismatch in view cart page"
    
Banner Alert
    ${banner_status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=(//div[@class='refer-cls'])[1]/img    
    Run Keyword If    'True'=='${banner_status}'    Click Element    xpath=(//div[@class='refer-cls'])[1]/img     ELSE    Log To Console    "Banner was not present"    

Direct login - Other passport user
    Click Element    id=edit-name
    Input Text    id=edit-name    testmail@test.com
    Click Element    id=edit-pass
    Input Text    id=edit-pass    test
    Click Element    xpath=(//div[@class='login-form__submit']/button)[1]    
    
MyProfile Edit
    Mouse Over    xpath=.//li[@class='welcomesponsor']
    Click Element    xpath=.//ul[@class='mypro-lgot']/li/a[contains(.,'My profile')]
    Click Element    xpath=.//a[contains(.,'Edit Profile')]
    Scroll Element Into View    xpath=.//label[@for='edit-field-nationality']
   
Check other passport holder        
    ${OtherPassStatus}=    Run Keyword And Return Status    Element Should Be Disabled    xpath=//label[@for='othctzn']        
    Run Keyword If    'True'!='${OtherPassStatus}'    Fail    "INDIAN User can able to select other passport user"
    Mouse Over    xpath=//li[@class='welcomesponsor']        
    Click Element    xpath=//a[contains(text(),'My profile')]    

Check indian passport holder
    ${indianPassStatus}=    Run Keyword And Return Status    Element Should Be Disabled    xpath=//input[@id='indctzn']        
    Run Keyword If    'True'!='${indianPassStatus}'    Fail    "OTHER PASSPORT User can able to select Indian Citizen"
    Mouse Over    xpath=//li[@class='welcomesponsor']        
    Click Element    xpath=//a[contains(text(),'My profile')]  
    
Navigation banner close   
    ${nav_banner_status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@id='mySidenav']/a    
    Run Keyword If    'True'=='${nav_banner_status}'    Click Element    xpath=//div[@id='mySidenav']/a     ELSE    Log To Console    "Nav banner was not present" 
 
MyCampaign List
    @{mycampaign}=    Get WebElements    xpath=//div[@class='userCampHolder']//a
    FOR    ${element}    IN    @{mycampaign}
        ${text}=    Get Text    ${element}
        Log To Console    My campaign lists are: ${text}   
    END 
    
Overview List
    @{overview_list}=    Get WebElements    class=Way_give_title
    FOR    ${element}    IN    @{overview_list}
        ${text}=    Get Text    ${element}
        Log To Console    Overview lists are: ${text}   
    END
    
Registration - Indian
    
    Click Element    xpath=//a[contains(text(),'Register')]
    
    Select From List By Label    id=edit-field-title    Mr.
    
    Input Text    id=edit-field-first-name-0-value    john
    #last name
    Input Text    id=edit-field-last-name-0-value    kennedy
    #Email
    Input Text    id=edit-mail    john@john.com
    #Phone no
    Input Text    id=edit-field-mobile-verify-0-mobile    6666666666
    #confirm password
    Wait Until Element Is Visible    id=edit-pass-pass1    20s
    Click Element    //label[text()='Password']    
    Input Text    id=edit-pass-pass1    john
    #Re-confirm
    Wait Until Element Is Visible    id=edit-pass-pass2    20s
    Click Element    //label[text()='Confirm Password']
    Input Text    id=edit-pass-pass2    john
    #Address 1
    Input Text    id=edit-field-registeraddress-0-value    Test Address 1
    #Address 2
    Input Text    id=edit-field-address-2-0-value    Test address 2
    #Address 3
    Input Text    id=edit-field-address-3-0-value    Test address 3
    #Postal code
    Input Text    id=edit-field-pin-code-0-value    600130
    #How Do you Know - Newly added
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Select From List By Label    id=edit-field-how-do-you-know-about-worl    Friends and Family        
    #DOB
    Click Element    xpath=//label[text()='Date of Birth']
    Select From List By Label    xpath=//select[@class='ui-datepicker-year']    1989
    Select From List By Label    xpath=//select[@class='ui-datepicker-month']    Oct
    Click Element    xpath=(//table//tbody/tr/td/a)[11]
    
    Click Element    id=user-register-form    
    
    Click Element    class=singUpRegister    

Registration - Indian - Test
    
    Click Element    xpath=//a[contains(text(),'Register')]
    
    Select From List By Label    id=edit-field-title    Mr.
    
    Input Text    id=edit-field-first-name-0-value    john
    #last name
    Input Text    id=edit-field-last-name-0-value    kennedy
    #Email
    Input Text    id=edit-mail    aswin.l@live.in
    #Phone no
    Input Text    id=edit-field-mobile-verify-0-mobile    8056230775
    #confirm password
    Wait Until Element Is Visible    id=edit-pass-pass1    20s
    Click Element    //label[@for='edit-pass-pass1']    
    Input Text    id=edit-pass-pass1    john
    #Re-confirm
    Wait Until Element Is Visible    id=edit-pass-pass2    20s
    Click Element    //label[@for='edit-pass-pass2']
    Input Text    id=edit-pass-pass2    john
    #Address 1
    Input Text    id=edit-field-registeraddress-0-value    Test Address 1
    #Address 2
    Input Text    id=edit-field-address-2-0-value    Test address 2
    #Address 3
    Input Text    id=edit-field-address-3-0-value    Test address 3
    #Postal code
    Input Text    id=edit-field-pin-code-0-value    600130
    #How Do you Know - Newly added
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Select From List By Label    id=edit-field-how-do-you-know-about-worl    Friends and Family        
    #DOB
    Click Element    xpath=//label[text()='Date of Birth']
    Select From List By Label    xpath=//select[@class='ui-datepicker-year']    1989
    Select From List By Label    xpath=//select[@class='ui-datepicker-month']    Oct
    Click Element    xpath=(//table//tbody/tr/td/a)[11]
    
    Click Element    id=user-register-form    
    
    Click Element    class=singUpRegister

one time campaign - Save malnourshied Children Campaign
    Click Element    xpath=.//div[@class='item-image']//img
    ${camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div   
    ${camp_name}=   Replace String    ${camp_name}    M    m
    ${camp_name}=   Replace String    ${camp_name}    C    c
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    Click Element    id=ChkForSI
    
    Add to cart text change
    Add to cart functionality
    
    Clear Element Text    xpath=//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Click Element    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Input Text    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    ${edu_child_amt}
    Sleep    5s    
    
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"    

    Click Element    xpath=//a[@class='view_cart']
    ${camp_val}=    Replace String    ${edu_child_amt}    4    4,
    [Return]    ${camp_name}    ${camp_val}

Cart addition check
    ${price_std}=    Get Text    xpath=//td[@class='views-field views-field-total-price__number-2']
    ${price_std}=    Remove String Using Regexp    ${price_std}    \\D        
    ${price_std}=    Convert To Integer    ${price_std}
    Log To Console    Standard price: ${price_std}     
    
    FOR    ${element}    IN RANGE    1    3
        Sleep    5s    
        Click Element    class=save-plus    
    END
    
    Sleep    10s    
    ${quantity}=    Get Element Attribute    xpath=//span[@class='dynamic-quantity']/div/input    value
    Log To Console    quanity of payment: ${quantity}    
    ${quantity}=    Convert To Integer    ${quantity}    
    ${total_cal}=    Evaluate    ${price_std}*${quantity} 
    
    ${total_cart}=    Get Text    xpath=//td[@headers='view-total-price-number-table-column']
    ${total_cart}=    Remove String Using Regexp    ${total_cart}    \\D        
    ${total_cart}=    Convert To Integer    ${total_cart}   
    Log To Console    Total cart value: ${total_cal}        

    Should Be Equal As Integers    ${total_cal}    ${total_cart}

Cart reduce check
    ${price_std}=    Get Text    xpath=//td[@class='views-field views-field-total-price__number-2']
    ${price_std}=    Remove String Using Regexp    ${price_std}    \\D        
    ${price_std}=    Convert To Integer    ${price_std}
    Log To Console    Standard price: ${price_std}     
    
    FOR    ${element}    IN RANGE    3    1    -1
        Sleep    5s    
        Click Element    class=save-minus    
    END
    
    Sleep    10s    
    ${quantity}=    Get Element Attribute    xpath=//span[@class='dynamic-quantity']/div/input    value
    Log To Console    quanity of payment: ${quantity}    
    ${quantity}=    Convert To Integer    ${quantity}    
    ${total_cal}=    Evaluate    ${price_std}*${quantity} 
    
    ${total_cart}=    Get Text    xpath=//td[@headers='view-total-price-number-table-column']
    ${total_cart}=    Remove String Using Regexp    ${total_cart}    \\D        
    ${total_cart}=    Convert To Integer    ${total_cart}   
    Log To Console    Total cart value: ${total_cal}        

    Should Be Equal As Integers    ${total_cal}    ${total_cart}

Clear and input text
    [Arguments]    ${text}
    Clear Element Text    xpath=//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Input Text    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    ${text}

Add to cart text change
    ${button_text}=    Get Element Attribute    xpath=//div[@class='kl_flood_sub_or_sec']/input    value
    Run Keyword If    'Add to cart'=='${button_text}'    Log To Console    "Button changed to ADD TO CART"    ELSE    Fail    "Button was not changed to ADD TO CART"

Add to cart button disable
    ${button_status}=    Run Keyword And Return Status    Element Should Be Disabled    xpath=//div[@class='kl_flood_sub_or_sec']/input
    Run Keyword If    'True'=='${button_status}'    Log To Console    "Button is disabled"    ELSE    Fail    "Button was not disabled"

Add to cart button enabled
    ${button_status}=    Run Keyword And Return Status    Element Should Be Enabled    xpath=//div[@class='kl_flood_sub_or_sec']/input
    Run Keyword If    'True'=='${button_status}'    Log To Console    "Button is enabled"    ELSE    Fail    "Button was not enabled"

Add to cart functionality
    
    Clear and input text    ${lesser_amount}
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    class=errorMessage
    Run Keyword If    'True'=='${status}'    Log To Console    "Minimum donation amount alert is displayed for amount: ${lesser_amount}"    ELSE    Fail    "Minimum donation amount alert was not displayed for amount: ${lesser_amount}"
    Add to cart button disable
    Sleep    5s
    
    Clear and input text    ${minimum_amount}
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    class=errorMessage
    Run Keyword If    'True'=='${status}'    Log To Console    "Minimum donation amount alert was not displayed for amount: ${minimum_amount}"    ELSE    Fail    "Minimum donation amount alert is displaying for amount: ${minimum_amount}"
    Add to cart button enabled
    Sleep    5s    

    Clear and input text    ${accurate_amount}
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    class=errorMessage
    Run Keyword If    'True'=='${status}'    Log To Console    "Minimum donation amount alert was not displayed for amount: ${accurate_amount}"    ELSE    Fail    "Minimum donation amount alert is displaying for amount: ${accurate_amount}"
    Add to cart button enabled
    Sleep    5s        
    
    Clear and input text    ${maximum_amount}        
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    class=errorMessage
    Run Keyword If    'True'=='${status}'    Log To Console    "Minimum donation amount alert was not displayed for amount: ${maximum_amount}    Fail    "Minimum donation amount alert is displaying for amount: ${maximum_amount}"
    Add to cart button enabled
    Sleep    5s
    
    Clear and input text    ${higher_amount}
    ${max_value}=    Get Element Attribute    xpath=//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    value
    Run Keyword If    '100000'=='${max_value}'    Log To Console    "Given amount '${higher_amount}' is changed to : ${max_value} in webpage"    ELSE    Fail    "Given amount is not changed to "₹100000"      
    Add to cart button enabled
    Sleep    5s

one time campaign - Where Most Needed Campaign
    
    Click Element    xpath=.//div[@class='item-image']//img
    ${camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    ${camp_name}=   Replace String    ${camp_name}    M    m
    ${camp_name}=   Replace String    ${camp_name}    N    n 
    
    Add to cart text change
    Add to cart functionality
                     
    Clear Element Text    xpath=//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Click Element    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Input Text    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    ${edu_child_amt}
    Sleep    5s    
    
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"    

    Click Element    xpath=//a[@class='view_cart']   
    ${camp_val}=    Replace String    ${edu_child_amt}    4    4,
    [Return]    ${camp_name}    ${camp_val}   
    
one time campaign - Help HIV aids Campaign
    Click Element    xpath=.//div[@class='item-image']//img
    ${camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    ${camp_name}=    Replace String    ${camp_name}    F    f
    ${camp_name}=    Replace String    ${camp_name}    a    A
    ${camp_name}=    Replace String    ${camp_name}    n    N
    ${camp_name}=    Replace String    ${camp_name}    d    D
    
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    Click Element    id=ChkForSI
    
    Add to cart text change
    Add to cart functionality

    Clear Element Text    xpath=//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Click Element    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    
    Input Text    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    ${edu_child_amt}
    Sleep    5s    

    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"    

    Click Element    xpath=//a[@class='view_cart']
    ${camp_val}=    Replace String    ${edu_child_amt}    4    4,
    [Return]    ${camp_name}    ${camp_val}
    
one time campaign - Hunger Free campaign
    
    Sleep    10s
    Click Element    xpath=.//div[@class='add-to-cart-section']
    ${camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    ${camp_name}=    Remove String    ${camp_name}    Free

    Add to cart text change
    Add to cart functionality
    
    Clear Element Text    xpath=//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Click Element    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']
    Input Text    xpath=.//input[@class='commerce_manual_input realgift_inputvalue realgift_input']    ${edu_child_amt}    
    Sleep    5s    
    
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"
        
    Click Element    xpath=//a[@class='view_cart']
    ${camp_val}=    Replace String    ${edu_child_amt}    4    4,
    [Return]    ${camp_name}    ${camp_val}    

check in view cart page - Checkout flow
    [Arguments]    ${camp_name}    ${camp_amt}
        
    ${camp_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${camp_name}')]
    Run Keyword If    'True'!='${camp_viewcart}'    Fail    "${camp_name} campaign not display in view cart page"
    ${camp_amt_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'${camp_amt}')]
    Run Keyword If    'True'!='${camp_amt_viewcart}'    Fail    "${camp_name} campaign amount are not display or mismatch in view cart page"   
    ${cart_quanity}=    Get Element Attribute    xpath=//span[@class='dynamic-quantity']//input    value
    
    [Return]    ${cart_quanity}
    
check in view cart page - One time donation flow
    [Arguments]    ${camp_name}    ${camp_amt}
        
    ${camp_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${camp_name}')]
    Run Keyword If    'True'!='${camp_viewcart}'    Fail    "${camp_name} campaign not display in view cart page"
    ${camp_amt_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-total-price__number views-align-center'][contains(.,'${camp_amt}')]
    Run Keyword If    'True'!='${camp_amt_viewcart}'    Fail    "${camp_name} campaign amount are not display or mismatch in view cart page"   
    ${cart_quanity}=    Get Text    class=dynamic-quantity
    
    [Return]    ${cart_quanity}   


CCavenue payment - cart verification
    [Arguments]    ${camp_name}    ${Camp_val}    ${cart_quanity}
    
    Sleep    20s    
    Banner Alert    
    ${order_status}=    Get Text   xpath=//div[@class='payment-success-message1']/p
    Log To Console    ${order_status}
    ${status_campaign}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[contains(text(),'${camp_name}')]
    Run Keyword If    'True'=='${status_campaign}'    Log To Console    "${camp_name} is displayed in payment page"    ELSE    Fail    "${camp_name} was not displayed in payment page"      
    ${campaign_quanity}=    Get Text    class=dynamic-quantity
    Run Keyword If    '${cart_quanity}'=='${campaign_quanity}'    Log To Console    "campaign quantity ${campaign_quanity} is displayed in payment page"    ELSE    Fail    "campaign quantity ${cart_quanity} was not displayed in payment page"   
    ${status_price}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[contains(text(),'${camp_val}')]
    Run Keyword If    'True'=='${status_price}'    Log To Console    "${camp_val} campaign value is displayed in payment page"    ELSE    Fail    "${camp_val} campaign value was not displayed in payment page"    

Total cart value
    ${total_cart_value}=    Get Text    xpath=//div[contains(@class,'order-total-line__total')]/span[2]
    ${total_cart_value}=    Remove String Using Regexp    ${total_cart_value}    \\D        
    ${total_cart_value}=    Convert To Integer    ${total_cart_value}
    
    [Return]    ${total_cart_value}
    
check in view cart page - dynamic
    [Arguments]    ${camp_name}    ${camp_amt}
        
    ${camp_viewcart}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${camp_name}')]
    Run Keyword If    'True'!='${camp_viewcart}'    Fail    "${camp_name} campaign not display in view cart page"
    ${camp_amt_viewcart}=    Get Text    xpath=//td[@class='views-field views-field-product-id'][contains(.,'${camp_name}')]/following-sibling::td[3]
    ${camp_amt_viewcart}=    Remove String Using Regexp    ${camp_amt_viewcart}    \\D        
    ${camp_amt_viewcart}=    Convert To Integer    ${camp_amt_viewcart}
    Run Keyword If    ${camp_amt}!=${camp_amt_viewcart}    Fail    "${camp_name} campaign amount are not display or mismatch in view cart page"   
    ${cart_quanity}=    Get Element Attribute    xpath=//span[@class='dynamic-quantity']//input    value
    
    [Return]    ${cart_quanity}
    
CCavenue payment - cart verification - dynamic
    [Arguments]    ${camp_name}    ${Camp_val}    ${cart_quanity}
    
    Sleep    20s    
    Banner Alert    
    ${order_status}=    Get Text   xpath=//div[@class='payment-success-message1']/p
    Log To Console    ${order_status}
    ${status_campaign}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[contains(text(),'${camp_name}')]
    Run Keyword If    'True'=='${status_campaign}'    Log To Console    "${camp_name} is displayed in payment page"    ELSE    Fail    "${camp_name} was not displayed in payment page"      
    ${campaign_quanity}=    Get Text    xpath=//td[contains(text(),'${camp_name}')]/following-sibling::td[2]//span
    Run Keyword If    '${cart_quanity}'=='${campaign_quanity}'    Log To Console    "campaign quantity ${campaign_quanity} is displayed in payment page"    ELSE    Fail    "campaign quantity ${cart_quanity} was not displayed in payment page"   
    # ${status_price}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[contains(text(),'${camp_val}')]
    # Run Keyword If    'True'=='${status_price}'    Log To Console    "${camp_val} campaign value is displayed in payment page"    ELSE    Fail    "${camp_val} campaign value was not displayed in payment page"
    ${camp_amt_paygt}=    Get Text    xpath=//td[contains(text(),'${camp_name}')]/following-sibling::td[3]
    ${camp_amt_paygt}=    Remove String Using Regexp    ${camp_amt_paygt}    \\D        
    ${camp_amt_paygt}=    Convert To Integer    ${camp_amt_paygt}
    Run Keyword If    ${Camp_val}!=${camp_amt_paygt}    Fail    "${camp_name} campaign amount are not display or mismatch in view cart page"    ELSE    Log To Console    ${camp_name} campaign amount is ${camp_amt_paygt}   
    
Event Page menu check
    [Arguments]    ${submenu}    

    Mouse Over    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Media')]    
    ${count}=    Get Element Count    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Media')]//parent::li//li/a        
    Run Keyword If    '${count}'!='4'    Fail    Media submenus are not matching
    Mouse Over    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Media')]
    @{media_list}=    Get WebElements    xpath=//div[@class='main-menu-inner']//*[contains(text(),'Media')]//parent::li//li/a
    FOR    ${element}    IN    @{media_list}
        ${text}=    Get Text    ${element}
        Log To Console    Media submenus are : ${text} 
    END        
    Click Element    xpath=//div[@class='main-menu-inner']//*[contains(text(),'${submenu}')]
    
Event Submenu Check
    [Arguments]    ${submenu}
    
    Wait Until Element Is Visible    xpath=//span[contains(text(),'${submenu}')]    30s    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//span[contains(text(),'${submenu}')]    
    Run Keyword If    '${status}'!='True'    Fail    Page doesnt redirect to News Articles

Event page filter
    [Arguments]    ${month}    ${year}    ${language}
    
    Scroll Element Into View    xpath=//input[contains(@id,'edit-submit-press-releases')]
    Select From List By Label    id=edit-field-month-target-id    ${month}
    Select From List By Label    id=edit-field-releases-year-target-id    ${year}
    Select From List By Label    id=edit-field-tags-target-id    ${language}
    
    Click Element    xpath=//input[contains(@id,'edit-submit-press-releases')]

Event page filter verification    
    [Arguments]    ${month_input}    ${year_input}
    
    ${month_sort}=    Get Substring    ${month_input}    0    3
    #Element Should Be Visible    xpath=//div[@class='media-press-page pressres']    
    ${month}=    Get Text    xpath=//div[@class='media-press-page pressres']//span[@class='media-mont']
    Run Keyword If    '${month_sort}'!='${month}'    Fail    Month mismatch or No data found
    ${year}=    Get Text    xpath=//div[@class='media-press-page pressres']//span[@class='media-year']
    Run Keyword If    '2019'!='${year}'    Fail    Month mismatch or No data found

Kerala flood campaign
    [Arguments]    ${value}
    
    ${campaign_name}=    Get Text    xpath=(//div[@class='emergency_flood_relief_content'])[${value}]/div[1]
    ${campaign_amt}=    Get Text    xpath=(//div[@class='emergency_flood_relief_content'])[${value}]/div[4]
    ${campaign_amt}=    Remove String Using Regexp    ${campaign_amt}    \\D        
    ${campaign_amt}=    Convert To Integer    ${campaign_amt}
    Log To Console     Campain name is: ${campaign_name} donation is : ${campaign_amt}
    
    [Return]    ${campaign_name}    ${campaign_amt}

Cart campaign check and delete    
    ${get_viewcart_list_count}=    Get Element Count    xpath=//tbody/tr/td[starts-with(@headers,'view-product-')]        
    ${get_viewcart_list_count}=    Convert To Integer    ${get_viewcart_list_count}            
    Run Keyword If    ${get_viewcart_list_count} < 1    Log To Console    "No campaign in view cart page"    ELSE    Notification deletion    ${get_viewcart_list_count}

CCavenue payment - failure cart verification
    [Arguments]    ${camp_name}    ${Camp_val}    ${cart_quanity}
    
    Sleep    20s    
    Banner Alert        
    ${status_campaign}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[contains(text(),'${camp_name}')]
    Run Keyword If    'True'=='${status_campaign}'    Log To Console    "${camp_name} is displayed in payment page"    ELSE    Fail    "${camp_name} was not displayed in payment page"      
    ${campaign_quanity}=    Get Text    xpath=//td[contains(text(),'${camp_name}')]/following-sibling::td[2]//span
    Run Keyword If    '${cart_quanity}'=='${campaign_quanity}'    Log To Console    "campaign quantity ${campaign_quanity} is displayed in payment page"    ELSE    Fail    "campaign quantity ${cart_quanity} was not displayed in payment page"   
    # ${status_price}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//td[contains(text(),'${camp_val}')]
    # Run Keyword If    'True'=='${status_price}'    Log To Console    "${camp_val} campaign value is displayed in payment page"    ELSE    Fail    "${camp_val} campaign value was not displayed in payment page"
    ${camp_amt_paygt}=    Get Text    xpath=//td[contains(text(),'${camp_name}')]/following-sibling::td[3]
    ${camp_amt_paygt}=    Remove String Using Regexp    ${camp_amt_paygt}    \\D        
    ${camp_amt_paygt}=    Convert To Integer    ${camp_amt_paygt}
    Run Keyword If    ${Camp_val}!=${camp_amt_paygt}    Fail    "${camp_name} campaign amount are not display or mismatch in view cart page"    ELSE    Log To Console    ${camp_name} campaign amount is ${camp_amt_paygt}   

Convert to price
    [Arguments]    ${price_std}

    ${price_std}=    Remove String Using Regexp    ${price_std}    \\D        
    ${price_std}=    Convert To Integer    ${price_std}
    
    [Return]    ${price_std}

Why do you want to quit - PopUp
    Sleep    5s    
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//p[contains(text(),'Why do you want to quit?')]/preceding-sibling::span    
    Run Keyword If    'True'=='${status}'    Click Element    xpath=//p[contains(text(),'Why do you want to quit?')]/preceding-sibling::span

Checkout flow campaign - HIV
    Click Element    xpath=.//div[@class='item-image']//img
    ${camp_name}=    Get Text    xpath=.//div[@class='inner_banner_pledge_content']/h2/div
    ${camp_name}=    Get Substring    ${camp_name}    11    14
    ${label_val}=    Get Text    xpath=//label[contains(text(),'3 Months')]
    #${label_val}=    Get Text    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    ${Camp_amt}=    Get Substring    ${label_val}    9    16
    Log To Console    Final val is: ${camp_amt}
    Sleep    15s
    
    Wait Until Element Is Visible    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label    15s    
    Click Element    xpath=(//div[@class='price save-malnourished-cart-sec'])[2]/label
    Sleep    10s    
    Click Element    id=ChkForSI
    
    Add to cart text change
    
    Click Element    xpath=//div[@class='kl_flood_sub_or_sec']
    
    ${success_mgs}=    Get Text    xpath=.//h2[@class='chat-text']
    Run Keyword If    '${success_mgs}'!='Success !'    Fail    "Success ! msg not found"    

    Click Element    xpath=//a[@class='view_cart']
    
    # ${view_cart_amount}=    Get Text    xpath=//td[@class='views-field views-field-total-price__number views-align-center']
    # Log To Console    View cart page campaign amount: ${view_cart_amount}
    
    [Return]    ${camp_name}    ${camp_amt}
    
Proceed to autopay text change
    ${button_text}=    Get Text    xpath=//div[@class='SIPopBlock']/div[3]//button
    Run Keyword If    'PROCEED TO AUTOPAY'=='${button_text}'    Log To Console    "Button changed to PROCEED TO AUTOPAY"    ELSE    Fail    "Button was not changed to  PROCEED TO AUTOPAY"    
    
Add to cart functionality - Gift catalog
    
    Clear and input text - Gift catalog    ${lesser_amount}
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='realgift_input_value commerce_manual_inputs']/p)[1]
    Run Keyword If    'True'=='${status}'    Log To Console    "Minimum donation amount alert is displayed for amount: ${lesser_amount}"    ELSE    Fail    "Minimum donation amount alert was not displayed for amount: ${lesser_amount}"
    Add to cart button disable - Gift catalog
    Sleep    5s
    
    Clear and input text - Gift catalog    ${minimum_amount}
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='realgift_input_value commerce_manual_inputs']/p)[1]
    Run Keyword If    'True'=='${status}'    Log To Console    "Minimum donation amount alert was not displayed for amount: ${minimum_amount}"    ELSE    Fail    "Minimum donation amount alert is displaying for amount: ${minimum_amount}"
    Add to cart button enabled - Gift catalog
    Sleep    5s    

    Clear and input text - Gift catalog    ${accurate_amount}
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='realgift_input_value commerce_manual_inputs']/p)[1]
    Run Keyword If    'True'=='${status}'    Log To Console    "Minimum donation amount alert was not displayed for amount: ${accurate_amount}"    ELSE    Fail    "Minimum donation amount alert is displaying for amount: ${accurate_amount}"
    Add to cart button enabled - Gift catalog
    Sleep    5s        
    
    Clear and input text - Gift catalog    ${maximum_amount}        
    ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='realgift_input_value commerce_manual_inputs']/p)[1]
    Run Keyword If    'True'=='${status}'    Log To Console    "Minimum donation amount alert was not displayed for amount: ${maximum_amount}    ELSE    Fail    "Minimum donation amount alert is displaying for amount: ${maximum_amount}"
    Add to cart button enabled - Gift catalog
    Sleep    5s
    
    Clear and input text - Gift catalog    ${higher_amount}
    ${max_value}=    Get Element Attribute    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='realgift_input_value commerce_manual_inputs']/input)[1]    value
    Run Keyword If    '100000'=='${max_value}'    Log To Console    "Given amount '${higher_amount}' is changed to : ${max_value} in webpage"    ELSE    Fail    "Given amount is not changed to "₹100000"      
    Add to cart button enabled - Gift catalog
    Sleep    5s

Clear and input text - Gift catalog
    [Arguments]    ${text}
    Clear Element Text    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='realgift_input_value commerce_manual_inputs']/input)[1]
    Input Text    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='realgift_input_value commerce_manual_inputs']/input)[1]    ${text}

Add to cart button disable - Gift catalog
    ${button_status}=    Run Keyword And Return Status    Element Should Be Disabled    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='kl_flood_sub_or_sec']/input)[1]
    Run Keyword If    'True'=='${button_status}'    Log To Console    "Button is disabled"    ELSE    Fail    "Button was not disabled"
Add to cart button enabled - Gift catalog
    ${button_status}=    Run Keyword And Return Status    Element Should Be Enabled    xpath=(.//div[@class='gift-catelogue']/div[1]//following-sibling::article/div[@id='mySidenav']//div[@class='kl_flood_sub_or_sec']/input)[1]
    Run Keyword If    'True'=='${button_status}'    Log To Console    "Button is enabled"    ELSE    Fail    "Button was not enabled"

Mouse hover ways to give after login
    [Arguments]    ${submenu}
    
    Mouse Over    xpath=//li/span[contains(.,'Ways to Give')]
    Click Element    xpath=//li/a[contains(.,'${submenu}')]

Banner text check should not visible
    [Arguments]    ${content}
    
    ${banner_count}=    Get Element Count    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide')]
    FOR    ${element}    IN RANGE    1    ${banner_count}+1
        Click Element    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide ${element}')]
        ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//div[@class='banner-content']/h2[contains(text(),'${content}')]
        Run Keyword If    '${status}'!='True'    Fail    Tax banner is Visible out of the month match and april    ELSE    Log To Console    Banner is not visible   
    END

Banner text check should be visible
    [Arguments]    ${content}
    
    ${banner_count}=    Get Element Count    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide')]
    FOR    ${element}    IN RANGE    1    ${banner_count}+1
        Click Element    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide ${element}')]
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class='banner-content']/h2[contains(text(),'${content}')]        
        Run Keyword If    '${status}'!='True'    Fail    Tax banner was not Visible    ELSE    Log To Console    Banner is visible   
    END
    
Payment failure check in home page banner - Click
    [Arguments]    ${content}
    
    ${banner_count}=    Get Element Count    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide')]
    ${banner_count}=    Convert To Integer    ${banner_count}    
    FOR    ${element}    IN RANGE    1    ${banner_count}+1
        Click Element    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide ${element}')]
        Capture Page Screenshot
        ${status}=    Run Keyword And Return Status    Element Should Contain    xpath=//div[@class='banner-content']/a[contains(text(),'${content}')]    ${content}            
        Run Keyword If    '${status}'=='True'    Click Element    xpath=//div[@class='banner-content']/a[contains(text(),'${content}')]    
        Exit For Loop If    '${status}'=='True'
    END            
    Run Keyword If    '${status}'!='True'    Fail    Payment failure banner was not found

today date complete    
    ${today_date}=    Get Current Date    result_format=%Y-%m-%d
    ${today_date}=    Convert Date    ${today_date}    datetime

    [Return]    ${today_date}

get DOB from my profile
    ${dob}=    Get Text    xpath=//div[contains(@class,'date-of-birth')]/div[2]
    ${year}=    Get Substring    ${dob}    6    11        
    ${dob}=    Replace String    ${dob}    ${year}    2021    
    ${dob_coverted}=    Convert Date    ${dob}    date_format=%m/%d/%Y    result_format=%Y/%m/%d
    Log To Console    ${dob_coverted}    

    [Return]    ${dob_coverted}

no of days have calculation
    [Arguments]    ${dob_coverted}    ${today_date}
    
    ${numberofdays}=    Subtract Date From Date    ${dob_coverted}    ${today_date}    verbose
    ${days_have}=    Convert To String    ${numberofdays}
    ${days_have}=    Remove String Using Regexp    ${days_have}    \\D
    ${days_have}=    Convert To Integer    ${days_have}
    
    Log To Console    No of days ${days_have}        
    
    [Return]    ${days_have}

Banner check birthday
    [Arguments]    ${content}
    
    Click Element    xpath=//div[@class='header_new_logo']//a    
    Sleep    15s    
    ${banner_count}=    Get Element Count    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide')]
    ${banner_count}=    Convert To Integer    ${banner_count}    
    FOR    ${element}    IN RANGE    1    ${banner_count}+1
        Click Element    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide ${element}')]
        Capture Page Screenshot
        ${status}=    Run Keyword And Return Status    Element Should Contain    xpath=//div[@class='banner-content']/a[contains(text(),'${content}')]    ${content}            
        Run Keyword If    '${status}'=='True'    Log To Console    Birthday banner is visible        
        Exit For Loop If    '${status}'=='True'
    END            
    Run Keyword If    '${status}'!='True'    Fail    Birthday banner was not visible

Banner check birthday - should not visible
    [Arguments]    ${content}
    
    Click Element    xpath=//div[@class='header_new_logo']//a    
    Sleep    15s    
    ${banner_count}=    Get Element Count    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide')]
    ${banner_count}=    Convert To Integer    ${banner_count}    
    FOR    ${element}    IN RANGE    1    ${banner_count}+1
        Click Element    xpath=//div[@class='swiper-wrapper']/following-sibling::div//span[contains(@aria-label,'Go to slide ${element}')]
        Capture Page Screenshot
        ${status}=    Run Keyword And Return Status    Element Should Not Be Visible    xpath=//div[@class='banner-content']/a[contains(text(),'${content}')]
        Run Keyword If    '${status}'=='True'    Log To Console    Birthday banner is not visible        
        Exit For Loop If    '${status}'=='True'
    END            
    Run Keyword If    '${status}'!='True'    Fail    Birthday banner is visible

Password matching check
    
    Wait Until Element Is Visible    id=edit-pass-pass1    20s
    Click Element    //label[@for='edit-pass-pass1']    
    Input Text    id=edit-pass-pass1    ${pass1}
    
    Wait Until Element Is Visible    id=edit-pass-pass2    20s
    Click Element    //label[@for='edit-pass-pass2']    
    Input Text    id=edit-pass-pass2    ${pass1}

    Sleep    3s         
             
    ${password}=    Get Element Attribute    xpath=//div[contains(@class,'password-confirm')]/span    class
    Run Keyword If    '${password}'!='ok'    Fail    Password doesnt match icon visible    ELSE    Log To Console    Password is matching icon visible


Password doesnt matching check
    
    Clear Element Text    id=edit-pass-pass1
    Click Element    //label[@for='edit-pass-pass1']    
    Input Text    id=edit-pass-pass1    ${pass1}
    
    Clear Element Text    id=edit-pass-pass2
    Click Element    //label[@for='edit-pass-pass2']    
    Input Text    id=edit-pass-pass2    ${pass2}
    
    Sleep    3s        
    
    ${password}=    Get Element Attribute    xpath=//div[contains(@class,'password-confirm')]/span    class
    Run Keyword If    '${password}'!='error'    Fail    Password is matching icon visible    ELSE    Log To Console    Password doesnt match icon visible

Finish Testcase
    Sleep    10s    
    Close All Browsers