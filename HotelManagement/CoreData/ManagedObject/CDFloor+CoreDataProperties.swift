

import Foundation
import CoreData


extension CDFloor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFloor> {
        return NSFetchRequest<CDFloor>(entityName: "CDFloor")
    }

    @NSManaged public var name: String?
    @NSManaged public var rooms: [CDRoom]?

}
