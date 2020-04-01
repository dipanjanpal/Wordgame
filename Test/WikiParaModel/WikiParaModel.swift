

import Foundation
struct WikiParaModel : Codable {
	let paras : [String]?

	enum CodingKeys: String, CodingKey {

		case paras = "paras"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		paras = try values.decodeIfPresent([String].self, forKey: .paras)
	}

}
