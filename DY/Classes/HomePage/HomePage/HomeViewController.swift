//
//  HomeViewController.swift
//  DY
//
//  Created by 满艺网 on 2017/12/14.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

let kItemMargin:CGFloat = 10
let kNormalItemW = (kScreenW - 3*kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kCycleViewH = kScreenW * 3 / 8
let kSectionTopH : CGFloat = 30
private let cellID = "cellID"

class HomeViewController: BaseViewController {



    fileprivate lazy var collectionView : UICollectionView? = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.sectionInset = UIEdgeInsets(top: kSectionTopH, left: kItemMargin, bottom: 0, right: kItemMargin)
        let tempCollectionView = UICollectionView(frame: CGRect.init(x: 0.0, y: kPageTitileH + kStatusH + kNavgatH, width: kScreenW, height: self.view.frame.size.height - (kPageTitileH + kStatusH + kNavgatH + kTabbarH)), collectionViewLayout: layout)
        tempCollectionView.backgroundColor = UIColor.white
        tempCollectionView.alwaysBounceVertical = true
        tempCollectionView.dataSource = self
        tempCollectionView.delegate = self
        tempCollectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 10, right: 0)
        tempCollectionView.register(UINib(nibName: "AnchorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        return tempCollectionView
    }()

    fileprivate lazy var pageTitleView : PageScrollTitleView = {
        let pageView = PageScrollTitleView(frame: CGRect(x: 0, y: kStatusH + kNavgatH, width: kScreenW, height: kPageTitileH), titles: ["推荐","游戏","娱乐","趣玩"])
        pageView.backgroundColor = UIColor.white
        pageView.delegate = self
        return pageView
    }()

    fileprivate lazy var cycleView : CycleView = {
        let cycleView = CycleView(frame: CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH))
        cycleView.backgroundColor = UIColor.yellow
        return cycleView
    }()

    var requestVM = RecommendViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavgationBar()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - 设置UI
extension HomeViewController {
    func setNavgationBar() {
        view.backgroundColor = UIColor.white
        let logoSize : CGSize = CGSize(width: 66, height: 26)
        let logoItem = UIBarButtonItem.init(image: "logo", highImage: "logo", size: logoSize)
        navigationItem.leftBarButtonItem = logoItem
        //
        let size : CGSize = CGSize(width: 30, height: 40)
        let historyItem = UIBarButtonItem.init(image: "image_my_history", highImage: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem.init(image: "btn_search", highImage: "btn_search_clicked", size: size)
        let scanItem = UIBarButtonItem.init(image: "Image_scan", highImage: "Image_scan_click", size: size, target: self, action: #selector(qrCode))
        navigationItem.rightBarButtonItems = [historyItem,searchItem,scanItem]
    }

    //MARK: --- 重写父类的方法
    @objc override func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        contentView = collectionView
        view.addSubview(contentView!)
        super.setupUI()
        requestVM.requestAnchorData({
            self.finishLoadData()
            self.view.addSubview(self.pageTitleView)
            self.collectionView?.addSubview(self.cycleView)
            self.cycleView.cycleModels = self.requestVM.cyclesArray
            self.collectionView?.reloadData()
        }) { (error) in
            //请求错误信息展示对应的错位展位图等信息
            self.finishLoadErrorData({
                 print("itemAny")
            })
        }
    }
}
//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return requestVM.prettyArray.count
        }
        return requestVM.anchorArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AnchorCollectionViewCell
        cell.anchor = requestVM.anchorArray[indexPath.row]
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let room = RoomPushViewController()
        navigationController?.pushViewController(room, animated: true)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

    }
}

extension HomeViewController : PageScrollTitleViewDelegate {
    func pageTitleView(_ titleView: PageScrollTitleView, selectedIndex index: Int) {
        print(index)
    }
}

//MARK: - Method
extension HomeViewController {
    @objc func qrCode() {
         let qrCodeVC = QRCodeViewController()
         navigationController?.pushViewController(qrCodeVC, animated: true)
    }
}
