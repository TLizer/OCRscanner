//
//  TesseractOCREngine.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit
import TesseractOCR

final class TesseractOCREngine: OCREngine {
    private lazy var tesseract: G8Tesseract? = {
        let tesseract = G8Tesseract(language: "eng+pol")
        tesseract?.engineMode = .tesseractOnly
        tesseract?.pageSegmentationMode = .auto
        return tesseract
    }()
    
    func analyze(image: UIImage, completion: @escaping (String?) -> Void) {
        guard let tesseract = self.tesseract else {
            completion(nil)
            return
        }
        tesseract.image = image
        DispatchQueue.global(qos: .userInitiated).async {
            tesseract.recognize()
            completion(tesseract.recognizedText)
        }
    }
}
