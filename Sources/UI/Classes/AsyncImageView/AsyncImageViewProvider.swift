import Foundation
import UIKit

public protocol AsyncImageViewProvider: Sendable {
    func fetchImage() async -> UIImage?
}
