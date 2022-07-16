////
////  GoogleLoginData.swift
//
//
//import Foundation
//import AuthenticationServices
//import GoogleSignIn
//
//struct SocialLoginDataModel {
//
//    init() {
//
//    }
//
//    var socialId: String!
//    var loginType: String!
//    var firstName: String!
//    var lastName: String!
//    var email: String!
//    var profileImage: String?
//}
//
//protocol SocialLoginDelegate: AnyObject {
//    func socialLoginData(data: SocialLoginDataModel)
//}
//
//class SocialLoginManager: NSObject, GIDSignInDelegate, ASAuthorizationControllerDelegate {
//
//    //MARK: Class Variable
//    weak var delegate: SocialLoginDelegate? = nil
//
//    //init
//    override init() {
//
//    }
//}
//
////MARK: Google Login
//extension SocialLoginManager {
//    //MARK: Google login methods
//    /// Open google login view
//    func performGoogleLogin(vc: UIViewController) {
//        GIDSignIn.sharedInstance()?.delegate = self
//        GIDSignIn.sharedInstance()?.presentingViewController = vc
//        GIDSignIn.sharedInstance()?.signOut()
//        GIDSignIn.sharedInstance()?.signIn()
//    }
//}
//
////MARK: Google login delegate
//extension SocialLoginManager {
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            print(error.localizedDescription)
//
//        } else {
//            //Call delegate
//            if let delegate = self.delegate {
//
//                var dataObj: SocialLoginDataModel = SocialLoginDataModel()
//                dataObj.socialId = user.userID
//                dataObj.loginType = "G"
//                dataObj.firstName = user.profile?.givenName
//                dataObj.lastName = user.profile?.familyName
//                dataObj.email = user.profile?.email
//                //GFunction.shared.firebaseRegister(data: dataObj.email)
//                if user.profile!.hasImage {
//                    dataObj.profileImage = user.profile?.imageURL(withDimension: 100)?.description
//                }
//                delegate.socialLoginData(data: dataObj)
//            }
//        }
//    }
//}
//
////MARK : Apple Login
//extension SocialLoginManager {
//
//    //MARK: Apple Login Methods
//    /// Open apple login view
//    @available(iOS 13.0, *)
//    func performAppleLogin() {
//
//        //request
//        let appleIdProvider = ASAuthorizationAppleIDProvider()
//        let authoriztionRequest = appleIdProvider.createRequest()
//        authoriztionRequest.requestedScopes = [.fullName, .email]
//
//        //Apple’s Keychain sign in // give the resukt of save id - password for this app
//        let passwordProvider = ASAuthorizationPasswordProvider()
//        let passwordRequest = passwordProvider.createRequest()
//
//        //create authorization controller
//        let authorizationController = ASAuthorizationController(authorizationRequests: [authoriztionRequest]) //[authoriztionRequest, passwordRequest]
//        authorizationController.presentationContextProvider = self
//        authorizationController.delegate = self
//        authorizationController.performRequests()
//    }
//}
//
////MARK : Apple Login Delegate
//@available(iOS 13.0, *)
//extension SocialLoginManager: ASAuthorizationControllerPresentationContextProviding {
//
//    @available(iOS 13.0, *)
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
////        return UIApplication.topViewController()!.view.window!
//        return UIApplication.topViewController()!.view.window!
//    }
//
//    @available(iOS 13.0, *)
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
//        print(appleIDCredential.user, appleIDCredential.fullName as Any, appleIDCredential.email as Any)
//        var dataObj: SocialLoginDataModel = SocialLoginDataModel()
//        dataObj.socialId = appleIDCredential.user
//        dataObj.loginType = "A"
//        dataObj.firstName =  appleIDCredential.fullName?.givenName ?? ""
//        dataObj.lastName = appleIDCredential.fullName?.familyName ?? ""
//        dataObj.email = appleIDCredential.email ?? ""
//        delegate?.socialLoginData(data: dataObj)
//
//    }
//
//    @available(iOS 13.0, *)
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
////        Alert.shared.showAlert(message: "Something went wrong", completion: nil)
//    }
//}
//
//
//////MARK: Facebook Login
////extension SocialLoginManager {
////    //MARK: Facebook login methods
////    /// Open facebook login view
////    func performFacebookLogin() {
////        let loginManager = LoginManager()
////        loginManager.logOut()
//////        loginManager.authType = .rerequest
//////        AccessToken.current = nil
//////        Profile.current = nil
////        let cookies = HTTPCookieStorage.shared
////        let facebookCookies = cookies.cookies(for: URL(string: "https://facebook.com/")!)
////        for cookie in facebookCookies! {
////            cookies.deleteCookie(cookie )
////        }
////
////        loginManager.logIn(permissions: ["public_profile","email"], from: UIApplication.topViewController()){ (loginResult, error) in
////            if loginResult?.isCancelled ?? false {
////                return
////            }
////
////            if error == nil {
////                let req = GraphRequest(graphPath: "me", parameters: ["fields":  "id, name, first_name, last_name, gender, email, birthday, picture.type(large)"])
////
////                req.start(completion: {(connection, response, error) in
////
////                    let resData = JSON(response as Any)
////
////                    //Call delegate
////                    if let delegate = self.delegate {
////                        var dataObj: SocialLoginDataModel = SocialLoginDataModel()
////                        dataObj.socialId = resData["id"].stringValue
////                        dataObj.loginType = "F"
////                        dataObj.firstName = resData["first_name"].stringValue
////                        dataObj.lastName = resData["last_name"].stringValue
////                        dataObj.email = resData["email"].stringValue
////                        GFunction.shared.firebaseRegister(data: dataObj.email)
////                        delegate.socialLoginData(data: dataObj)
////                    }
////
////                })
////            } else if error != nil {
////                Alert.shared.showAlert(message: error?.localizedDescription ?? "", completion: nil)
////            }
////        }
////    }
////}
