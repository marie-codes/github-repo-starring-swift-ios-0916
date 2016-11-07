//
//  FISGithubAPIClient.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    typealias JSON = [String: Any]
    //func with completion handler
    
    static func getRepositories(with completion: @escaping ([JSON]) -> Void) {
        //creating a URL from String and initialise
        //        let urlString = Github.baseURL + "/repositories" + "?client_id=\(clientID)" + "&client_secret=\(clientSecret)"
        
        let urlString = "https://api.github.com/repositories?client_id=\(clientID)&client_secret=\(clientSecret)"
        
        print(urlString)
        
        //if in fact the initialiser returns back a instance of the string, else, return (means get out of here)
        guard let url = URL(string: urlString) else { return }
        
        //create instance of URLSession with a default configuration
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: url)
        
        //adding a heading, that tells it a key, value pair that gives a specific instruction
        //request.addValue(<#T##value: String##String#>, forHTTPHeaderField: <#T##String#>)
        
        //if a function takes in a String, need to give instance of string, same with Int, and same with another function
        //using trailing and closing syntax
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                    //                    dump(responseJSON)
                    completion(responseJSON)
                } catch let error {
                    
                    print(error.localizedDescription)
                    
                }
                
                
                
            }
        }
        task.resume()
    }
    
    static func checkIfRepositoryIsStarred(_ fullName: String, completion: @escaping (Bool) -> Void) {
        let urlString = "https://api.github.com/user/starred/\(fullName)?access_token=\(token)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            print("string to url conversion failed")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                print("response downcast to httpurlresponse failed.")
                return
            }
            
            if response.statusCode == 204 {
                completion(true)
            } else if response.statusCode == 404 {
                completion(false)
            }
        }
        dataTask.resume()
    }
    
    static func starRepository(named fullName: String, completion: @escaping () -> Void) {
        let urlString = "https://api.github.com/user/starred/\(fullName)?access_token=\(token)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            print("string to url conversion failed")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                print("response downcast to httpurlresponse failed.")
                return
            }
            
            if response.statusCode == 204 {
                completion()
            }
        }
        
        dataTask.resume()
    }
    
    static func unstarRepository(named fullName: String, completion: @escaping () -> Void) {
        let urlString = "https://api.github.com/user/starred/\(fullName)?access_token=\(token)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            print("string to url conversion failed")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                print("response downcast to httpurlresponse failed.")
                return
            }
            
            if response.statusCode == 204 {
                completion()
            }
        }
        
        dataTask.resume()
        
    }
}



//let secret = Secrets.sharedInstance
//
//class func getRepositories(with completion: ([[String: Any]]) -> Void) {
//    let urlString = "https://api.github.com/repositories?client_id=\(secret.clientID)&client_secret=\(secret.clientSecret)"
//    // URL object
//    let url = URL(string: urlString)
//
//    // Start URL Session
//    if let url = url {
//        let session = URLSession.shared
//
//        // DataTask object
//        let task = session.dataTask(with: url) { (data, response, error) in
//            if let data = data {
//                do {
//                    let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
//
//                    dump(responseJSON)
//                    //completion(responseJSON)
//                } catch {
//                    print("Something didn't work")
//                }
//            }
//        }
//
//        task.resume()
//    }
//
//}
//
