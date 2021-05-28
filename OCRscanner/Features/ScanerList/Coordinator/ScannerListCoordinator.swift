//
//  ScannerListCoordinator.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

protocol ScannerListCoordinatorProtocol: AnyObject {
    func presentImagePicker(handler: @escaping (UIImage?) -> Void)
}

final class ScannerListCoordinator: Coordinator, ScannerListCoordinatorProtocol {
    private let navigationController: UINavigationController
    private var imagePickerCoordinator: ImagePickerCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = ScanerListViewController()
        controller.viewModel = ScannerListViewModel(scannerListCoordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func presentImagePicker(handler: @escaping (UIImage?) -> Void) {
        imagePickerCoordinator = ImagePickerCoordinator(
            presenter: navigationController,
            resultCallback: { [weak self] selectedImage in
                handler(selectedImage)
                self?.imagePickerCoordinator = nil
        })
        imagePickerCoordinator?.start()
    }
}
