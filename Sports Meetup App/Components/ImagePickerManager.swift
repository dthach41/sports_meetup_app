//
//  ImagePickerManager.swift
//  Sports Meetup App
//
//  Created by Jack Huang on 12/3/24.
//

import UIKit
import PhotosUI

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
    private var viewController: UIViewController
    private var imagePickedHandler: ((UIImage?) -> Void)?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func presentImagePicker(completion: @escaping (UIImage?) -> Void) {
        self.imagePickedHandler = completion
        let menu = UIMenu(title: "Select Image", children: [
            UIAction(title: "Camera", handler: { _ in self.pickUsingCamera() }),
            UIAction(title: "Gallery", handler: { _ in self.pickPhotoFromGallery() })
        ])
        let alert = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in self.pickUsingCamera() })
        alert.addAction(UIAlertAction(title: "Gallery", style: .default) { _ in self.pickPhotoFromGallery() })
        
        viewController.present(alert, animated: true)
    }
    
    private func pickUsingCamera() {
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.delegate = self
        viewController.present(cameraController, animated: true)
    }
    
    private func pickPhotoFromGallery() {
        let config = PHPickerConfiguration(photoLibrary: .shared())
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        viewController.present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        viewController.dismiss(animated: true)
        results.first?.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
            DispatchQueue.main.async {
                self.imagePickedHandler?(image as? UIImage)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        viewController.dismiss(animated: true)
        let image = info[.originalImage] as? UIImage
        imagePickedHandler?(image)
    }
}
