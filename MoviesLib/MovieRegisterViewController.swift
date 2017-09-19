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
 
    
    @IBAction func close(_ sender: UIButton?) {
        
        if movie != nil && movie.title == nil{
        
            context.delete(movie)
            
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func AddPoster(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Selecionar poster", message: "De onde voce quer escolher o postoer", preferredStyle: .actionSheet)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {(actions) in
                self.selecPicture(sourceType: .camera)
            
            })
            alert.addAction(cameraAction)
            
            
        }
        
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default, handler: {(actions) in
            self.selecPicture(sourceType: .photoLibrary)
            
        })
        alert.addAction(libraryAction)
        
        
        let photoAlbum = UIAlertAction(title: "Biblioteca de fotos", style: .default, handler: {(actions) in
            self.selecPicture(sourceType: .savedPhotosAlbum)
            
        })
        alert.addAction(photoAlbum)
        
        
        
        let cancelAction = UIAlertAction(title: "cancelar", style: .default, handler: nil)
        
        
        alert.addAction(cancelAction)
        present(alert, animated: true, completion:  nil)
    
    
    }
    
    func selecPicture(sourceType: UIImagePickerControllerSourceType){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func addUpdateMovie(_ sender: UIButton) {
    
        if movie == nil {
        
            movie = Movie(context: context)
            
        }
        
        movie.title = tfTitle.text
        movie.rating = Double(tfRating.text!)!
        movie.summary = tfSummary.text
        movie.duration = tfDuration.text
        
        do{
            try context.save()
            
        }catch{
            print(error.localizedDescription)
        }
        close(nil)
    
    }
    
    
    
    var movie: Movie!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if movie != nil {
            tfTitle.text = movie.title
            tfRating.text = "\(movie.rating)"
            tfDuration.text = movie.duration
            tfSummary.text = movie.summary
            btAddUpdate.setTitle("Atualizar", for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if movie != nil{
            
            
                    lbCategories.text = movie.categoriesLabel
                    
            
        
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc  = segue.destination as! CategoriesViewController
        
        if movie == nil{
            movie = Movie(context: context)
            
        }
        
        vc.movie = movie
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension MovieRegisterViewController : UIImagePickerControllerDelegate, UINavigationBarDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String: AnyObject]) {
        
        ivPoster.image = image
        dismiss(animated: true, completion: nil)
        
    }

}
