import Foundation

// MARK: - Data Tranfer Object

struct UserResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case users = "results"
    }
    
    let page: Int
    let totalPages: Int
    let users: [UserDTO]
}

extension UserResponseDTO {
    struct UserDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case gender
            case name
            case email
            case createAt = "create_at"
        }
        
        enum GenderDTO: String, Decodable {
            case male
            case female
        }
        
        let id: String
        let gender: GenderDTO?
        let name: String?
        let email: String?
        let createAt: String?
    }
}

// MARK: - Mapping to Domain

extension UserResponseDTO {
    func toDomain() -> UsersPage {
        return .init(page: page, totalPage: totalPages, users: users.map({ $0.toDomain() }))
    }
}

extension UserResponseDTO.UserDTO {
    func toDomain() -> User {
        return .init(id: id, gender: gender?.toDomain(), name: name, email: email)
    }
}

extension UserResponseDTO.UserDTO.GenderDTO {
    func toDomain() -> User.Gender {
        switch self {
        case .male:
            return .male
        case .female:
            return .female
        }
    }
}
