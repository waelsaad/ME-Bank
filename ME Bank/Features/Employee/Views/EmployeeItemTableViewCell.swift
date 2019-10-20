//
//  EmployeeItemTableViewCell.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import UIKit
import Foundation

protocol EmployeeItemTableViewCellDelegate: class {
    
}

final class EmployeeItemTableViewCell: FoldingCell, ViewWithNib, Reusable {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var birthDateLabel: UILabel!
    
    @IBOutlet var detailCellfirstNameLabel: UILabel!
    @IBOutlet var detailCelllastNameLabel: UILabel!
    @IBOutlet var detailCellbirthDateLabel: UILabel!
    @IBOutlet var detailCellGenderLabel: UILabel!
    
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var largePhotoImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    // MARK: - Configure View
    
    func configure(with displayModel: EmployeeItemDisplayModel) {
        self.displayModel = displayModel
        nameLabel.text = displayModel.name
        genderLabel.text = displayModel.gender
        birthDateLabel.text = displayModel.dateOfBirth
        
        // Solve an issue where the cell initially has an incorrect image
        thumbnailImageView.image = #imageLiteral(resourceName: "Employee")
        largePhotoImageView.image = #imageLiteral(resourceName: "Employee")
        
        if let url = displayModel.thumbnailUrl {
            thumbnailImageView.load(url: url)
        }
        
        if let url = displayModel.largeImageUrl {
            largePhotoImageView.load(url: url)
        }
        
        detailCellfirstNameLabel.text = displayModel.firstName
        detailCelllastNameLabel.text = displayModel.lastName
        detailCellbirthDateLabel.text = displayModel.dateOfBirth
        detailCellGenderLabel.text = displayModel.gender
    }
    
    var displayModel: EmployeeItemDisplayModel!
    weak var delegate: EmployeeItemTableViewCellDelegate?
}

// MARK: - Actions ⚡️

extension EmployeeItemTableViewCell {
    @IBAction func buttonHandler(_: AnyObject) {
        print("tap")
    }
}
