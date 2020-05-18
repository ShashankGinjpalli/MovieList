//
//  EditView.swift
//  MovieList
//
//  Created by Shashank Ginjpalli on 11/2/19.
//  Copyright © 2019 Shashank Ginjpalli. All rights reserved.
//

import UIKit

class EditView: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imgSource: UISegmentedControl!
    
    var movieImageDat:Data?
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        movieImage.layer.cornerRadius = 15
        saveButton.layer.cornerRadius = 15
        editButton.layer.cornerRadius = 15
        
        movieImage.image = UIImage(data: movieImageDat ?? Data())
        // Do any additional setup after loading the view.
    }

    @IBAction func editImage(_ sender: Any) {
      if imgSource.selectedSegmentIndex == 0{
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerController.SourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: nil)
            } else {
                print("No camera")
            }
        }else{
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
        }
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
    
         let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
         picker.dismiss(animated: true, completion: nil)
         movieImage.image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
     }
     
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true, completion: nil)
     }
    
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
          return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
      }
      
      fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
          return input.rawValue
      }
    
}

