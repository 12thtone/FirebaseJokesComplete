//
//  DataService.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _JOKE_REF = Firebase(url: "\(BASE_URL)/jokes")
    //    private var _VOTE_REF: Firebase!
    //    private var _USERNAME_REF: Firebase!
    
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    var JOKE_REF: Firebase {
        return _JOKE_REF
    }
    /*
    var VOTE_REF: Firebase {
    return _VOTE_REF
    }*/
    
    var USERNAME_REF: Firebase {
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath("username")
        
        return currentUser!
    }
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        USER_REF.childByAppendingPath(uid).setValue(user)
    }
    
    func createNewJoke(joke: Dictionary<String, AnyObject>) {
        
        // Save the Joke
        let firebaseNewJoke = JOKE_REF.childByAutoId()
        firebaseNewJoke.setValue(joke)
        
        // Save User as the Author of the Joke
        let postId = firebaseNewJoke.key
        let author = CURRENT_USER_REF.childByAppendingPath("jokes").childByAppendingPath(postId)
        author.setValue(true)
    }
}