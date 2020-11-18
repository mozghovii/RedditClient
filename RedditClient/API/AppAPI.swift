//
//  AppAPI.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import Foundation

class AppAPI: API {
    
    struct ApiResponseDefault: Decodable {
        let success: Bool
        let error: String?
    }
    
    private var configuration: APIConfiguration
    private var defaultSession: URLSession
    private var environment: APIEnvironment = .staging
    
    
    required init(with configuration: APIConfiguration) {
        self.configuration = configuration
        // set current environment
        defaultSession = URLSession(configuration: .default)
    }
    
    func setEnvironment(_ environment: APIEnvironment) {
        self.environment = environment
    }
    
    func send<T>(_ request: T, completion: @escaping ResultCallback<T.Response>) where T: APIRequest {
        
        let endpoint = self.endpoint(for: request)
        let method = request.method
        let parameters = request.parameters()
        let encoding = request.parameterEncoding
        let preparedRequest = prepareRequest(endpoint, method: method, parameters: parameters, encoding: encoding)
        
        let task = defaultSession.dataTask(with: preparedRequest!, completionHandler: {(data, response, error) -> () in
            if let error = error {
                completion(.failure(error))
            }  else if let data = data {
                if T.Response.self == APIResponseEmpty.self,
                    let data = try? self.configuration.decoder.decode(T.Response.self, from: "{}".data(using: .utf8) ?? Data()) {
                    completion(.success(data))
                    return
                }
                // response with data
                do {
                    let data = try self.configuration.decoder.decode(T.Response.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            }
        })
        
        task.resume()
    }
}

// MARK: - Helpers

extension AppAPI {
    
    private func prepareRequest(_ url: URL,
                                method: HTTPMethod = .get,
                                parameters: Any? = nil,
                                encoding: ParameterEncoding = URLEncoding()) -> URLRequest? {
        var originalRequest: URLRequest?
        
        do {
            originalRequest = URLRequest(url: url)
            originalRequest?.httpMethod = method.rawValue
            var encodedURLRequest: URLRequest?
            
            if let urlEncoding = encoding as? URLEncoding, let parameters = parameters as? Parameters {
                encodedURLRequest = try urlEncoding.encode(originalRequest!, with: parameters)
            } else {
                assertionFailure("Encoding method with these parameters is incorrect")
                return nil
            }
            
            return encodedURLRequest
        } catch {
            assertionFailure(error.localizedDescription)
            return nil
        }
    }
    
    private func endpoint<T>(for request: T) -> URL where T: APIRequest {
        guard let baseUrl = URL(string: request.path, relativeTo: configuration.getBaseEndpointURL(environment: environment)) else {
            fatalError("Bad resourceName: \(request.path)")
        }
        
        guard let components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else {
            fatalError("Bad url components: \(request.path)")
        }
        
        guard let url = components.url else {
            fatalError("Problem with final endpoint url")
        }
        
        return url
    }
    
}
