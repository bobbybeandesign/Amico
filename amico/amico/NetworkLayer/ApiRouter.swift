//
//  ApiRouter.swift
//  amico
//
//  Created by Yuriy B. on 4/12/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {

    static let baseURL = NSURL(string: "http://dev.aisnovations.com:3000")!

    case SignIn(username: String, password: String)
    case SignUp(username: String, password: String)
    case EditProfile(gender: String?,
        about: String?,
        employments: [String]?,
        educations: [String]?,
        interests: [String]?,
        birthDay: String?)
    case EditProfileGeolocation(lat: String, long: String)
    case DeleteProfile
    case UploadAvatar(avatar: NSData)
    case Token
    case SetProfileVisibility(hidden: Bool)

    var URL: NSURL {
        return APIRouter.baseURL.URLByAppendingPathComponent(route.path)
    }

    var route: (path: String, params: [String: AnyObject]?, method:Alamofire.Method) {
        switch self {
        case .SignIn(let username, let password):
            let params: [String : AnyObject]?  = ["username" : username, "password" : password]
            return ("/public/token", params, .GET)

        case .SignUp(let username, let password):
            let params: [String : AnyObject]? = ["username" : username, "password" : password]
            return ("/public/profile", params, .POST)

        case .EditProfile(let gender, let about, let employments, let educations, let interests, let birthDay):
            var params: [String : AnyObject]? = Dictionary()
            if let gender = gender {
                params?["gender"] = gender
            }
            if let about = about {
                params?["about"] = about
            }
            if let employments = employments {
                params?["employments"] = employments
            }
            if let educations = educations {
                params?["educations"] = educations
            }
            if let interests = interests {
                params?["interests"] = interests
            }
            if let birthDay = birthDay {
                params?["birthDay"] = birthDay
            }
            return ("/profile", params, .PUT)

        case .EditProfileGeolocation(let latitude, let longitude):
            let params = ["lat" : latitude, "long" : longitude]
            return ("/profile/geo", params, .PUT)

        case .UploadAvatar(let avatar):
            let params = ["avatar" : avatar]
            return ("/profile/avatar", params, .POST)

        case .Token:
            return("/profile/token", nil, .GET)

        case .SetProfileVisibility(let hidden):
            let params = ["hide" : hidden]
            return("/profile/hide", params, .POST)

        case .DeleteProfile:
            return("/profile", nil, .DELETE)
        }
    }

    var URLRequest: NSMutableURLRequest {
        let request = Alamofire.ParameterEncoding.JSON.encode(NSURLRequest(URL: URL), parameters: (route.params ?? nil)).0
        request.HTTPMethod = route.method.rawValue
        return request
    }
}

//TODO:- Remove this
//this is temporary until the backend is unified under a single enconding scheme
enum APIRouterURLEncoded: URLRequestConvertible {
    static let baseURL = NSURL(string: "http://dev.aisnovations.com:3000")!

    case SignIn(username: String, password: String)
    case SignUp(username:String, password: String)

    var URL: NSURL {
        return APIRouterURLEncoded.baseURL.URLByAppendingPathComponent(route.path)
    }

    var route: (path: String, params: [String: AnyObject]?, method:Alamofire.Method) {
        switch self {
        case .SignIn(let username, let password):
            let params: [String : AnyObject]?  = ["username" : username, "password" : password]
            return ("/public/token", params, .GET)

        case .SignUp(let username, let password):
            let params: [String : AnyObject]? = ["username" : username, "password" : password]
            return ("/public/profile", params, .POST)
        }
    }

    var URLRequest: NSMutableURLRequest {
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = route.method.rawValue
        request = Alamofire.ParameterEncoding.URL.encode(request, parameters: (route.params ?? nil)).0
        return request
    }
}
