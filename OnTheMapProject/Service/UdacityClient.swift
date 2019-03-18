//
//  UdacityClient.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 1/3/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import Foundation

class UdacityClient {
    
    // MARK: Parameters
    
    enum Endpoints {
     
        static let baseUrl = "https://onthemap-api.udacity.com/v1"
        
        case login
        case logout
        case signUp
        case getUser(String)
       
        
        var stringValue: String {
            switch self {
                
            case .login, .logout:
                return Endpoints.baseUrl + "/session"
            case .getUser(let userId):
                return (Endpoints.baseUrl + "/users/\(userId)")
            case .signUp:
                return "https://auth.udacity.com/sign-up"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
    // The HTTP methods used by Udacity and Parse API client.
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    class func userlogin(username: String, password: String, completionHandler: @escaping (Account?, Session?, Error?) -> Void) {
        
        let bodyText = """
        {
        "udacity": {
        "username": "\(username)",
        "password": "\(password)"
        }
        }
        """
        
        taskForPOSTRequest(url: Endpoints.login.url, responseType: LoginRequest.self, body: bodyText){ response, error in
            if let response = response {
                completionHandler(response.account, response.session, error)
            } else {
                completionHandler(nil, nil, error)
            }
        }
    }
    
    class func getUserInfo(userID: String, completionHandler : @escaping (User?, Error?) -> Void) {
        let url = Endpoints.getUser(userID).url
        _ = taskForGETRequest(url: url, responseType: User.self) {
            user, error in
            if let user = user {
                completionHandler(user, nil)
            } else {
                
                completionHandler(nil, error)
            }
           
        }
    }
    
    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        let url = Endpoints.logout.url
        _ = taskForDeleteRequest(url: url) { isSuccessful, error in
            completion(isSuccessful, error)
        }
    }
    
    // HTTP Request Methods
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let newData = data.subdata(in: 5..<data.count)
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    print(responseObject)
                    completion(responseObject, nil)
                }
             } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: newData) as Error
                    DispatchQueue.main.async {
                        print(errorResponse)
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        print(error)
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        
        return task
    }
    
   class func taskForPOSTRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: String, completion: @escaping (ResponseType?, Error?) -> Void) {
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: .utf8)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let newData = data.subdata(in: 5..<(data.count))
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    print(error)
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: newData) as Error
                    DispatchQueue.main.async {
                        print(errorResponse)
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        print(error)
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func taskForDeleteRequest(url: URL, completion: @escaping (Bool, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error == nil { // Handle error…
                return completion(true, error)
            } else {
                return completion(false, error)
            }
            
//            let range = Range(5..<data!.count)
//            let newData = data?.subdata(in: range) /* subset response data! */
//            print(String(data: newData!, encoding: .utf8)!)
            
        }
        task.resume()
    }

}


