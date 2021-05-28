//
//  ScannerListViewModel.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

final class ScannerListViewModel {
    private let dateFormatter = DateFormatter()
    private unowned var coordinator: ScannerListCoordinatorProtocol
    private let dataProvider: OCRDataProvider
    private let ocrEngine: OCREngine
    private var scans: [OCRScanData] = []
    
    var reloadTableView: (() -> Void)? {
        didSet {
            reloadData()
        }
    }
    
    var isLoading: ((Bool) -> Void)?
    
    init(coordinator: ScannerListCoordinatorProtocol, dataProvider: OCRDataProvider, ocrEngine: OCREngine) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.ocrEngine = ocrEngine
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
    }
    
    func addScan() {
        coordinator.presentImagePicker(handler: { [ocrEngine, isLoading] selectedImage in
            guard let image = selectedImage else {
                return
            }
            isLoading?(true)
            ocrEngine.analyze(image: image) { [weak self] recognizedText in
                self?.handleScan(image: image, text: recognizedText)
            }
        })
    }
    
    func deleteScan(at IndexPath: IndexPath) {
        dataProvider.removeScan(scans[IndexPath.row]) { [weak self] in
            self?.reloadData()
        }
    }
    
    func displayDetails(for indexPath: IndexPath) {
        coordinator.presentScanDetails(scans[indexPath.row])
    }
    
    func numberOfRows() -> Int {
        scans.count
    }
    
    func data(for indexPath: IndexPath) -> String {
        let date = scans[indexPath.row].date
        return dateFormatter.string(from: date)
    }
    
    private func handleScan(image: UIImage, text: String?) {
        dataProvider.addScan(text: text, image: image) { [weak self] scan in
            self?.reloadData()
            if let scan = scan {
                self?.coordinator.presentScanDetails(scan)
            }
        }
    }
    
    private func reloadData() {
        scans = dataProvider.scans()
        reloadTableView?()
        isLoading?(false)
    }
}
