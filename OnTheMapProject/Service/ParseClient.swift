//
//  ParseClient.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 1/3/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import Foundation

class ParseClient {
    
    static let parseAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let parseAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    // MARK: Parameters
    
    enum Endpoints {
        
        static let baseUrl = "https://parse.udacity.com/parse/classes/StudentLocation"
        
        case studentInfoWithLimit
        case studentInfoWithSkip
        case studentInfoWithOrder
        case studentInfoWithWhereQuery(String)
        case studentInfoWithObjectId(String)
        
        var stringValue: String {
            switch self {
            case .studentInfoWithLimit:
                return Endpoints.baseUrl + "?limit=100"
            case .studentInfoWithSkip:
                return Endpoints.baseUrl + "?limit=200&skip=400"
            case .studentInfoWithOrder:
                return Endpoints.baseUrl + "?order=-updatedAt"
            case .studentInfoWithWhereQuery(let key):
                return Endpoints.baseUrl + "?where=" + "\(key)"
            case .studentInfoWithObjectId(let objectId):
                return Endpoints.baseUrl + "/" + "\(objectId)"
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getStudentInformationList(completion: @escaping ([StudentInformation], Error?) -> Void){
        ParseClient.taskForGETRequest(url: ParseClient.Endpoints.studentInfoWithLimit.url, responseType: LocationListRequest.self) { locationList, error in
            if error == nil {
                completion((locationList?.results)!, nil)
            } else {
                completion([], error)
                print(error as Any)
            }
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(parseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(parseAPIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
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
    
    func taskForPostRequest() {
        
    }
    
    func taskForPutRequest() {
        
    }
    
    
}
