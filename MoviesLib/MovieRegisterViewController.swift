//
//  MovieRegisterViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 13/09/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit

class MovieRegisterViewController: UIViewController {

    @IBOutlet weak var tfTitle: UITextField!
    
    @IBOutlet weak var lbCategories: UILabel!
    
    @IBOutlet weak var tfRating: UITextField!
    
    @IBOutlet weak var tfDuration: UITextField!
    
    @IBOutlet weak var tfSummary: UITextView!
 
    @IBOutlet weak var ivPoster: UIImageView!
    
    @IBOutlet weak var btAddUpdate: UIButton!
 
    
    @IBAction func close(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func addUpdateMovie(_ sender: UIButton) {
    
        if movie == nil {
        
            movie = Movie(context: context)
        }
    
    }
    
    
    
    var movie: Movie!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}