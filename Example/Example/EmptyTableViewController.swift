//
//  EmptyTableViewController.swift
//  Example
//
//  Created by Sereivoan Yong on 4/30/21.
//

import UIKit
import SwiftUIKit

final class EmptyTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  enum Content {

    case data(Int)
    case empty
    case error(Error)
  }

  private let defaultRowCount: Int = 3
  private var tableView: UITableView!
  private var emptyView: EmptyView!
  private var content: Content = .empty

  init() {
    super.init(nibName: nil, bundle: nil)

    let segmentedControl = UISegmentedControl(items: ["Non-empty", "Empty", "Error"])
    segmentedControl.selectedSegmentIndex = 1
    segmentedControl.addTarget(self, action: #selector(reload(_:)), for: .valueChanged)
    navigationItem.titleView = segmentedControl
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)

    emptyView = EmptyView()
    emptyView.dataSource = self
    emptyView.stateProvider = self
    tableView.emptyView = emptyView
  }

  @objc private func reload(_ segmentedControl: UISegmentedControl) {
    switch segmentedControl.selectedSegmentIndex {
    case 0:
      content = .data(defaultRowCount)
      navigationItem.rightBarButtonItems = [
        UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(insertRow(_:))),
        UIBarButtonItem(title: "-", style: .plain, target: self, action: #selector(deleteRow(_:))),
      ]

    case 1:
      content = .empty
      navigationItem.rightBarButtonItems = nil

    case 2:
      content = .error(URLError(.notConnectedToInternet)) // This `URLError` is just an example
      navigationItem.rightBarButtonItems = nil

    default:
      fatalError()
    }
    tableView.reloadData()
  }

  @objc private func insertRow(_ sender: UIBarButtonItem) {
    if case .data(let count) = content {
      if count < defaultRowCount {
        content = .data(count + 1)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
      }
    } else {
      content = .data(0)
      tableView.reloadData()
    }
  }

  @objc private func deleteRow(_ sender: UIBarButtonItem) {
    if case .data(let count) = content {
      if count > 0 {
        content = .data(count - 1)
        tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
      }
    } else {
      content = .data(defaultRowCount)
      tableView.reloadData()
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch content {
    case .data(let count):
      return count
    default:
      return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
    cell.textLabel?.text = String(indexPath.row)
    return cell
  }
}

extension EmptyTableViewController: EmptyViewStateProviding {

  func state(for emptyView: EmptyView) -> EmptyView.State? {
    switch content {
    case .data(let count):
      return count > 0 ? nil : .empty
    case .empty:
      return .empty
    case .error(let error):
      return .error(error)
    }
  }
}

extension EmptyTableViewController: EmptyViewDataSource {

  func emptyView(_ emptyView: EmptyView, configureContentFor state: EmptyView.State) {
    switch state {
    case .empty:
      emptyView.title = "No Data"

    case .error(let error):
      emptyView.title = "Unable to Load"
      emptyView.message = error.localizedDescription
    }
  }
}
