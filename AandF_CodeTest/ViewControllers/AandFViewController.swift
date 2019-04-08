//
//  ViewController.swift
//  AandF_CodeTest
//
//  Created by Timotin Ion on 3/20/19.
//  Copyright © 2019 Timotin. All rights reserved.
//

import UIKit

class AandFViewController: UIViewController {
    var productItems : [Product] = []
    @IBOutlet private weak var productsTableView: UITableView!
    
    convenience init(product: Product){
        self.init()
        let products : [Product] = [product]
        self.productItems = products
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Product.hotProducts { (results:[Product]) in
            self.productItems = results
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
            }
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = productsTableView.indexPathForSelectedRow {
            productsTableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    
}

extension AandFViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return productItems.isEmpty ? 0 : productItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        if !productItems.isEmpty{
            let product = productItems[indexPath.row]
            productCell.title = product.title
            productCell.backgroundImage = product.backgroundImage
            productCell.content = product.content
            productCell.promoMessage = product.promoMessage
            productCell.topDescription = product.topDescription
            productCell.bottomDescription = product.bottomDescription
        }
        return productCell
    }
}

extension AandFViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productItems[indexPath.row]
        let target = product.content[0].target!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let objViewController = UIApplication.topViewController()!
        let vc = storyboard.instantiateViewController(withIdentifier: "PageViewControllerID") as? PageViewController
        vc?.url = target
        objViewController.navigationController?.pushViewController(vc!, animated: true)
    }
}
