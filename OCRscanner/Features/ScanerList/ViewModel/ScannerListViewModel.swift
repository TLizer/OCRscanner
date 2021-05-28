//
//  ScannerListViewModel.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import Foundation

final class ScannerListViewModel {
    private unowned var scannerListCoordinator: ScannerListCoordinatorProtocol
    private var scans: [String] = ["SCAN1", "SCAN2"]
    
    var reloadCallback: (() -> Void)? {
        didSet {
            reloadCallback?()
        }
    }
    
    init(scannerListCoordinator: ScannerListCoordinatorProtocol) {
        self.scannerListCoordinator = scannerListCoordinator
    }
    
    func addScan() {
        scannerListCoordinator.presentImagePicker(handler: { selectedImage in
            print("DEBUG - handle selected image: \(selectedImage)")
        })
    }
    
    func displayDetails(for indexPath: IndexPath) {
        // display details
    }
    
    func numberOfRows() -> Int {
        scans.count
    }
    
    func data(for indexPath: IndexPath) -> String {
        scans[indexPath.row]
    }
}
