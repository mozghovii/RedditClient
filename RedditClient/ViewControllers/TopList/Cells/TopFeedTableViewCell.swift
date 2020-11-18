//
//  TopFeedTableViewCell.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import UIKit

class TopFeedTableViewCell: UITableViewCell, Identifiable {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var model: FeedDataModel? {
        didSet {
            guard let feedModel = model?.data else { return }
            titleLabel.text = feedModel.title
            authorLabel.text = feedModel.author
            entryDateLabel.text = feedModel.entryDate
            numberOfCommentsLabel.text = feedModel.numbersOfComments
            if let stringUrl = feedModel.thumbnail, stringUrl.isHttp {
               thumbnailImageView.setImage(by: stringUrl)
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
