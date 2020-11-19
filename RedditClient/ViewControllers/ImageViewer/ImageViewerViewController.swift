//
//  ImageViewerViewController.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 19.11.2020.
//

import UIKit

final class ImageViewerViewController: UIViewController {
    
    var successAction: (() -> Void)?
    var imageURL: String?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView() {
        guard let url = imageURL else { return }
        imageView.setImage(by: url)
    }
    
    private func save(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self,
            #selector(image(_:didFinishSavingWithError:contextInfo:)), nil) 
    }
    
    @objc func image(_ image: UIImage,
        didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print(error)
        } else {
            showAlert()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Success", message: "Image was saved", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { [weak self] (_) in
            self?.successAction?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let image = imageView.image else { return }
        save(image: image)
    }
    
}
