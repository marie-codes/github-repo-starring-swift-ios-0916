//
//  FISReposDataStore.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
    static let sharedInstance = ReposDataStore()
    
    var repositories: [GithubRepository] = []
    
    func getRepositories(handler: @escaping (Bool) -> Void) {
        repositories.removeAll()
        GithubAPIClient.getRepositories { repos in
            
            for dictionary in repos {
                let newRepo = GithubRepository(dictionary: dictionary)
                self.repositories.append(newRepo)
            }
            if self.repositories.isEmpty {
                handler(false)
            } else {
                handler(true)
            }
        }
    }
    
    func toggleStarStatus(for repo: GithubRepository, completion: @escaping (Bool) -> Void) {
        let fullName = repo.fullName
        
        GithubAPIClient.checkIfRepositoryIsStarred(fullName) { (starred) in
            if starred {
                GithubAPIClient.unstarRepository(named: fullName) {
                    completion(false)
                }
            } else {
                GithubAPIClient.starRepository(named: fullName) {
                    completion(true)
                }
            }
        }
        
    }
}
