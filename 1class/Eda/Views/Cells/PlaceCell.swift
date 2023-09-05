//
//  PlaceCell.swift
//  Eda
//
//  Created by kost ant on 04.07.2018.
//  Copyright © 2018 kost. All rights reserved.
//

import UIKit
import RxSwift

class PlaceCell: UITableViewCell {
    
    static let imageWidth: CGFloat = 100
    static let imageHeight: CGFloat = 75
    
    var disposeBag = DisposeBag()
    
    @IBOutlet private weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageWidthConstraint.constant = PlaceCell.imageWidth
        imageHeightConstraint.constant = PlaceCell.imageHeight
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
