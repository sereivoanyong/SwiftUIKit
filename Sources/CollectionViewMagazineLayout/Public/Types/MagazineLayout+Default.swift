// Created by bryankeller on 10/18/18.
// Copyright © 2018 Airbnb, Inc.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

extension MagazineLayout {

  /// Constants for layout sizing and spacing defaults.
  public enum Defaults {

    public static let itemSizeMode = MagazineLayoutItemSizeMode(
      widthMode: .fullWidth(respectsHorizontalInsets: true),
      heightMode: MagazineLayoutItemHeightMode.static(height: itemHeight))
    public static let headerVisibilityMode = MagazineLayoutHeaderVisibilityMode.hidden
    public static let footerVisibilityMode = MagazineLayoutFooterVisibilityMode.hidden
    public static let backgroundVisibilityMode = MagazineLayoutBackgroundVisibilityMode.hidden

    public static let itemHeight: CGFloat = 150
    public static let headerHeight: CGFloat = 44
    public static let footerHeight: CGFloat = 44
    public static let horizontalSpacing: CGFloat = 0
    public static let verticalSpacing: CGFloat = 0
    public static let sectionInsets: UIEdgeInsets = .zero
    public static let itemInsets: UIEdgeInsets = .zero

  }

}
