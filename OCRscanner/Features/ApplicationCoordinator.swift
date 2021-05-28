//
//  ApplicationCoordinator.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    private let window: UIWindow
    private lazy var navigationController = UINavigationController()
    private var scannerListCoordintor: ScannerListCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        scannerListCoordintor = ScannerListCoordinator(navigationController: navigationController)
        scannerListCoordintor?.start()
    }
}
