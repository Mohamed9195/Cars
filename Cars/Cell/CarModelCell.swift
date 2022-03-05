//
//  CarModelCell.swift
//  Cars
//
//  Created by Mohamed Hashem on 23/02/2022.
//

import UIKit

class CarModelCell: UITableViewCell {
    
    @IBOutlet weak var carModelView: UIView!
    @IBOutlet weak var carModelImg: UIImageView!
    @IBOutlet weak var carModelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carModelView.clipsToBounds = true
        carModelView.layer.cornerRadius = 10
    }
    
}
