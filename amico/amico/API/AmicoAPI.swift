//
//  AmicoAPI.swift
//  amico
//
//  Created by Yuriy B. on 4/12/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import Alamofire
import FXKeychain

final class AmicoAPI {
    static let sharedInstance = AmicoAPI()
}

extension AmicoAPI {
    //MARK:- Auth Methods
    func signInUser(username: String, password: String, completion: (success: Bool, token: String?) -> Void) {
        Alamofire.request(APIRouterURLEncoded.SignIn(username: username, password: password)).responseJSON { response in
            guard let token = response.result.value?.valueForKey("token") as? String else {
                completion(success: response.result.isSuccess, token: nil)
                return
            }

            FXKeychain.defaultKeychain().setObject(token, forKey: GlobalConstants.Authentification.Token)
            completion(success: response.result.isSuccess, token: token)
        }
    }

    func signUpUser(username: String, password: String, completion: (success: Bool, token: String?) -> Void) {
        Alamofire.request(APIRouterURLEncoded.SignUp(username: username, password: password)).responseJSON { response in
            guard let token = response.result.value?.valueForKey("token") as? String else {
                completion(success: response.result.isSuccess, token: nil)
                return
            }

            FXKeychain.defaultKeychain().setObject(token, forKey: GlobalConstants.Authentification.Token)
            completion(success: response.result.isSuccess, token: token)
        }
    }

    func logOutUser() {
        FXKeychain.defaultKeychain().removeObjectForKey(GlobalConstants.Authentification.Token)
    }

    func userIsLogedIn() -> Bool {
        guard let _ = FXKeychain.defaultKeychain().objectForKey(GlobalConstants.Authentification.Token) else {
            return false
        }
        return true
    }

    func getCurrentToken(completion: (success: Bool, token: String?) -> Void) {
        Alamofire.request(APIRouter.Token).responseJSON { response in
            completion(success: response.result.isSuccess, token: response.result.value?.valueForKey("token") as? String)
        }
    }

    //MARK:- Profile
    func editUserProfile(gender: String?, about: String?, employments: [String]?, educations: [String]?, interests: [String]?, birthDay: String?, completion: (success: Bool, token: String?) -> Void) {
        Alamofire.request(APIRouter.EditProfile(gender: gender, about: about, employments: employments, educations: educations, interests: interests, birthDay: birthDay)).responseJSON { response in
            completion(success: response.result.isSuccess, token: response.result.value?.valueForKey("token") as? String)
        }
    }

    func editUserGeolocationCoordinates(latitude: String, longitude: String, completion: (success: Bool, token: String?) -> Void) {
        Alamofire.request(APIRouter.EditProfileGeolocation(lat: latitude, long: longitude)).responseJSON { response in
            completion(success: response.result.isSuccess, token: response.result.value?.valueForKey("token") as? String)
        }
    }

    func addAvatar(picture: UIImage, completion: (success: Bool, token: String?) -> Void) {
        guard let avatar = UIImageJPEGRepresentation(picture, 1.0) else {
            print("Image conversion to NSData failed")
            return
        }
        Alamofire.request(APIRouter.UploadAvatar(avatar: avatar)).responseJSON { response in
            completion(success: response.result.isSuccess, token: response.result.value?.valueForKey("token") as? String)
        }
    }

    func deleteProfile(completion: (success: Bool, token: String?) -> Void) {
        Alamofire.request(APIRouter.DeleteProfile).responseJSON { response in
            completion(success: response.result.isSuccess, token: response.result.value?.valueForKey("token") as? String)
        }
    }
}