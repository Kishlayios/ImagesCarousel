//
//  DisplayImageInList.swift
//  ImagesCarousel
//
//  Created by Kishlay Kishore on 05/03/24.
//

import UIKit
import SDWebImage

class DisplayImageInList: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var imgDisplay: UIImageView!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDimensions: UILabel!
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgDisplay.layer.cornerRadius = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(data:HomeDataListModel?) {
        self.lblAuthor.text = "Author - \(data?.author ?? "")"
        self.lblDimensions.text = "Dimension - \(data?.width ?? 0) * \(data?.height ?? 0)"
        if let url = URL(string: data?.downloadURL ?? "") {
            imgDisplay.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgDisplay.sd_setImage(with: url,placeholderImage: UIImage(named: "ic_PlaceHolder")) { image, error, cacheType, imageUrl in
                self.imgDisplay.sd_imageIndicator?.stopAnimatingIndicator()
            }
        }
    }

}
