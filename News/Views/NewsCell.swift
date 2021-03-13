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
    
    /**
     * Configures cell's UIs from the view model data.
     */
    func configureCell(with viewModel: NewsArticleCellViewModel) {
        headlineLabel.text = viewModel.headline
        byLineLabel.text = viewModel.byLine
        abstractLabel.text = viewModel.theAbstract
        
        if let imageUrl = viewModel.imageUrl,
           let url = URL(string: imageUrl) {
            thumbnailImageView.sd_setImage(with: url,
                                           placeholderImage: UIImage(named: "placeholder"),
                                           options: .refreshCached,
                                           completed: nil)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        headlineLabel.text = nil
        byLineLabel.text = nil
        abstractLabel.text = nil
    }

}
