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
    
    var heights = [IndexPath: CGFloat]()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        internalInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }
    
    private func internalInit() {
        
        tableFooterView = UIView()
        
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 100.0
        
        rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        dataSourceObservable = RxTableViewSectionedAnimatedDataSource<GenericSectionModel>(configureCell: { [unowned self] (dataSource, table, indexPath, _) -> UITableViewCell in
            return self.generic(tableView: table, withData: dataSource, cellForRowAt: indexPath)
        })
    }
    
    func configure(with data: GenericTableViewData) {
        
        data.sections
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.items(dataSource: dataSourceObservable))
            .disposed(by: disposeBag)
        
        rx.itemSelected
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                data[indexPath]?.wasSelected.onNext(indexPath)
                self?.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
        
        rx.willDisplayCell
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] cell, indexPath in
                self?.heights[indexPath] = cell.frame.size.height
            })
            .disposed(by: disposeBag)
    }
    
    private func generic(tableView table: UITableView,
                         withData dataSource: RxDataSources.TableViewSectionedDataSource<GenericSectionModel>,
                         cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return dataSource[indexPath].cellModel.configureCell(in: table, for: indexPath)
    }
    
}

extension GenericTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath] ?? UITableView.automaticDimension
    }
}
