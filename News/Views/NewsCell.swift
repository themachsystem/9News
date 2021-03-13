//
//  NewsCell.swift
//  News
//
//  Created by Alvis Mach on 12/3/21.
//

import UIKit
import SDWebImage
let newsCellIdentifier = "NewsArticleCell"

class NewsCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.addShadow()
    }
    
    func configureCell(with viewModel: NewsArticleCellViewModel) {
        headlineLabel.text = viewModel.headline
        byLineLabel.text = viewModel.byLine
        abstractLabel.text = viewModel.theAbstract
        let imageUrl = URL(string: viewModel.imageUrl)
        thumbnailImageView.sd_setImage(with: imageUrl,
                                       placeholderImage: nil,
                                       options: .retryFailed,
                                       completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        headlineLabel.text = nil
        byLineLabel.text = nil
        abstractLabel.text = nil
    }

}
