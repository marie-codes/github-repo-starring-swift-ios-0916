//
//  FISReposTableViewController.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    var store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.accessibilityLabel = "tableView"
        
        store.getRepositories { (success) in
            if success {
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        store.getRepositories { success in
//            
//            if success {
//                print ("Yay")
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
        let repo = store.repositories[indexPath.row]
        
        cell.textLabel?.text = repo.fullName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = store.repositories[indexPath.row]
        
        store.toggleStarStatus(for: repo) { (justStarred) in
            let alertController = UIAlertController(title: "GitHub", message: nil, preferredStyle: .alert)
            
            if justStarred {
                alertController.message = "You just starred \(repo.fullName)"
            } else {
                alertController.message = "You just unstarred \(repo.fullName)"
            }
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
