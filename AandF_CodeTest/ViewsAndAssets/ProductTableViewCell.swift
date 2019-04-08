//
//  ProductTableViewCell.swift
//  AandF_CodeTest
//
//  Created by Timotin Ion on 3/21/19.
//  Copyright © 2019 Timotin. All rights reserved.
//

import UIKit

class ProductTableViewCell : UITableViewCell {
    public var topDescription: String? {
        didSet {
            topDescritionLabel?.text = topDescription
        }
    }
    
    public var bottomDescription: String? {
        didSet {
            bottomDescriptionLabel?.text = bottomDescription
        }
    }
    
    public var title: String? {
        didSet {
            titleLabel?.text = title
        }
    }
    
    public var promoMessage: String? {
        didSet {
            promoMessageLabel?.text = promoMessage
        }
    }
    
    public var backgroundImage: String? {
        didSet {
            if let backgroundImage = backgroundImage {
                backgorundImageView.isHidden = false
               
                backgorundImageView.loadImageUsingCacheWithURLString(backgroundImage, placeHolder: nil){ (bool) in
                    self.backgorundImageView.translatesAutoresizingMaskIntoConstraints = false
                    
                        let height = self.backgorundImageView.image!.size.height * self.backgorundImageView.frame.width / self.backgorundImageView.image!.size.width
                    
                        self.imageHeightLayoutContraints.constant = height
                        self.stackView.setNeedsLayout()
                }
            }else{
                backgorundImageView.isHidden = true
            }
        }
    }
    
    
    
    public var content : [Content]? {
        didSet {
            if let button = self.buttonShopWommen {
                button.isHidden = true
            }
            if let button = self.buttonMenOrNowShop {
                    button.isHidden = true
            }
            
            if let content = content {
                var count = 0
                for element in content {
                    if let title = element.title, let buttonW = self.buttonShopWommen, let buttonM = self.buttonMenOrNowShop {
                        if count == 1{
                            buttonW.isHidden = false
                        }else{
                            buttonM.setTitle(title, for: .normal)
                            buttonM.isHidden = false
                        }
                    }
                    if let target = element.target {
                        if count == 1{
                            self.targetWomen = target
                        }else{
                            self.targetMenAndNow = target
                        }
                    }
                    count += 1
                }
            }
        }
    }
    
    
    

    @IBAction func onWomenPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let objViewController = UIApplication.topViewController()!
        let vc = storyboard.instantiateViewController(withIdentifier: "PageViewControllerID") as? PageViewController
        vc?.url = targetWomen
        objViewController.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func onNowPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let objViewController = UIApplication.topViewController()!
        let vc = storyboard.instantiateViewController(withIdentifier: "PageViewControllerID") as? PageViewController
        vc?.url = targetMenAndNow
        objViewController.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBOutlet private weak var backgorundImageView: UIImageView!
    @IBOutlet private weak var topDescritionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var promoMessageLabel: UILabel!
    @IBOutlet private weak var bottomDescriptionLabel: UILabel!
    @IBOutlet private weak var buttonMenOrNowShop : UIButton!
    @IBOutlet private weak var buttonShopWommen : UIButton!
    private var targetMenAndNow = String()
    private var targetWomen = String()
    @IBOutlet weak var imageHeightLayoutContraints: NSLayoutConstraint!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        topDescription = nil
        title = nil
        promoMessage = nil
        bottomDescription = nil
        buttonShopWommen = nil
        buttonMenOrNowShop = nil
        backgroundImage = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
