//
//  GenericTableView.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class GenericTableView: UITableView {

    var dataSourceObservable: RxTableViewSectionedAnimatedDataSource<GenericSectionModel>!
    private let mainDisposeBag = DisposeBag()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        internalInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }
    
    public func setDataSourceObservable(sections: Observable<[GenericSectionModel]>) {
        
        sections
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.items(dataSource: dataSourceObservable))
            .disposed(by: mainDisposeBag)
        
//        rx.willDisplayCell
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] cell, indexPath in
//                self?.heights[indexPath] = cell.frame.size.height
//            })
//            .disposed(by: mainDisposeBag)
        
//        data.sectionsToUpdate
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] indexes, animated in
//                if animated {
//                    self?.reloadSections(indexes, animationStyle: .automatic)
//                    return
//                }
//                //The block without animaition will make the reloading of section more stable
//                UIView.performWithoutAnimation {
//                    self?.reloadSections(indexes, animationStyle: .fade)
//                }
//            })
//            .disposed(by: mainDisposeBag)
    }
    
    
//
//    dataSourceObservable.animationConfiguration = AnimationConfiguration(insertAnimation: data.animation,
//    reloadAnimation: data.animation,
//    deleteAnimation: data.animation)
    
    private func internalInit() {
        
        dataSourceObservable = RxTableViewSectionedAnimatedDataSource<GenericSectionModel>(configureCell: { [unowned self] (dataSource, table, indexPath, _) -> UITableViewCell in
            return self.generic(tableView: table, withData: dataSource, cellForRowAt: indexPath)
        })
    }
    
    private func generic(tableView table: UITableView,
                         withData dataSource: RxDataSources.TableViewSectionedDataSource<GenericSectionModel>,
                         cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return dataSource[indexPath].cellModel.configureCell(in: table, for: indexPath)
    }
    
}
