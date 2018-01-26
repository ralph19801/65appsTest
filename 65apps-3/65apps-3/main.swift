//
//  main.swift
//  65apps-3
//
//  Created by Garafutdinov Ravil on 20/01/2018.
//  Copyright © 2018 RG. All rights reserved.
//

import Foundation
import Alamofire

func requestRepos(url: String) -> Void {
    
    guard !url.isEmpty else {
        print("No repos url")
        exit(0)
    }
    
    Alamofire.request(url).responseJSON { response in
        if let json = response.result.value {
            if let reposArray = json as? Array <Any> {
                guard !reposArray.isEmpty else {
                    print("User has no repos")
                    exit(0)
                }
                
                print("Repos count: \(reposArray.count)\n")
                
                for singleRepo in reposArray {
                    if let repoDict = singleRepo as? Dictionary <String, Any> {
                        if let repoName = repoDict["name"] as? String {
                            print(repoName)
                        }
                    }
                }
            }
        }
        
        print("")
        exit(0)
    }
}

func requestUser(userQuery: String) {
    
    guard !userQuery.isEmpty else {
        print("Empty user query")
        exit(0)
    }

    let escapedQuery = userQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    guard !(escapedQuery?.isEmpty)! else {
        print("Escaped query is empty")
        exit(0)
    }
    
    Alamofire.request("https://api.github.com/search/users?q=" + escapedQuery!).responseJSON { response in
        if let json = response.result.value {
            if let dict = json as? Dictionary <String, AnyObject> {
                if let itemsArray = dict["items"] as? Array <AnyObject> {
                    if let itemsDict = itemsArray.first as? Dictionary <String, AnyObject> {
                        if let login = itemsDict["login"] as? String {
                            print("User found: " + login)
                        }
                        if let repos = itemsDict["repos_url"] as? String {
                            requestRepos(url: repos)
                        }
                    }
                }
            }
        }
    }
}

guard CommandLine.arguments.count > 1 else {
    print("Usage: ./65apps-3 username")
    exit(0)
}

requestUser(userQuery: CommandLine.arguments[1])
RunLoop.main.run()
