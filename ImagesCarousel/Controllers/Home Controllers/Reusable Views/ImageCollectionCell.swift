//
//  ImageCollectionCell.swift
//  BookList
//
//  Created by Kishlay Kishore on 29/02/24.
//

import UIKit
import SDWebImage

class ImageCollectionCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgCarousel: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    // MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.setBackViewShadow()
            self.imgCarousel.layer.cornerRadius = 16.0
        }
    }
    
    // MARK: - Helper Methods
    func setBackViewShadow() {
        self.shadowView.setShadowWithColor(color: #colorLiteral(red: 0.4862745098, green: 0.4862745098, blue: 0.4862745098, alpha: 0.4422746599), opacity: 1, offset: CGSize(width: -1, height: 2), radius: 3, viewCornerRadius: 16)
    }
    
    func setupData(data: HomeDataListModel?) {
        if let url = URL(string: data?.downloadURL ?? "") {
            imgCarousel.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgCarousel.sd_setImage(with: url,placeholderImage: UIImage(named: "ic_PlaceHolder")) { image, error, cacheType, imageUrl in
                self.imgCarousel.sd_imageIndicator?.stopAnimatingIndicator()
            }
        }
    }

}
