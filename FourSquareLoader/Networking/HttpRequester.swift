//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

enum APIError: Error {
    case httpError(_ response: String)
}

typealias RemoteCompeltion<T: Decodable> = (T) -> Void
typealias ErrorHandler = (String) -> Void

class HttpRequester {
    var urlSession =  URLSession.shared
    private let AUTH = "fsq3HfLRA+Xn6j/suQwgnl34nVW0xA4LN+I/XrR0O1EBPw8="
    private let PROTOCOL = "https"
    private let HOST = Bundle.main.infoDictionary!["APP_HOST"] as! String
                                      
                                      
    func get<T: Decodable>(endPoint: String, queryItems: [URLQueryItem]? = nil, remoteObject: T.Type, success: @escaping RemoteCompeltion<T>, fail: @escaping ErrorHandler) {
        var components = URLComponents()
        components.scheme = PROTOCOL
        components.host = HOST
        components.path = endPoint
        if let items = queryItems{
            components.queryItems = items
        }
        guard let url = components.url else {
            fatalError("URL not defined correcly: \(components.url!.path)")
        }
        var request = URLRequest(url: url)
        let headers = [
          "Accept": "application/json",
          "Authorization": AUTH
        ]
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        urlSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    fail(String(describing: error))
                }
                else if (response as! HTTPURLResponse).statusCode != 200 {
                    fail("Status code : \((response as! HTTPURLResponse).statusCode)")
                }
                else if let data = data {
                    do {
                        debugPrint(String(data: data, encoding: .utf8) ?? "no data")
                        let decoded = try JSONDecoder().decode(remoteObject, from: data)
                        success(decoded)
                    } catch let DecodingError.dataCorrupted(context) {
                        fail(Localizable.error_occurred)
                        debugPrint(context.debugDescription)
                    } catch let DecodingError.keyNotFound(key, context) {
                        fail(Localizable.error_occurred)
                        debugPrint("Key '\(key)' not found: \(context.debugDescription)")
                        fail(Localizable.error_occurred)
                        debugPrint("codingPath: \(context.codingPath)")
                    } catch let DecodingError.valueNotFound(value, context) {
                        fail(Localizable.error_occurred)
                        debugPrint("Value '\(value)' not found: \(context.debugDescription)")
                        fail(Localizable.error_occurred)
                        debugPrint("codingPath: \(context.codingPath)")
                    } catch let DecodingError.typeMismatch(type, context) {
                        fail(Localizable.error_occurred)
                        debugPrint("Type '\(type)' mismatch: \(context.debugDescription)")
                        fail(Localizable.error_occurred)
                        debugPrint("codingPath: \(context.codingPath)")
                    } catch {
                        fail(Localizable.error_occurred)
                        debugPrint("error: \(error.localizedDescription)")
                    }
                }
            }
        }.resume()
    }
}
