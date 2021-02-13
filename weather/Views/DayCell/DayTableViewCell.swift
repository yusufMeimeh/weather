//
//  DayTableViewCell.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/13/21.
//

import UIKit

class DayTableViewCell: UITableViewCell , Reusable {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerNibs()
    }
    
    private func registerNibs(){
        collectionView.register(reusable: ListCollectionViewCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var group : ListGroup?{
        didSet{
            fillData()
        }
    }
    
    private func fillData(){
        guard let group = group else { return }
        dayLabel.text = group.list.first?.getDayFromTS() ?? group.day
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}

extension DayTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
        cell.list = group?.list[indexPath.item]
        return cell
    }
    
    
}

extension DayTableViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 82, height: 114)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}
