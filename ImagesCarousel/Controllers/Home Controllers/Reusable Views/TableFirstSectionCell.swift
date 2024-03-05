//
//  TableFirstSectionCell.swift
//  ImagesCarousel
//
//  Created by Kishlay Kishore on 05/03/24.
//

import UIKit

protocol ImagesCardViewTrigger: AnyObject {
    func particularCardTapped(data: Any)
}

class TableFirstSectionCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: - Variables
    weak var delegate: ImagesCardViewTrigger?
    var currentIndex = 0
    var arrImageList = [HomeDataListModel]()
    
    // MARK: - View Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionViewInit()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Helper methods
    func setupCollectionViewInit() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionCell")
    }
    
    func reloadInnerSetup(data: [HomeDataListModel]) {
        self.arrImageList = data
        self.collectionView.reloadData()
    }

}

// MARK: - collection View DataSource Methods
extension TableFirstSectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionCell
        cell.setupData(data: arrImageList[indexPath.item])
        return cell
    }
}

// MARK: - Collection View Delegate Methods
extension TableFirstSectionCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            self.pageControl.currentPage = indexPath.item
            currentIndex = indexPath.item
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        
        self.pageControl.currentPage = indexPath.item
        currentIndex = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //code
    }
}

// MARK: - Collection View DelegateFlowLayouts Methods
extension TableFirstSectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = (collectionView.frame.width - 16) / 1.33
        return CGSize(width: width, height: height)
    }
}
