//
//  Food.swift
//  FoodTracker
//
//  Created by Michael Wakeling on 4/22/18.
//  Copyright © 2018 Michael Wakeling. All rights reserved.
//

import UIKit

class Food {
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int){
        //If there is no name or rating the initialization should fail
        guard !name.isEmpty else {
            return nil
        }
        
        //Rating must be between 0 and 5
        guard (rating >= 0 && rating <= 5) else {
            return nil
        }
        
        //Iniitialize Stored Properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
