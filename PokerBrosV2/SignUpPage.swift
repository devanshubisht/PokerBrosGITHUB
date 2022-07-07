//
//  SignUpPage.swift
//  PokerBrosV2
//
//  Created by Devanshu Bisht on 25/5/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage




class SignUpPage: UIViewController {

    @IBOutlet weak var FirstNameText: UITextField!
    
    @IBOutlet weak var LastNameText: UITextField!
    
    @IBOutlet weak var EmailText: UITextField!
    
    @IBOutlet weak var PasswordText: UITextField!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAvatar()
        
        HideError()
    }
    
    func setupAvatar(){
        
        ProfileImage.layer.cornerRadius = 40
        ProfileImage.clipsToBounds = true
        ProfileImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self , action: #selector(presentPicker))
        ProfileImage.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
        
    func HideError(){
        ErrorLabel.alpha = 0 
    }
    
    func validateFields() -> String?{
        
        // Check that all fields are filled in
        if FirstNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        return nil
        
    }
 
    
    @IBAction func SignUpTapped(_ sender: Any) {
        
        guard let imageSelected = self.image else{
            showError("Profile Picture not available")
            // show error
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            return
            
        }
        
        let err = validateFields()
        
        if err != nil {
            
            // There's something wrong with the fields, show error message
            showError(err!)
        }
        else {
            
            let firstName = FirstNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err ) in
                
                if err != nil{
                    self.showError("Error creating user")
                }
                else {
                    let storageRef = Storage.storage().reference(forURL: "gs://artermis-poker-bros.appspot.com/")
                    let storageProfileRef = storageRef.child("profile").child(result!.user.uid)
                    
                    let metadata = StorageMetadata()
                    
                    metadata.contentType = "image/jpg"
                    storageProfileRef.putData(imageData, metadata: metadata) { (storageMetaData, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                            return
                        }
                        
                        storageProfileRef.downloadURL { (url, error) in
                            if let metaImageUrl = url?.absoluteString{
                                
                                let db = Firestore.firestore()
                                db.collection("users").document(result!.user.uid).setData(
                                    ["fullname" : firstName,
                                     "username" : lastName,
                                     "uid": result!.user.uid,
                                     "ProfileImageUrl": metaImageUrl,
                                     "requests":[],
                                     "friends": [],
                                     "email": email]
                                ) { (error) in
                                    
                                    if error != nil {
                                        // Show error message
                                        self.showError("Error saving user data")
                                    }
                                }
                            }
                        }
                    }
             
                    // Transition to Home screen
                    self.transitionToHome()
                }
        }
        
    }
    }
    
    
    func showError(_ message:String) {
        
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    
    
    func transitionToHome() {
        let homeViewController =
        storyboard?.instantiateViewController(identifier:
        Constants.Storyboard.homeViewController) as?
        HomePage
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
        
        
    
    
}

extension SignUpPage : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as?
            UIImage {
            image = imageSelected
            ProfileImage.image = imageSelected
            
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage{
            image = imageOriginal
            ProfileImage.image = imageOriginal
        }
        picker.dismiss(animated: true, completion: nil)
    }
    }
