//
//  ScannerListCoordinator.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

protocol ScannerListCoordinatorProtocol: AnyObject {
    func presentImagePicker(handler: @escaping (UIImage?) -> Void)
    func presentScanDetails(_ scan: OCRScanData)
}

final class ScannerListCoordinator: Coordinator, ScannerListCoordinatorProtocol {
    private let navigationController: UINavigationController
    private var imagePickerCoordinator: ImagePickerCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = ScanerListViewController()
        let ocrDataService = OCRDataService(coreDataStack: OCRCoreDataStack(), imageStorage: FileManager.default)
        let ocrEngine = TesseractOCREngine()
        controller.viewModel = ScannerListViewModel(
            coordinator: self,
            dataProvider: ocrDataService,
            ocrEngine: ocrEngine
        )
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
    
    func presentScanDetails(_ scan: OCRScanData) {
        let controller = ScanDetailsViewController()
        controller.scan = scan
        navigationController.pushViewController(controller, animated: true)
    }
}
