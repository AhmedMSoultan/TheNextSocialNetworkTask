//
//  LoginResponse.swift
//  TheNextBigSocialNetwork
//
//  Created by Ahmed Soultan on 15/03/2023.
//

import Foundation
import Alamofire

class NetworkLayer {
    
   static let shared = NetworkLayer()
   private init () {}
    
    //MARK: VARIABLES
    let userDefaults = UserDefaults.standard
    var token = ""
    var headers: HTTPHeaders?
    
    //MARK: AUTH
    private func getToken() {
        token = userDefaults.string(forKey: "UserToken") ?? ""
        
        headers = [
            "Authorization": "Bearer " + token
        ]
    }
    
    //MARK: GET
    func get<T> (endPoint: EndPoint, className: T.Type, completionHandler: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        getToken()
        AF.request(endPoint.url, headers: headers).validate().responseDecodable (of: T.self) { response in
            switch response.result {
            case .success:
                guard let data = response.value else {return}
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func get<T> (endPoint: EndPoint, className: T.Type, param: Parameters, completionHandler: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        getToken()
        AF.request(endPoint.url,parameters: param,headers: headers).validate().responseDecodable (of: T.self){ response in
            switch response.result {
            case .success:
                guard let data = response.value else {return}
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

//MARK: POST
extension NetworkLayer {
    func post<T> (endpoint: EndPoint ,className: T.Type, params: [String:Any] ,completionHandler: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        getToken()
        AF.request(endpoint.url, method: .post ,parameters: params, headers: headers).validate().responseDecodable (of: T.self){ response in
            switch response.result {
            case .success:
                guard let data = response.value else {return}
                completionHandler(.success(data))
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            }
        }
    }
}

//MARK: DELETE
extension NetworkLayer {
    func delete<T>(endpoint: EndPoint , className: T.Type, completionHandler: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        getToken()
        AF.request(endpoint.url, method: .post, headers: headers ).validate().responseDecodable (of: T.self){ response in
            switch response.result {
            case .success:
                guard let data = response.value else {return}
                completionHandler( .success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}


//MARK: PUT
extension NetworkLayer {
    func put<T> (endpoint: EndPoint ,className: T.Type, params: [String:Any] ,completionHandler: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        getToken()
        AF.request(endpoint.url, method: .post ,parameters: params, headers: headers).validate().responseDecodable (of: T.self){ response in
            switch response.result {
            case .success:
                guard let data = response.value else {return}
                completionHandler(.success(data))
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            }
        }
    }
}

//MARK: Upload
//extension NetworkLayer {
//    
//    func upload<T>(endPoint: EndPoint, responseModel: T.Type, method: HTTPMethod, param: [String:Any], img: ImageData?, completionHandler: @escaping (T?,Double?)->() ) where T : Decodable {
//        getToken()
//        AF.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append( img?.imgData ?? Data() , withName: "img" , fileName: img?.imgName ?? "", mimeType: "image/jpg")
//            for (key, value) in param {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
//            }
//        }, to: endPoint.url , method: method , headers: headers) .uploadProgress { progress in
//                  completionHandler(nil,progress.fractionCompleted)
//            
//        }.responseDecodable(of: T.self) { response in
//            completionHandler(response.value,nil)
//        }
//    }
//}

//MARK: LOGIN
extension NetworkLayer {
    func login<T> (endpoint: EndPoint ,className: T.Type, params: [String:Any] ,completionHandler: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        getToken()
        AF.request(endpoint.url, method: .post ,parameters: params).validate().responseDecodable (of: T.self){ response in
            switch response.result {
            case .success:
                guard let data = response.value else {return}
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
