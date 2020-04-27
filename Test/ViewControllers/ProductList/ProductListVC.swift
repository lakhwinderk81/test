//
//  ProductListVC.swift
//  Test
//
//  Created by apple on 19/04/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductListVC: UIViewController {
    
    //Outlets
    @IBOutlet var collProducts: UICollectionView?
    @IBOutlet var lblProductCount: UILabel?
    
    //Variables
    var arrayProducts = [ProductLisModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getProductList()
        // Do any additional setup after loading the view.
    }
    
}

//MARK: - Collection View Delegate & Datasource -
extension ProductListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productListCell", for: indexPath) as! productListCell
        let imageURl :URL = URL.init(string: "" + arrayProducts[indexPath.item].image!) ?? URL.init(string: "")!
        cell.imgProduct?.af_setImage(withURL: imageURl)
        cell.lblName?.text = arrayProducts[indexPath.item].name
        cell.lblPrice?.text = "QR " + arrayProducts[indexPath.item].price!.description
        cell.lblOriginalPrice?.attributedText = "QR 799".strikeThrought()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/2 - 5
        return CGSize.init(width: width, height: width + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailsVc = self.storyboard?.instantiateViewController(identifier: "ProductDetailsVC") as! ProductDetailsVC
        productDetailsVc.getProductDetails(byID: arrayProducts[indexPath.item].id ?? 0)
        self.navigationController?.pushViewController(productDetailsVc, animated: true)
    }
}

//MARK: - Webservice -
extension ProductListVC{
    func getProductList() {
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        ServerManager.shared.httpget(url: "http://test.com360degree.com/apis/getProductList", successHandler: { (response) in
            self.view.activityStopAnimating()
            let products = response.arrayValue
            self.arrayProducts.removeAll()
            for product in products{
                self.arrayProducts.append(ProductLisModel.init(data: product))
            }
            self.collProducts?.reloadData()
            self.lblProductCount?.attributedText = "\(self.arrayProducts.count) Products".attributedString(nonBoldRange: NSRange.init(location: "\(self.arrayProducts.count) Products".count - 8, length: 8))
        }, failureHandler: { (error) in
            self.view.activityStopAnimating()
            self.view.makeToast(error?.localizedDescription)
        }) { (networkIssues) in
            self.view.activityStopAnimating()
            self.view.makeToast(networkIssues)
        }
    }
}
