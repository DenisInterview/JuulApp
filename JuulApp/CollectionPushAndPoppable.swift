
import Foundation
import UIKit

protocol CollectionViewPushAndPoppable {
    var sourceCell: UICollectionViewCell? { get }
    var collectionView: UICollectionView! { get }
    var view: UIView! { get }
}
