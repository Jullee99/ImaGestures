//
//  ViewController.swift
//  ImaGestures
//
//  Created by DCS on 03/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let imagePicker:UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        return imagePicker
    }()
    
    private let myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "unicorn")
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myImageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapImage))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        imagePicker.delegate = self
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchImage))
        view.addGestureRecognizer(pinchGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotateImage))
        view.addGestureRecognizer(rotateGesture)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeImage))
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeImage))
        view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeImage))
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeImage))
        view.addGestureRecognizer(downSwipe)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanImage))
        view.addGestureRecognizer(panGesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         myImageView.frame = CGRect(x: 20, y: 230 , width: view.width - 40, height: 200)
    }
    
   }

extension ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if  let selectedImage = info[.originalImage] as? UIImage {
            myImageView.image = selectedImage
        }
        picker.dismiss(animated: true)
    }
    
    func  imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
}
}

extension ViewController {
    @objc private func handleTapImage(){
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true,completion: nil)
    }
    
    @objc private func handlePinchImage(_ gesture:UIPinchGestureRecognizer ) {
        myImageView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    
    @objc private func handleRotateImage(_ gesture:UIRotationGestureRecognizer ) {
        myImageView.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    
    @objc private func handleSwipeImage(_ gesture:UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            UIView.animate(withDuration: 0.2) {
                self.myImageView.frame  = CGRect(x: self.myImageView.frame.origin.x - 40, y: self.myImageView.frame.origin.y, width: 200, height: 200)
            }
        } else if gesture.direction == .right {
            UIView.animate(withDuration: 0.2) {
                self.myImageView.frame  = CGRect(x: self.myImageView.frame.origin.x + 40, y: self.myImageView.frame.origin.y, width: 200, height: 200)
            }
        } else if gesture.direction == .up {
            UIView.animate(withDuration: 0.2) {
                self.myImageView.frame  = CGRect(x: self.myImageView.frame.origin.x, y: self.myImageView.frame.origin.y - 40, width: 200, height: 200)
            }
        } else if gesture.direction == .down {
            UIView.animate(withDuration: 0.2) {
                self.myImageView.frame  = CGRect(x: self.myImageView.frame.origin.x + 40, y: self.myImageView.frame.origin.y + 40, width: 200, height: 200)
            }
        } else {
            print("Could not detect direction of swipe.")
        }
    }
    @objc private func handlePanImage(_ gesture:UIPanGestureRecognizer) {
        let x = gesture.location(in: myImageView).x
        let y = gesture.location(in: myImageView).y
        myImageView.center = CGPoint(x: x, y: y)
    }
}

