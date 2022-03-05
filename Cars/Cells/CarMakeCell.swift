//
//  CarMakeCell.swift
//  Cars
//
//  Created by Mohamed Hashem on 23/02/2022.
//

import UIKit

class CarMakeCell: UITableViewCell {

    @IBOutlet weak var carName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(name: String) {
        carName.text = name
    }
}
