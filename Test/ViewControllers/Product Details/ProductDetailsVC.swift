//
//  ProductDetailsVC.swift
//  Test
//
//  Created by apple on 19/04/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    //MARK- Properties
    @IBOutlet var lblName: UILabel?
    @IBOutlet var lblOriginalPrice: UILabel?
    @IBOutlet var lblPrice: UILabel?
    @IBOutlet var lblDetails: UILabel?
    @IBOutlet var btnIncQuantity: UIButton?
    @IBOutlet var btnDecQuantity: UIButton?
    @IBOutlet var tfQuantity: UITextField?
    @IBOutlet var collSizes: UICollectionView?
    @IBOutlet var collColor: UICollectionView?

    //MARK- Variables
    var productDetails :ProductLisModel? = nil
    var quantityCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupUI() {
        btnIncQuantity?.layer.borderColor = UIColor.darkGray.cgColor
        btnIncQuantity?.layer.borderWidth = 1
        btnDecQuantity?.layer.borderColor = UIColor.darkGray.cgColor
        btnDecQuantity?.layer.borderWidth = 1
    }
    
    func setData() {
        lblName?.text = productDetails?.name
        lblPrice?.text = "QR " + (productDetails?.price!.description ?? "1000")
        lblOriginalPrice?.attributedText = "QR 799".strikeThrought()
        lblDetails?.text = productDetails?.Description
    }
    
    @IBAction func btnIncQuantityAction(sender: UIButton){
        quantityCount = quantityCount + 1
        tfQuantity?.text = quantityCount.description
    }
    
    @IBAction func btnDecQuantityAction(sender: UIButton){
        if quantityCount > 0{
            quantityCount = quantityCount - 1
            tfQuantity?.text = quantityCount.description
        }
    }
}

//MARK: - UICollectionView Delegate & Datasources -
extension ProductDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collColor{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! DetailsCollCell
            cell.viewContainer?.layer.borderWidth = 1
            cell.viewContainer?.layer.borderColor = UIColor.lightGray.cgColor
            switch indexPath.item {
            case 0:
                cell.viewContainer?.backgroundColor = UIColor.red
            case 1:
                cell.viewContainer?.backgroundColor = UIColor.blue
            case 2:
                cell.viewContainer?.backgroundColor = UIColor.green
            case 3:
                cell.viewContainer?.backgroundColor = UIColor.systemPink
            case 4:
                cell.viewContainer?.backgroundColor = UIColor.yellow
            default:
                cell.viewContainer?.backgroundColor = UIColor.orange
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sizeCell", for: indexPath) as! DetailsCollCell
            cell.lblSize?.layer.borderWidth = 1
            cell.lblSize?.layer.borderColor = UIColor.lightGray.cgColor
            switch indexPath.item {
            case 0:
                cell.lblSize?.text = "XS"
            case 1:
                cell.lblSize?.text = "S"
            case 2:
                cell.lblSize?.text = "M"
            case 3:
                cell.lblSize?.text = "L"
            case 4:
                cell.lblSize?.text = "XL"
            default:
                cell.lblSize?.text = "XXL"
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
}

// MARK: - Webservice -
extension ProductDetailsVC{
    func getProductDetails(byID :Int) {
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        ServerManager.shared.httpPost(url: "http://test.com360degree.com/apis/getProductDetails", param: ["id":byID], successHandler: { (response) in
            print(response)
            self.view.activityStopAnimating()
            if response["status"].boolValue{
                self.productDetails = ProductLisModel.init(data: response["result"])
                self.productDetails?.id = byID
                self.setData()
            }else{
                self.view.makeToast(response["error_message"].stringValue)
            }
            
        }, failureHandler: { (error) in
            self.view.activityStopAnimating()
            self.view.makeToast(error?.localizedDescription)
        }, networkHandler: { (networkIssues) in
            self.view.activityStopAnimating()
            self.view.makeToast(networkIssues)
        })
    }
}
