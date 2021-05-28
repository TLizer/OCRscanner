//
//  FileManager+ImageStorage.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

extension FileManager: ImageStorage {
    private static var imageStorageDirectory: String { "Images" }
    
    enum ImageStorageError: Error {
        case failedConvertingImageToData
        case failedSavingToDisk
        case failedToGetImagesDirectory(Error)
        case failedDeletingImage(Error)
    }
    
    func save(image: UIImage) throws -> String {
        guard let data = image.pngData() else {
            throw ImageStorageError.failedConvertingImageToData
        }
        let path = "\(try imagesPath())/\(UUID().uuidString)"
        if createFile(atPath: path, contents: data) {
            return path
        }
        throw ImageStorageError.failedSavingToDisk
    }
    
    func removeImage(atPath path: String) throws {
        do {
            try removeItem(atPath: path)
        } catch {
            throw ImageStorageError.failedDeletingImage(error)
        }
    }
    
    func getImage(atPath path: String) -> UIImage? {
        UIImage(contentsOfFile: path)
    }
    
    private func imagesPath() throws -> String {
        do {
            let imagesPath = try url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(Self.imageStorageDirectory)
                .path
            if !fileExists(atPath: imagesPath) {
                try createDirectory(atPath: imagesPath, withIntermediateDirectories: true)
            }
            return imagesPath
        } catch {
            throw ImageStorageError.failedToGetImagesDirectory(error)
        }
    }
}
