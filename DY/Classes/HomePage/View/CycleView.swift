//
//  CycleView.swift
//  DY
//
//  Created by 满艺网 on 2017/12/20.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

let kCycleCount : Int = 10000
let kCycleCellID : String = "kCycleCellID"

class CycleView: UIView {

    fileprivate var timer : Timer?
    var cycleModels : [CycleGroupModel] = [CycleGroupModel]() {
        didSet {
            collectionView.scrollToItem(at:IndexPath(item: kCycleCount/2, section: 0),  at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
            stopTimer()
            startTimer()
            collectionView.reloadData()
        }
    }
    
    fileprivate lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kScreenW, height: kCycleViewH)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 0
        let tempCollectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: kScreenW, height: kCycleViewH) , collectionViewLayout: flowLayout)
        tempCollectionView.isPagingEnabled = true
        tempCollectionView.dataSource = self
        tempCollectionView.delegate = self
        tempCollectionView.register(UINib(nibName: "CycleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        return tempCollectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.gray
        addSubview(collectionView)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CycleView : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels.count * kCycleCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CycleCollectionViewCell
        //去除对应的值
        var totalCount = 1
        if cycleModels.count != 0 {
           totalCount = cycleModels.count
        }
        let item : Int = indexPath.item%(totalCount)
        cell.cycleModel = cycleModels[item]
        return cell
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         stopTimer()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
}

extension CycleView {
    fileprivate func startTimer() {
        timer = Timer(timeInterval: 2.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true);
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    fileprivate func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    @objc fileprivate func autoScroll() {
       var offsetX = collectionView.contentOffset.x
       offsetX += collectionView.frame.size.width
       collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
