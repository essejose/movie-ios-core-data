//
//  Movie+Categories.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 18/09/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import Foundation
import CoreData

extension Movie {
    var categoriesLabel : String{
        
        
        if let categories = categories {
        
            return categories.map({( $0 as! Category ).name!}).sorted().joined(separator: " | ")
        
        }
        
        return ""
        
    }
    
}
