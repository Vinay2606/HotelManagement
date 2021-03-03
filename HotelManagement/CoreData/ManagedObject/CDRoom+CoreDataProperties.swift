

import Foundation
import CoreData


extension CDRoom {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRoom> {
        return NSFetchRequest<CDRoom>(entityName: "CDRoom")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var floor: CDFloor?
    @NSManaged public var guestentry: String?
}
