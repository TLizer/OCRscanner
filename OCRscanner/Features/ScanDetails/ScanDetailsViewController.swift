//
//  ScanDetailsViewController.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

final class ScanDetailsViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let label = UILabel()
    private let imageView = UIImageView()
    
    var scan: OCRScanData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = scan.text
        let image = UIImage(contentsOfFile: scan.imagePath)
        imageView.image = image
        setupViews()
    }
    
    private func setupViews() {
        title = "Scan details"
        
        view.addSubview(scrollView)
        view.backgroundColor = .white
        scrollView.frame = view.bounds
        
        scrollView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        if let size = imageView.image?.size {
            let aspectRatio = size.height / size.width
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio).isActive = true
        }
        
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = view.bounds.width
        imageView.contentMode = .scaleAspectFit
    }
}
