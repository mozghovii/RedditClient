//
//  TopFeedTableViewCell.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import UIKit

protocol TopFeedTableViewCellDelegate: AnyObject {
    func imagePressed(_ imageURl: String)
}

final class TopFeedTableViewCell: UITableViewCell, Identifiable {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    weak var delegate: TopFeedTableViewCellDelegate?
    
    var model: FeedDataModel? {
        didSet {
            guard let feedModel = model?.data else { return }
            titleLabel.text = feedModel.title
            authorLabel.text = feedModel.author
            entryDateLabel.text = feedModel.entryDate
            numberOfCommentsLabel.text = feedModel.numbersOfComments
            if let stringUrl = feedModel.thumbnail, stringUrl.isHttp {
                thumbnailImageView.setImage(by: stringUrl)
            } else {
                thumbnailImageView.image = nil
            }
            
        }
    }
    
    @IBAction func imagePressed(_ sender: Any) {
        guard let feedModel = model?.data,
              let stringUrl = feedModel.thumbnail,
              stringUrl.isHttp else { return }
        delegate?.imagePressed(stringUrl)
        
    }
}
