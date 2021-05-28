//
//  ImagePickerCoordinator.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit
import MobileCoreServices

final class ImagePickerCoordinator: NSObject, Coordinator {
    private let presenter: UIViewController
    private let resultCallback: (UIImage?) -> Void
    
    init(presenter: UIViewController, resultCallback: @escaping (UIImage?) -> Void) {
        self.presenter = presenter
        self.resultCallback = resultCallback
    }
    
    func start() {
        let controller = UIAlertController(
            title: "Select image source",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(
                title: "Camera",
                style: .default,
                handler: { (alert) -> Void in
                    self.presentCamera()
                }
            )
            controller.addAction(cameraButton)
        }
        
        let libraryButton = UIAlertAction(
            title: "Photo library",
            style: .default,
            handler: { (alert) -> Void in
                self.presentImagePicker()
            }
        )
        controller.addAction(libraryButton)
        
        let cancelButton = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: { _ -> Void in
                self.resultCallback(nil)
            }
        )
        controller.addAction(cancelButton)

        presenter.present(controller, animated: true)
    }
    
    private func presentCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [kUTTypeImage as String]
        presenter.present(imagePicker, animated: true)
    }
    
    private func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        presenter.present(imagePicker, animated: true)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedPhoto = info[.originalImage] as? UIImage
        presenter.dismiss(animated: true) {
            self.resultCallback(selectedPhoto)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        presenter.dismiss(animated: true) {
            self.resultCallback(nil)
        }
    }
}
