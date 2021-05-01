//
//  RootViewController.swift
//  Example
//
//  Created by Sereivoan Yong on 4/30/21.
//

import UIKit
import SwiftUIKit

final class RootViewController: UITableViewController {

  enum ExampleType: CaseIterable {

    case emptyCollectionView
    case emptyTableView
  }

  let types: [ExampleType] = ExampleType.allCases

  init() {
    super.init(nibName: nil, bundle: nil)

    title = "SwiftUIKit Example"
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    if #available(iOS 13.0, *) {
      view.backgroundColor = .systemBackground
    } else {
      view.backgroundColor = .white
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return types.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
    let type = types[indexPath.row]
    switch type {
    case .emptyCollectionView:
      cell.textLabel?.text = "Empty Collection View"
    case .emptyTableView:
      cell.textLabel?.text = "Empty Table View"
    }
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let type = types[indexPath.row]
    switch type {
    case .emptyCollectionView:
      show(EmptyCollectionViewController(), sender: tableView.cellForRow(at: indexPath))

    case .emptyTableView:
      show(EmptyTableViewController(), sender: tableView.cellForRow(at: indexPath))
    }
  }
}
