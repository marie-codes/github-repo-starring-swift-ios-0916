//
//  FISGithubRepository.swift
//  github-repo-list-swift
//
//  Created by susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubRepository {
    let fullName: String
    let htmlURL: URL
    let repositoryID: String
    
    init(dictionary: [String: Any]) {
        fullName = dictionary["full_name"] as! String
        htmlURL = URL(string: dictionary["html_url"] as! String)!
        repositoryID = String(dictionary["id"] as! Int)
    }
}

extension GithubRepository: CustomStringConvertible{
    var description: String{
        return "Full Name: \(fullName), HTMLurl: \(htmlURL), RepoID: \(repositoryID)"
    }
    
}

