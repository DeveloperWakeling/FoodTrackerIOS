//
//  ViewController.swift
//  FoodTracker
//
//  Created by Michael Wakeling on 4/21/18.
//  Copyright © 2018 Michael Wakeling. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Handle the text field's user input through delegate callbacks
        foodNameTextField.delegate = self
    }

    //MARK: Actions
    @IBAction func setDefaultText(_ sender: UIButton) {
        foodNameLabel.text = "Default Text"
    }
    @IBAction func selectImageFromPhotos(_ sender: UITapGestureRecognizer) {
        //Hide the keyboard
        foodNameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view Controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        //Only allow images to be picked not taken
        imagePickerController.sourceType = .photoLibrary
        //Make sure ViewController is notified when user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if the user cancels
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Basically once the textfield's focus has been ended
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Gets called after the textfield removes its firstResponder (loses focus)
        foodNameLabel.text = textField.text
    }

}

