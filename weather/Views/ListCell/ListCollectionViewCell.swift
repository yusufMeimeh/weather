//
//  ListCollectionViewCell.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/13/21.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell , Reusable {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        layer.cornerRadius = 8
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }

    var list : List?{
        didSet{
            fillData()
        }
    }
    
    private func fillData(){
        guard let list = list else { return }
        timeLabel.text = list.getTimeFromTS()
        temperatureLabel.text = "\(list.main.getTempValue())"
        if let icon = list.weather.first?.icon{
            iconImageView.image = UIImage(named:icon)
        }
    }
}
