//
//  FSPagerViewDataSourceObject.swift
//
//  Created by Sereivoan Yong on 5/29/21.
//

import UIKit
import UIKitAdapter
import FSPagerView

open class FSPagerViewDataSourceObject<ItemIdentifierType>: NSObject, FSPagerViewDataSource {

  public let core: ItemDataSourceCore<ItemIdentifierType>

  weak open private(set) var pagerView: FSPagerView?

  public init(core: ItemDataSourceCore<ItemIdentifierType> = .init(), pagerView: FSPagerView, cellProvider: @escaping CellProvider) {
    self.core = core
    self.pagerView = pagerView
    self.cellProvider = cellProvider
    super.init()

    pagerView.dataSource = self
  }

  open func apply(_ snapshot: ItemDataSourceSnapshot<ItemIdentifierType>) {
    core.apply(snapshot, reloadable: pagerView) { pagerView in
      pagerView.reloadData()
    }
  }

  open func snapshot() -> ItemDataSourceSnapshot<ItemIdentifierType> {
    core.snapshot()
  }

  // MARK: FSPagerViewDataSource
  open func numberOfItems(in pagerView: FSPagerView) -> Int {
    core.numberOfItems
  }

  public typealias CellProvider = (FSPagerView, Int, ItemIdentifierType) -> FSPagerViewCell?
  public let cellProvider: CellProvider
  open func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
    cellProvider(pagerView, index, core.itemIdentifier(for: index))!
  }
}
