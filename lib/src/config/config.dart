const SERVER_NAME = "http://localhost:58057";
//const SERVER_NAME = "http://qlptch.petrolimexsg.com.vn/PSTMS";
const URL_TESTPLAN = "$SERVER_NAME/ApiMobile/TestPlan/GetAll";
const URL_TESTASSIGNMENT_LATEST = "$SERVER_NAME/ApiMobile/TestAssignment/GetTestAssignment_Latest/?token=";
const URL_TATESTDATE_LATEST = "$SERVER_NAME/ApiMobile/TestAssignment/GetTATestDate_Latest/?token=";
const URL_TESTASSIGNMENT_BYTOKEN = "$SERVER_NAME/ApiMobile/TestAssignment/GetTestAssignment_ByToken/?token=";
const URL_TESTCOMPANY_BYTESTDATEID = "$SERVER_NAME/ApiMobile/TestAssignment/GetTestCompany_ByTestDateID/";
const URL_GETTESTDATE_BYTASSIGNMENTID = "$SERVER_NAME/ApiMobile/TestAssignment/GetTestDate_ByTestAssignmentID/?id=";
const URL_TESTASSIGNMENTDETAIL = "$SERVER_NAME/ApiMobile/TestAssignment/Detail/?id=";
const URL_CREATEFCM = "$SERVER_NAME/ApiMobile/FCM/SaveToken";
const URL_SIGNIN = "$SERVER_NAME/ApiMobile/Auth/SignIn";
const URL_CHANGEPASSWORD = "$SERVER_NAME/ApiMobile/Auth/ChangePassword";
const URL_GETINFOEMPLOYEE = "$SERVER_NAME/ApiMobile/Auth/GetInfoEmployee/?token=";
const URL_GETNOTIFICATION = "$SERVER_NAME/ApiMobile/Notification/GetNotification/?token=";
const URL_REMOVENOTIFICATION = "$SERVER_NAME/ApiMobile/Notification/REMOVENotification/?id=";
const URL_SIGNOUT = "$SERVER_NAME/ApiMobile/Auth/SignOut/?token=";

//key
String FCM_token = 'FCM_TOKEN';
String login = 'NO';
