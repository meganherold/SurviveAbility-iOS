import UIKit

class Captain {
    public var name: String
    public var id: Int?
    public var photo: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
    
    init(name: String, photo: UIImage?) {
        self.name = name
        self.photo = photo
    }
}

extension Captain : Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
    }
}
